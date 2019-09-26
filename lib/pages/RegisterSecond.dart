import 'dart:async';

import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterSecondPage extends StatefulWidget {
  final Map arguments;
  RegisterSecondPage({Key key,this.arguments}):super(key:key);
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String phone;
  String code;
  bool sendCodeBtn=false;
  int seconds = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = widget.arguments['phone'];
    this._showTimer();
  }

  _showTimer(){
      Timer t;
      t= Timer.periodic(Duration(milliseconds: 1000), (timer){
        setState(() {
          this.seconds --;
        });
        if(this.seconds==0){
          timer.cancel();
          setState(() {
            this.sendCodeBtn = true;
          });
        }
      });
  }

  void sendCode() async{
    var api = Config.domain + 'api/sendCode';
    var response = await Dio().post(api,data:{'tel':this.phone});
    if(response.data['success']){
      print(response);
      setState(() {
        this.seconds = 10;
        this.sendCodeBtn = false;
      });
      this._showTimer();
    }else{
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void validateCode() async {
    var api = Config.domain + 'api/validateCode';
    var response = await Dio().post(api,data:{'tel':this.phone,'code':this.code});
    if(response.data['success']){
      Navigator.pushNamed(context, '/registerThird',arguments: {'phone':this.phone,'code':this.code});
    }else{
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第二步'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('请输入$phone手机收到的验证码'),
          ),
          SizedBox(height: 20),
          Stack(
            children: <Widget>[
              JdText(text: '请输入验证码',onChanged:(value){
                this.code = value;
              }),
              Positioned(right:0,bottom: 5,child: this.sendCodeBtn ? RaisedButton(onPressed:this.sendCode,child: Text('重新发送')):RaisedButton(onPressed: (){
                print('等待ing');
              },child: Text('${this.seconds}秒后重发')))
            ],
          ),
          SizedBox(height: 20),
          JdButton(text: '下一步',color: Colors.redAccent,callBack: validateCode),
        ],
      ),
    );
  }
}
