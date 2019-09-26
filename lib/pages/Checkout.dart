import 'package:flutter/material.dart';
import '../provider/Checkout.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    Checkout checkoutProvider = Provider.of<Checkout>(context);
    return Scaffold(
      appBar: AppBar(title: Text('结算')),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: ListTile(
//              leading: Icon(Icons.add_location),
                  title: Column(crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                    Text('张三 15988865421'),
                    SizedBox(height: 10),
                    Text('广西省桂林市朝阳高新开发区')
                  ],),
                  trailing: Icon(Icons.navigate_next),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children:checkoutProvider.checkoutList.map((item){
                  return _checkoutItem(item);
                }).toList(),
              ),
              SizedBox(height: ScreenAdapter.height(30)),
              Padding(padding: EdgeInsets.all(ScreenAdapter.width(20)),child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('商品总金额:￥1230'),
                  Text('立减:￥730'),
                  Text('运费:￥10'),
                ],
              ) ,)
            ],
          ),
          Positioned(bottom:0,width:ScreenAdapter.width(750),child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12)
              )
            ),
            padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
            height: ScreenAdapter.height(76),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('总价:￥1230'),
                RaisedButton(color: Colors.redAccent,child: Text('立即下单',style: TextStyle(color: Colors.white),),onPressed: (){
                  print('224');
                })
              ],
            ),
          ))
        ],
      ),
    );
  }
  
  Widget _checkoutItem(item){
    return Container(
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
            child: Image.network('${item['pic']}',fit: BoxFit.cover),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${item['title']}',maxLines: 2,style: TextStyle(fontSize: ScreenAdapter.size(26))),
                      Text('${item['selectedAttr']}',maxLines: 1),
                      Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('￥${item['price']}',style: TextStyle(color: Colors.redAccent),),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('x${item['count']}'),
                          )
                        ],
                      )
                    ],
                  )
              )
          )
        ],
      ),
    );
  }
}
