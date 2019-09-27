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

class AddressEditPage extends StatefulWidget {
  final Map arguments;
  AddressEditPage({Key key,this.arguments}): super(key:key);
  @override
  _AddressEditPageState createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  String areaStr = '省/市/区';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //addressInfo = widget.arguments;
    nameController.text = widget.arguments['name'];
    phoneController.text = widget.arguments['phone'];
    addressController.text = widget.arguments['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('收货地址编辑'),),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: <Widget>[
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '收货人姓名',controller:nameController,onChanged: (value){
            nameController.text = value;
          }),
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '收货人电话',controller:phoneController,onChanged: (value){
            phoneController.text = value;
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
                  locationCode: '130102',
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
            )),
          ),
          SizedBox(height: ScreenAdapter.width(30)),
          JdText(text: '详细地址',controller:addressController,maxLines: 5,height: 200,onChanged: (value){
            addressController.text = value;
          }),
          SizedBox(height: ScreenAdapter.width(60)),
          JdButton(text: '修改',color: Colors.redAccent,callBack: ()async{
            List userInfo = await UserServices.getUserInfo();

            var tempJson = {
              'uid': userInfo[0]['_id'],
              'id': widget.arguments['id'],
              'name': nameController.text,
              'phone': phoneController.text,
              'address': addressController.text,
              'salt': userInfo[0]['salt'],
            };

            var sign = SignServices.getSign(tempJson);

            var api = Config.domain + 'api/editAddress';
            var response = await Dio().post(api,data:{
              "uid": userInfo[0]['_id'],
              'id': widget.arguments['id'],
              'name': nameController.text,
              'phone': phoneController.text,
              'address': addressController.text,
              'sign': sign,
            });

            print(response);

            if(response.data["success"]){
              // 添加成功 通知收货地址列表页面更新,并返回
              eventBus.fire(new AddressEvent('编辑成功'));
              // 通知结算页面更新默认地址(有可能编辑的是地址)
              eventBus.fire(new CheckoutEvent('改变默认地址'));
              Navigator.pop(context);
            }

          })
        ],
      ),
    );
  }

}
