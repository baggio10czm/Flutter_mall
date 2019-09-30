import 'package:flutter/material.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';

class OrderInfoPage extends StatefulWidget {
  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('订单详情'),),
      body: Container(
        child: ListView(
          children: <Widget>[
            // 收货地址
            Container(
              padding: EdgeInsets.only(top: ScreenAdapter.height(20),bottom:ScreenAdapter.height(20) ),
              child: ListTile(
                leading: Icon(Icons.add_location),
                title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                  Text("李峰零 15899863321"),
                  SizedBox(height: ScreenAdapter.height(20)),
                  Text("桂林东岸大道214291"),
                ],),
              ),
            ),
            // 商品列表
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(10)),
                    height: ScreenAdapter.height(220),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.black12
                            ))
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(160),
                          child: Image.network('https://www.itying.com/images/flutter/list2.jpg',fit: BoxFit.cover),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('商品0012',maxLines: 2,style: TextStyle(fontSize: ScreenAdapter.size(26))),
                                    Text('白色,182',maxLines: 1),
                                    Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('￥1582',style: TextStyle(color: Colors.redAccent),),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1'),
                                        )
                                      ],
                                    )
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(ScreenAdapter.width(10)),
                    height: ScreenAdapter.height(220),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Colors.black12
                            ))
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(160),
                          child: Image.network('https://www.itying.com/images/flutter/list2.jpg',fit: BoxFit.cover),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('商品0012',maxLines: 2,style: TextStyle(fontSize: ScreenAdapter.size(26))),
                                    Text('白色,182',maxLines: 1),
                                    Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text('￥1582',style: TextStyle(color: Colors.redAccent),),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Text('x1'),
                                        )
                                      ],
                                    )
                                  ],
                                )
                            )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 商品信息
            Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('订单编号:124214'),
                  ),
                  ListTile(
                    title: Text('下单日期:124214'),
                  ),
                  ListTile(
                    title: Text('支付方式:支付宝'),
                  ),
                  ListTile(
                    title: Text('配送方式:顺丰'),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('总金额:'),
                        Text('￥1568',style: TextStyle(color: Colors.redAccent))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
