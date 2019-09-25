import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';

class RegisterFirstPage extends StatefulWidget {
  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
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
            print(value);
          }),
          SizedBox(height: 20),
          JdButton(text: '下一步',color: Colors.redAccent,callBack: (){Navigator.pushNamed(context, '/registerSecond');},),
        ],
      )
    );
  }
}
