import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../config/Config.dart';

class ProductContentFirst extends StatefulWidget {
  final _productContentItem;

  ProductContentFirst(this._productContentItem, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  List attr = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attr = widget._productContentItem.attr;
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
              children: <Widget>[
                Text("${widget._productContentItem.title}",
                    style: TextStyle(color: Colors.black87,fontSize: ScreenAdapter.size(32))),
                SizedBox(height: ScreenAdapter.height(8)),
                Text("${widget._productContentItem.subTitle}",
                    style: TextStyle(color: Colors.black54,fontSize: ScreenAdapter.size(28))),
              ],
            ),
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
                      ],
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
                      ],
                    ))
              ],
            ),
          ),
          // 规格
          Container(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
                    height: ScreenAdapter.height(66),
                    child: InkWell(
                      onTap: () {
                        _attrBottomSheet();
                      },
                      child: Row(
                        children: <Widget>[
                          Text("已选: ",style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("115，黑色，XL，1件")
                        ],
                      ),
                    )),
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

  // 属性Widget
  List<Widget> _makeAttrWidget() {
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
            Expanded(flex: 1, child: Wrap(children: this._attrItemWidget(item.list)))
          ],
        ),
      );
    });
    return list.toList();
  }

  // 属性子项目Widget  注意 attrList 是动态类型？需要转换为List 才能 map
  List<Widget> _attrItemWidget(List attrList) {
    return attrList.map((item) {
      return Container(margin: EdgeInsets.only(left: ScreenAdapter.width(12), right: ScreenAdapter.width(12)),
          child: Chip(
            label: Text('$item'),
          ));
    }).toList();
  }

  // 属性底部弹框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 400,
            child: Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(76)),
                  children: this._makeAttrWidget(),
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
                              color: Colors.redAccent,
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
  }
}
