import 'package:flutter/material.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';
import 'productContent/ProductContentFirst.dart';
import 'productContent/ProductContentSecond.dart';
import 'productContent/ProductContentThird.dart';
import '../widget/JdButton.dart';
import '../widget/LoadingWidget.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../mode/ProductContentModel.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  ProductContentPage({Key key,this.arguments}):super(key:key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  ProductContentItem _productContentItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getProductContent();
  }

  void _getProductContent() async{
    String api = Config.domain + 'api/pcontent?id=' + widget.arguments['id'];
    print(api);
    var response = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(response.data);
    setState(() {
      this._productContentItem = productContent.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Container(width:ScreenAdapter.width(400),child: TabBar(
                    indicatorColor: Colors.redAccent,
                    labelColor: Colors.black54,
                    unselectedLabelColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[Tab(text: '商品'), Tab(text: '详情'), Tab(text: '评价')]))
              ]
            ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_horiz), onPressed: (){
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(ScreenAdapter.width(600), 80, 10, 0),
                items: [
                  PopupMenuItem(child: Row(
                    children: <Widget>[
                      Icon(Icons.home),
                      Text('首页')
                    ],
                  )),
                  PopupMenuItem(child: Row(
                    children: <Widget>[
                      Icon(Icons.search),
                      Text('搜索')
                    ],
                  )),
                ]
              );
            })
          ],
        ),
        body: (this._productContentItem??null) != null?Stack(
          children: <Widget>[
            // 中间切换页面
            TabBarView(children: <Widget>[
              ProductContentFirst(this._productContentItem),
              ProductContentSecond(this._productContentItem),
              ProductContentThird(),
            ]),
            // 底部button区
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(233, 233, 233, 0.8)
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(180),
                      padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text('购物车')
                        ],
                      ),
                    ),
                    Expanded(flex:1,child: JdButton(
                      text: '加入购物车',
                      color: Colors.redAccent,
                      callBack: (){
                        print('就是就是');
                      },
                    )),
                    Expanded(flex:1,child: JdButton(
                      text: '立即购买',
                      color: Colors.orangeAccent,
                      callBack: (){
                        print('立即购买');
                      },
                    ))
                  ],
                ),
              ),
            )
          ],
        ):LoadingWidget(),
      )
    );
  }
}
