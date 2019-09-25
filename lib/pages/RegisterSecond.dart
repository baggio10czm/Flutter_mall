import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';


class RegisterSecondPage extends StatefulWidget {
  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
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
            child: Text('请输入手机收到的验证码'),
          ),
          SizedBox(height: 20),
          Stack(
            children: <Widget>[
              JdText(text: '请输入验证码',onChanged:(value){
                print(value);
              }),
              Positioned(right:0,bottom: 5,child: RaisedButton(onPressed: (){
                print('777');
              },child: Text('重新发送'),))
            ],
          ),
          SizedBox(height: 20),
          JdButton(text: '下一步',color: Colors.redAccent,callBack: (){Navigator.pushNamed(context, '/registerThird');},),
        ],
      ),
    );
  }
}
