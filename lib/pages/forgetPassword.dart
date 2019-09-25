import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JdButton.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('忘记密码'),
      ),
      body: Center(
        child: Text('忘记密码'),
      ),
    );
  }
}
