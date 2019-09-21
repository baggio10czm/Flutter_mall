import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../config/Config.dart';
// 广播引入
import '../../services/EventBus.dart';

class ProductContentFirst extends StatefulWidget {
  final _productContentItem;

  ProductContentFirst(this._productContentItem, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin {
  List attr = [];
  String _selectAttrData ='';
  var actionEventBus;

  // 在pageView 和 TabBarView子页面里继承 AutomaticKeepAliveClientMixin 设置 wantKeepAlive = true 就可以缓存页面
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attr = widget._productContentItem.attr;
    _makeAttrList();
    // 所选属性
    _makeSelectAttrData();
    //监听ProductContentEvent广播
    actionEventBus = eventBus.on<ProductContentEvent>().listen((event){
      print(event);
      this._attrBottomSheet();
    });
    // 监听所有广播 去掉  <ProductContentEvent>
    //eventBus.on().listen((event){
    //  print(event);
    //});
  }

  //组件销毁时，一定要取消广播监听
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    actionEventBus.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String pic = Config.domain + widget._productContentItem.pic.toString().replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.fromLTRB(
          ScreenAdapter.width(18),
          ScreenAdapter.width(18),
          ScreenAdapter.width(18),
          ScreenAdapter.width(88)),
      child: ListView(
        children: <Widget>[
          // 图
          AspectRatio(aspectRatio: 16 / 9, child: Image.network(pic, fit: BoxFit.cover)),
          // 标题
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${widget._productContentItem.title}",
                    style: TextStyle(color: Colors.black87,fontSize: ScreenAdapter.size(32)),),
                SizedBox(height: ScreenAdapter.height(8)),
                Text("${widget._productContentItem.subTitle}",
                    style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.size(28))),
              ],
            )
          ),
          // 价格
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Text('特价'),
                        Text('￥${widget._productContentItem.price}',
                            style: TextStyle(color: Colors.red,fontSize: ScreenAdapter.size(36)))
                      ]
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('原价'),
                        Text('￥${widget._productContentItem.oldPrice}',
                          style: TextStyle(color: Colors.black26,fontSize: ScreenAdapter.size(26),decoration: TextDecoration.lineThrough),
                        )
                      ]
                    ))
              ],
            ),
          ),
          // 规格
          Container(
            child: Column(
              children: <Widget>[
                this.attr.length>0?Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
                    height: ScreenAdapter.height(66),
                    child: InkWell(
                      onTap: () {
                        _attrBottomSheet();
                      },
                      child: Row(
                        children: <Widget>[
                          Text("已选: ",style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_selectAttrData)
                        ],
                      ),
                    )):Text(''),
                Divider(),
                Container(
                  height: ScreenAdapter.height(66),
                  child: Row(
                    children: <Widget>[
                      Text("运费: ",style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("满68元免运费")
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 制作 attr 数据集合
  void _makeAttrList(){
    for (var i = 0; i < attr.length; ++i) {
      for (var j = 0; j < attr[i].list.length; ++j) {
        attr[i].attrList.add({
          'title': attr[i].list[j],
          'checked': j==0?true:false,
        });
      }
    }
  }

  // 属性Widget
  List<Widget> _makeAttrWidget(setBottomSheetStatus) {
    var list = attr.map((item) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: ScreenAdapter.width(120),
                padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                child: Text('${item.cate}:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Expanded(flex: 1, child: Wrap(children: this._attrItemWidget(item.cate,item.attrList,setBottomSheetStatus)))
          ],
        ),
      );
    });
    return list.toList();
  }

  // 改变属性处理
  void _changeAttrSelect(attrList, title,setBottomSheetStatus){
    setBottomSheetStatus(() {
      // 方式① 传 cate 来对比找到对应 attrList
      // for (var i = 0; i < attr.length; ++i) {
      //   if(attr[i].cate == cate){
      //     for (var j = 0; j < attr[i].attrList.length; ++j) {
      //       if(attr[i].attrList[j]['title'] == title){
      //         attr[i].attrList[j]['checked'] = true;
      //       }else{
      //         attr[i].attrList[j]['checked'] = false;
      //       }
      //     }
      //   }
      // }
      // 方式② 直接传 attrList 过来直接处理
      for (var i = 0; i < attrList.length; ++i) {
        if(attrList[i]['title'] == title){
          attrList[i]['checked'] = true;
        }else{
          attrList[i]['checked'] = false;
        }
      }
    });
  }

  // 计算选中属性值
  void _makeSelectAttrData(){
    var tmpList = [];
    for (var i = 0; i < attr.length; ++i) {
      for (var j = 0; j < attr[i].attrList.length; ++j) {
        if(attr[i].attrList[j]['checked']){
          tmpList.add(attr[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      _selectAttrData = tmpList.join(',');
    });
  }

  // 属性子项目Widget  注意 attrList 前面要+List才能map
  List<Widget> _attrItemWidget(cate,List attrList,setBottomSheetStatus) {
    return attrList.map((item) {
      return Container(margin: EdgeInsets.only(left: ScreenAdapter.width(12), right: ScreenAdapter.width(12)),
          child: InkWell(
            onTap: (){
              this._changeAttrSelect(attrList,item['title'],setBottomSheetStatus);
              this._makeSelectAttrData();
            },
            child: Chip(
                label: Text('${item['title']}'),
                padding: EdgeInsets.all(6),
                backgroundColor: item['checked'] ? Colors.redAccent:Colors.black12
            )
          )
      );
    }).toList();
  }

  // 属性底部弹框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          // StatefulBuilder 用来更新底部弹框状态 需要传递setBottomSheetStatus 下去
          return StatefulBuilder(builder: (BuildContext context, setBottomSheetStatus){
            return Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.only(bottom: ScreenAdapter.height(76)),
                    children: this._makeAttrWidget(setBottomSheetStatus),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(76),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: Color.fromRGBO(211, 211, 211, .8)))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                  child: JdButton(
                                    text: '加入购物车',
                                    color: Colors.redAccent,
                                    callBack: () {
                                      print('加入购物车');
                                    },
                                  ),
                                )),
                            Expanded(
                                child: Container(
                                  child: JdButton(
                                    text: '立即购买',
                                    color: Colors.orangeAccent,
                                    callBack: () {
                                      print('立即购买');
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            );
          });
        });
  }
}
