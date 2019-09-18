import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_mall/widget/LoadingWidget.dart';
import '../services/ScreenAdapter.dart';
import '../config/Config.dart';
import '../mode/ProductModel.dart';

class ProductListPage extends StatefulWidget {
  final Map arguments;

  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // 控制侧边栏
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // 上拉加载更多控制器
  ScrollController _scrollController = ScrollController();

  List _productList = [];
  int _page = 1;
  int _pageSize = 8;
  String _sort = '';
  bool _canLoading = true;
  bool _hasMore = true;
  bool _hasData = true;
  int _selectedSubHeaderId = 1;
  List _subHeaderList = [
    {'id': 1, 'title': '综合', 'fileds': 'all', 'sort': -1},
    {'id': 2, 'title': '销量', 'fileds': 'salecount', 'sort': -1},
    {'id': 3, 'title': '价格', 'fileds': 'price', 'sort': -1},
    {'id': 4, 'title': '筛选'}
  ];
  String _cid;
  String _keyword;

  //配置search搜索框的值

  var _initKeywordsController= new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //赋路由传过来的值,方便后面使用
    this._cid = widget.arguments["cid"];
    this._keyword = widget.arguments["keyword"];

    //给search框框赋值
    this._initKeywordsController.text = this._keyword;

    // 获取商品列表数据
    _getProductList();

    // 监听列表滚动
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 30) {
        if (this._canLoading && this._hasMore) {
          this._getProductList();
        }
      }
    });
  }

  _getProductList() async {
    setState(() {
      this._canLoading = false;
    });
    String api;
    if(this._cid!=null){
      api = '${Config.domain}api/plist?cid=${this._cid}&page=$_page&pageSize=$_pageSize&sort=$_sort';
    }else{
      api = '${Config.domain}api/plist?search=${this._keyword}&page=$_page&pageSize=$_pageSize&sort=$_sort';
    }
    print(api);
    var response = await Dio().get(api);
    var product = ProductModel.fromJson(response.data);

    int productLength = product.result.length;

    // 根据第一次访问得到的数据数量来判断是否有数据,多次更改搜索关键词需要else来处理
    if(productLength == 0 && this._page == 1){
      this._hasData = false;
    }else{
      this._hasData = true;
    }

    // 判断数据是否有 设置的条数来判断是否还有更多数据（万一最后一页数据数量刚刚好是设置的条数，就会多加载一下，还是要用total来判断）
    if (productLength == this._pageSize) {
      setState(() {
        this._productList.addAll(product.result);
        this._page++;
        this._canLoading = true;
      });
    } else {
      setState(() {
        this._productList.addAll(product.result);
        this._hasMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: ScreenAdapter.height(68),
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, 0.8), borderRadius: BorderRadius.circular(30)),
          child: TextField(
            controller: _initKeywordsController,
            autofocus: true,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
            onChanged: (value){
              this._keyword = value;
            },
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              width: ScreenAdapter.height(80),
              height: ScreenAdapter.height(68),
              child: Row(
                children: <Widget>[
                  Text('搜索')
                ],
              ),
            ),
            onTap: (){
              this._selectSubHeader(1);
            },
          )
        ],
      ), // 隐藏左上的默认按钮
      endDrawer: Drawer(
          child: Container(
        child: Text("实现筛选功能"),
      )),
      body: this._hasData ? Stack(
        children: <Widget>[
          this._productListWidget(),
          this._subHeaderWidget(),
        ],
      ): Center(child: Text('毫无数据...'),),
    );
  }

  void _selectSubHeader(int id) {
    if (id == 4) {
      _scaffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectedSubHeaderId = id;
      });
    } else {
      setState(() {
        this._selectedSubHeaderId = id;
        // 点击切换当前sort: -1*-1=1， 1*-1=-1
        this._subHeaderList[id - 1]['sort'] = this._subHeaderList[id - 1]['sort'] * -1;
        // 拼接排序字段值
        this._sort = this._subHeaderList[id-1]['fileds'] + '_${this._subHeaderList[id-1]['sort']}';
        // 重置各种值，重新获取数据
        this._page = 1;
        this._hasMore = true;
        this._canLoading = true;
        this._productList = [];
        // 把数据清空 貌似不用跳到顶部了
        // _scrollController.animateTo(0, duration: Duration(milliseconds:1000),curve: Curves.ease);
        // _scrollController.jumpTo(0);
        this._getProductList();
      });
    }
  }

  Widget _showIcon(id){
    if(id==2 || id==3){
      print(this._subHeaderList[id-1]['sort']);
      if(this._subHeaderList[id-1]['sort'] == -1){
        return Icon(Icons.arrow_drop_down);
      }else {
        return Icon(Icons.arrow_drop_up);
      }
    }
    return Text('');
  }

  //筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(88),
      width: ScreenAdapter.width(750),
      child: Container(
        width: double.infinity,
        height: ScreenAdapter.height(88),
        // color: Colors.red,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
          children: this._subHeaderList.map((value) {
            return Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Text("${value['title']}",textAlign: TextAlign.center,
                          style: TextStyle(color: _selectedSubHeaderId == value['id'] ? Colors.red : Colors.black54)),
                          _showIcon(value['id'])
                      ])
                    ),
                onTap: () {
                  this._selectSubHeader(value['id']);
                }
              )
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _showMore(index) {
    if (_hasMore) {
      return index == this._productList.length - 1 ? LoadingWidget() : Text('');
    } else {
      return index == this._productList.length - 1 ? Text('——加载完毕——') : Text('');
    }
  }

  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: ScreenAdapter.height(88)),
          child: ListView.builder(
              controller: _scrollController,
              itemCount: this._productList.length,
              itemBuilder: (context, index) {
                String pic = Config.domain + this._productList[index].pic.toString().replaceAll('\\', '/');
                return Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(180),
                          height: ScreenAdapter.height(180),
                          child: Image.network(
                            pic,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: ScreenAdapter.height(180),
                              margin: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${this._productList[index].title}", maxLines: 2, overflow: TextOverflow.ellipsis),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: ScreenAdapter.height(36),
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.fromLTRB(10, 3, 10, 0),

                                        //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color.fromRGBO(230, 230, 230, 0.9),
                                        ),

                                        child: Text("4g"),
                                      ),
                                      Container(
                                        height: ScreenAdapter.height(36),
                                        margin: EdgeInsets.only(right: 10),
                                        padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Color.fromRGBO(230, 230, 230, 0.9),
                                        ),
                                        child: Text("126"),
                                      ),
                                    ],
                                  ),
                                  Text("${this._productList[index].price}", style: TextStyle(color: Colors.red, fontSize: 20))
                                ],
                              ),
                            ))
                      ],
                    ),
                    Divider(height: 26),
                    _showMore(index)
                  ],
                );
              }));
    } else {
      return LoadingWidget();
    }
  }
}
