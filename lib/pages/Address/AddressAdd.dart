import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdText.dart';
import '../../widget/JdButton.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../services/UserServices.dart';
import '../../services/SignServices.dart';
import 'package:dio/dio.dart';
import '../../config/Config.dart';
import '../../services/EventBus.dart';

class AddressAddPage extends StatefulWidget {
  @override
  _AddressAddPageState createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String areaStr = '省/市/区';
  String name = '';
  String phone = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加收货地址'),),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: <Widget>[
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '收货人姓名',onChanged: (value){
            this.name = value;
          }),
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '收货人电话',onChanged: (value){
            this.phone = value;
          }),
          SizedBox(height: ScreenAdapter.width(30)),
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
            height: ScreenAdapter.height(88),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12)
              )
            ),
            child: InkWell(
              onTap:() async{
                Result result = await CityPickers.showCityPicker(
                  context: context,
                  cancelWidget: Text('取消',style: TextStyle(color: Colors.blue)),
                  confirmWidget: Text('选择',style: TextStyle(color: Colors.blue)),
                );
                if(result != null){
                  setState(() {
                    this.areaStr = "${result?.provinceName}/${result?.cityName}/${result?.areaName}";
                  });
                }
              },child: Row(
              children: <Widget>[
                Icon(Icons.add_location),
                Text('$areaStr',style: TextStyle(color: Colors.black54))
              ],
            ),
            ),
          ),
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '详细地址',maxLines: 5,height: 200,onChanged: (value){
              this.address = value;
          }),
          SizedBox(height: ScreenAdapter.width(60)),
          JdButton(text: '增加',color: Colors.redAccent,callBack: ()async{
            List userInfo = await UserServices.getUserInfo();
            print(userInfo);
            var tempJson = {
              'uid': userInfo[0]['_id'],
              'name': this.name,
              'phone': this.phone,
              'address': this.address,
              'salt': userInfo[0]['salt'],
            };

            var sign = SignServices.getSign(tempJson);

            print(sign);

            var api = Config.domain + 'api/addAddress';
            var result = await Dio().post(api,data:{
              "uid": userInfo[0]['_id'],
              'name': this.name,
              'phone': this.phone,
              'address': this.address,
              'sign': sign,
            });

            print(result);

            if(result.data["success"]){
              // 添加成功 通知收货地址列表页面更新,并返回
              eventBus.fire(new AddressEvent('增加成功'));
              // 通知结算页面更新默认地址
              eventBus.fire(new CheckoutEvent('改变默认地址'));
              Navigator.pop(context);
            }

          })
        ],
      ),
    );
  }
}
