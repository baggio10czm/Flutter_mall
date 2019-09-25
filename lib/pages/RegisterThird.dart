import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';

class RegisterThirdPage extends StatefulWidget {
  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
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
            print(value);}),
          SizedBox(height: 20),
          JdText(text:'确认密码',password:true,onChanged: (value){
            print(value);}),
          SizedBox(height: 30),
          JdButton(text: '确认',color: Colors.redAccent,height: 88,callBack: (){})
        ],
      ),
    );
  }
}
