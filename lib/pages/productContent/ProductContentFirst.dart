import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';

class ProductContentFirst extends StatefulWidget {
  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  @override
  Widget build(BuildContext context) {

    _attrBottomSheet(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          height: 400,
          child: Stack(
            children: <Widget>[
              ListView(
                padding: EdgeInsets.only(bottom: ScreenAdapter.height(76)),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(100),
                          padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                          child: Text('颜色:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: ScreenAdapter.width(100),
                            padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                            child: Text('尺寸:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('185-XXXL'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('180-XXL'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('175-XX'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('170-X'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('165-M'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('160-X'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('Small'),
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: ScreenAdapter.width(100),
                            padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                            child: Text('主题:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('自然'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('反叛'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('血色')
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: ScreenAdapter.width(100),
                            padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                            child: Text('颜色:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('红色'),
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: ScreenAdapter.width(100),
                            padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                            child: Text('尺寸:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('185-XXXL'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('180-XXL'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('175-XX'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('170-X'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('165-M'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('160-X'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('Small'),
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: ScreenAdapter.height(18)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: ScreenAdapter.width(100),
                            padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
                            child: Text('主题:',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700))
                        ),
                        Expanded(flex:1,child: Wrap(
                          children: <Widget>[
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('自然'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                              label: Text('反叛'),
                            )),
                            Container(margin:EdgeInsets.only(left:ScreenAdapter.width(12),right:ScreenAdapter.width(12)),child: Chip(
                                label: Text('血色')
                            )),
                          ],
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(bottom:0,child: Container(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(76),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(211, 211, 211, .8)
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Container(
                      child: JdButton(
                        text: '加入购物车',
                        color: Colors.redAccent,
                        callBack: (){
                          print('加入购物车');
                        },
                      ),
                    )),
                    Expanded(child: Container(
                      child: JdButton(
                        text: '立即购买',
                        color: Colors.redAccent,
                        callBack: (){
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
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(18),ScreenAdapter.width(18),ScreenAdapter.width(18),ScreenAdapter.width(88)),
      child: ListView(
        children: <Widget>[
          // 图
          AspectRatio(aspectRatio: 12/9,child: Image.network('http://www.itying.com/images/flutter/p1.jpg',fit: BoxFit.cover)),
          // 标题
          Container(
            child: Column(
              children: <Widget>[
                Text("联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
                    style: TextStyle(
                        color: Colors.black87, fontSize: ScreenAdapter.size(32))),
                SizedBox(height: ScreenAdapter.height(8)),
                Text("联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑",
                    style: TextStyle(
                        color: Colors.black54, fontSize: ScreenAdapter.size(28))),
              ],
            ),
          ),
          // 价格
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(flex: 1,child:Row(
                  children: <Widget>[
                    Text('特价'),
                    Text('￥12000',style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenAdapter.size(36)))
                  ],
                )),
                Expanded(flex: 1,child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('原价'),
                    Text('￥12000',style: TextStyle(
                      color: Colors.black26,
                      fontSize: ScreenAdapter.size(26),
                      decoration: TextDecoration.lineThrough
                    ),)
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
                    onTap: (){
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("115，黑色，XL，1件")
                      ],
                    ) ,
                  )
                ),
                Divider(),
                Container(
                  height: ScreenAdapter.height(66),
                  child: Row(
                    children: <Widget>[
                      Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
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
}
