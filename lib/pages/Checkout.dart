import 'package:flutter/material.dart';
import '../provider/Checkout.dart';
import 'package:provider/provider.dart';
import '../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../services/UserServices.dart';
import '../services/SignServices.dart';
import '../services/EventBus.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  List defaultAddress = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDefaultAddress();
    //监听广播
    eventBus.on<CheckoutEvent>().listen((event){
      print(event.str);
      this._getDefaultAddress();
    });
  }

  void _getDefaultAddress() async{
    List userInfo = await UserServices.getUserInfo();

    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
    };

    var sign = SignServices.getSign(tempJson);

    var api = Config.domain + 'api/oneAddressList?uid=${userInfo[0]['_id']}&sign=$sign';

    var response = await Dio().get(api);
    print(response);
    defaultAddress = response.data['result'];
    setState(() {
      this.defaultAddress = response.data['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Checkout checkoutProvider = Provider.of<Checkout>(context);
    return Scaffold(
      appBar: AppBar(title: Text('结算')),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(76)),
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: this.defaultAddress.length>0?ListTile(
//              leading: Icon(Icons.add_location),
                  title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text("${this.defaultAddress[0]['name']} ${this.defaultAddress[0]['phone']}"),
                    SizedBox(height: ScreenAdapter.height(20)),
                    Text("${this.defaultAddress[0]['address']}"),
                  ],),
                  trailing: Icon(Icons.navigate_next),
                  onTap: (){
                    Navigator.pushNamed(context, '/addressList');
                  },
                ):ListTile(
//              leading: Icon(Icons.add_location),
                  title: Text('添加收货地址'),
                  trailing: Icon(Icons.navigate_next),
                  onTap: (){
                    Navigator.pushNamed(context, '/addressAdd');
                  },
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
