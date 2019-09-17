import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/ScreenAdapter.dart';
import '../config/Config.dart';
import '../mode/CategoryModel.dart';


class ProductListPage extends StatefulWidget {
  final Map arguments;
  ProductListPage({Key key,this.arguments}) : super(key: key);
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('商品列表${widget.arguments['pid']}'),actions: <Widget>[Text('')],),
      endDrawer: Drawer(
        child: Container(
          child: Text("实现筛选功能"),
        )
      ),
      body: Stack(
        children: <Widget>[
          this._productListWidget(),
          this._subHeaderWidget(),
        ],
      ),
    );
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
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: Text("综合",textAlign: TextAlign.center,style: TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: Text("销量", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: Text("价格", textAlign: TextAlign.center),
                ),
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(20), 0, ScreenAdapter.height(20)),
                  child: Text("筛选", textAlign: TextAlign.center),
                ),
                onTap: () {
                  _scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _productListWidget(){
    return Container(
        padding: EdgeInsets.fromLTRB(10,0,10,0),
        margin: EdgeInsets.only(top: ScreenAdapter.height(88)),
        child: ListView.builder(itemCount:11,itemBuilder:(context,index){
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(180),
                    height: ScreenAdapter.height(180),
                    child: Image.network('http://www.guilinenguang.org/public/images/defaultAlbum_img.jpg', fit: BoxFit.cover,),
                  ),
                  Expanded(flex:1,child: Container(
                    height:ScreenAdapter.height(180) ,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                            maxLines: 2,overflow: TextOverflow.ellipsis),
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
                        Text("¥990",style:TextStyle(color: Colors.red, fontSize: 20),
                        )
                      ],
                    ),
                  ))
                ],
              ),
              Divider(height: 26)
            ],
          );
        })
    );
  }
}
