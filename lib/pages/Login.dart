import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/Storage.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/EventBus.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  //监听登录页面销毁事件
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventBus.fire(new UserEvent('登录成功'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: Text('登录页面'),
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
          FlatButton(onPressed: null, child: Text('客服'))
        ],
      ),
      // 用ListView 防止键盘弹起无法滚动
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 30),
              width: ScreenAdapter.width(250),
              height: ScreenAdapter.height(250),
              // 本地图片模拟器有问题就不用了
              child: Icon(Icons.devices,size: ScreenAdapter.size(250)),
            ),
          ),
          JdText(text:'输入账号',onChanged: (value){
            this.username=value;}),
          SizedBox(height: 20),
          JdText(text:'输入密码',password:true,onChanged: (value){
            this.password=value;}),
          SizedBox(height: 20),
          Container(
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[
              InkWell(onTap:(){ Navigator.pushNamed(context, '/forgetPassword');},child: Text('忘记密码')),
              InkWell(onTap:(){ Navigator.pushNamed(context, '/registerFirst');},child: Text('新用户注册')),
            ],),
          ),
          SizedBox(height: 35),
          JdButton(text: '登录',color: Colors.redAccent,height: 88,callBack: doLogin)
        ],
      ),
    );
  }
  
  void doLogin() async{
    RegExp regExp = new RegExp(r'^1\d{10}$');
    if(!regExp.hasMatch(this.username)){
      Fluttertoast.showToast(
        msg: "手机号格式不对",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }else if(this.password.length<6){
      Fluttertoast.showToast(
        msg: "密码长度最小为6位",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }else {
      var api = Config.domain + 'api/doLogin';
      var response = await Dio().post(api,data:{'username':this.username,'password':this.password});
      if(response.data['success']){
        print(response.data);
        // 保存用户信息,返回到跟
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        // 返回
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }
}
