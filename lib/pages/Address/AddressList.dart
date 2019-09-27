import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../services/EventBus.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getAddressList();
    eventBus.on<AddressEvent>().listen((event) {
      print(event.str);
      this._getAddressList();
    });
  }
  // 获取收货地址
  void _getAddressList() async {
    List userInfo = await UserServices.getUserInfo();

    var tempJson = {
      'uid': userInfo[0]['_id'],
      'salt': userInfo[0]['salt'],
    };

    var sign = SignServices.getSign(tempJson);

    var api = Config.domain + 'api/addressList?uid=${userInfo[0]['_id']}&sign=$sign';

    var response = await Dio().get(api);
    setState(() {
      this.addressList = response.data['result'];
    });
  }

  void _changeDefaultAddress(id)async{

    List userInfo = await UserServices.getUserInfo();

    var tempJson = {
      'uid': userInfo[0]['_id'],
      'id': id, //收货地址id
      'salt': userInfo[0]['salt'],
    };

    var sign = SignServices.getSign(tempJson);

    var api = Config.domain + 'api/changeDefaultAddress';

    var response = await Dio().post(api,data:{
      'uid': userInfo[0]['_id'],
      'id': id,
      'sign': sign,
    });
    print(response);
    if(response.data['success']){
      Navigator.pop(context);
      eventBus.fire(new CheckoutEvent('改变默认地址'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址list'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: this.addressList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: ScreenAdapter.width(30)),
                    ListTile(
                      leading: this.addressList[index]['default_address'] == 1
                          ? Icon(Icons.check, color: Colors.redAccent)
                          : Icon(Icons.check, color: Colors.black12),
                      title: InkWell(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${this.addressList[index]['name']} ${this.addressList[index]['phone']}'),
                          SizedBox(height: 10),
                          Text('${this.addressList[index]['address']}'),
                        ],
                      ),onTap: (){
                        // 点击设置默认地址
                       this._changeDefaultAddress(this.addressList[index]['_id']);
                      },onLongPress: (){
                        // 长按删除
                        this._showDeleteAlertDialog(this.addressList[index]['_id']);
                      },),
                      trailing: IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: (){
                        Navigator.pushNamed(context, '/addressEdit',arguments: {
                          'id': this.addressList[index]['_id'],
                          'name': this.addressList[index]['name'],
                          'phone': this.addressList[index]['phone'],
                          'address': this.addressList[index]['address']
                        });
                      }),
                    ),
                    Divider(height: ScreenAdapter.width(30)),
                  ],
                );
              },
            ),
            Positioned(
                bottom: 0,
                width: ScreenAdapter.width(750),
                child: Container(
                  decoration: BoxDecoration(color: Colors.redAccent, border: Border(top: BorderSide(color: Colors.black12))),
                  padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
                  height: ScreenAdapter.height(86),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Icon(Icons.add, color: Colors.white), Text('增加收货地址', style: TextStyle(color: Colors.white))],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  // 删除收货地址
  _delAddress(id) async{
    List userInfo = await UserServices.getUserInfo();

    var tempJson = {
      'uid': userInfo[0]['_id'],
      'id': id,
      'salt': userInfo[0]['salt'],
    };

    var sign = SignServices.getSign(tempJson);

    var api = Config.domain + 'api/deleteAddress';
    var response = await Dio().post(api,data:{
      "uid": userInfo[0]['_id'],
      'id': id,
      'sign': sign,
    });

    print(response);

    if(response.data["success"]){
      this._getAddressList();
    }
  }

  // 弹出框
  void _showDeleteAlertDialog(id) async{
    await showDialog(
        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text("提示信息!"),
            content:Text("您确定要删除吗?") ,
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: (){
                  print("取消");
                  Navigator.pop(context,'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async{
                  this._delAddress(id);
                  Navigator.pop(context);
                },
              )
            ],

          );
        }
    );
  }

}
