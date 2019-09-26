import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';
import '../config/Config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String phone='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第一步'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          JdText(text: '请输入手机号',onChanged:(value){
            this.phone = value;
          }),
          SizedBox(height: 20),
          JdButton(text: '下一步',color: Colors.redAccent,callBack: (){sendCode();},),
        ],
      )
    );
  }

  void sendCode() async{
    RegExp regExp = new RegExp(r'^1\d{10}$');
    if(regExp.hasMatch(this.phone)){
      var api = Config.domain + 'api/sendCode';
      var response = await Dio().post(api,data:{'tel':this.phone});
      if(response.data['success']){
        print(response);
        Navigator.pushNamed(context, '/registerSecond',arguments: {
          'phone': this.phone
        });
      }else{
        Fluttertoast.showToast(
          msg: "${response.data['message']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }else{
      Fluttertoast.showToast(
        msg: "手机号格式不对",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
