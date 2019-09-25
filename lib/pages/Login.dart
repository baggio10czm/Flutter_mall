import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            print(value);}),
          SizedBox(height: 20),
          JdText(text:'输入密码',password:true,onChanged: (value){
            print(value);}),
          SizedBox(height: 20),
          Container(
            child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: <Widget>[
              InkWell(onTap:(){ Navigator.pushNamed(context, '/forgetPassword');},child: Text('忘记密码')),
              InkWell(onTap:(){ Navigator.pushNamed(context, '/registerFirst');},child: Text('新用户注册')),
            ],),
          ),
          SizedBox(height: 35),
          JdButton(text: '登录',color: Colors.redAccent,height: 88,callBack: (){})
        ],
      ),
    );
  }
}
