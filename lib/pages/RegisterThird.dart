import 'dart:convert';
import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/Storage.dart';

class RegisterThirdPage extends StatefulWidget {
  final Map arguments;
  RegisterThirdPage({Key key,this.arguments}):super(key:key);
  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String phone;
  String code;
  // 给个初始值,防止下面检测报错
  String password = '';
  String rePassword = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.phone = widget.arguments['phone'];
    this.code = widget.arguments['code'];
  }

  doRegister() async{
    if(password.length < 6){
      Fluttertoast.showToast(
        msg: "密码长度不能小于6位",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }else if(password != rePassword){
      Fluttertoast.showToast(
        msg: "两次密码输入不一致",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }else {
      var api = Config.domain + 'api/register';
      var response = await Dio().post(api,data:{'tel':this.phone,'code':this.code,'password':this.password});
      if(response.data['success']){
        print(response.data['userinfo']);
        // 保存用户信息,返回到跟
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (context)=>new Tabs()), (route)=>route == null);

      }else{
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第三步'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          JdText(text:'输入密码',password:true,onChanged: (value){
            this.password=value;}),
          SizedBox(height: 20),
          JdText(text:'确认密码',password:true,onChanged: (value){
            this.rePassword=value;}),
          SizedBox(height: 30),
          JdButton(text: '注册',color: Colors.redAccent,height: 88,callBack: doRegister)
        ],
      ),
    );
  }
}
