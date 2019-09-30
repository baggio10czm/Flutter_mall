import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../config/Config.dart';
import '../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../mode/OrderModel.dart';
import '../services/UserServices.dart';
import '../services/SignServices.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List _orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getOrder();
  }

  void _getOrder() async{
    List userInfo = await UserServices.getUserInfo();
    var tempJson = {"uid": userInfo[0]['_id'], 'salt': userInfo[0]['salt']};
    var sign = SignServices.getSign(tempJson);
    var api = Config.domain + 'api/orderList?uid=${userInfo[0]['_id']}&sign=$sign';
    var response = await Dio().get(api);
    if(response.data['success']){
      setState(() {
        this._orderList = OrderModel.fromJson(response.data).result;
      });
    }
  }

  // 商品列表
  List<Widget> _orderItemWidget(items){
    List<Widget> tempList = [];
    for (var i = 0; i < items.length; ++i) {
      tempList.add(Container(
          padding: EdgeInsets.only(bottom: ScreenAdapter.width(26)),
          child: ListTile(
            leading: Container(
              width: ScreenAdapter.width(80),
              height: ScreenAdapter.height(80),
              child: Image.network('${items[i].productImg}'),
            ),
            title: Text('${items[i].productTitle}'),
            trailing: Text('x${items[i].productCount}'),
          ),
        ));
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的订单'),),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(82)),
            padding: EdgeInsets.all(ScreenAdapter.width(12)),
            child: ListView(
              children: this._orderList.map((item){
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('订单编号:${item.sId}',style: TextStyle(color: Colors.black54),),
                      ),
                      Divider(height: 1),
                      SizedBox(height: 10),
                      Column(
                        children: this._orderItemWidget(item.orderItem),
                      ),
                      SizedBox(height: 12),
                      ListTile(
                        leading: Text('合计:￥${item.allPrice}'),
                        trailing: FlatButton(onPressed: (){
                            Navigator.pushNamed(context, '/orderInfo');
                        }, child: Text('查看详情'),color: Colors.black12,),
                      ),
                    ],
                  ),
                );
              }).toList()
            ),
          ),
          Positioned(top:0,width:ScreenAdapter.width(750),height:ScreenAdapter.height(76),child: Container(
            color: Colors.white,
            child: Row(children: <Widget>[
              Expanded(child: Text('全部',textAlign: TextAlign.center,)),
              Expanded(child: Text('待付款',textAlign: TextAlign.center)),
              Expanded(child: Text('待发货',textAlign: TextAlign.center)),
              Expanded(child: Text('已完成',textAlign: TextAlign.center)),
              Expanded(child: Text('已取消',textAlign: TextAlign.center)),
            ]),
          ))
        ],
      ),
    );
  }
}
