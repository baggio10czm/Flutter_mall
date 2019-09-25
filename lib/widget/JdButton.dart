import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';

class JdButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final Object callBack;

  JdButton({Key key,this.color=Colors.white70,this.text='按钮',this.height=68,this.callBack}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.callBack,
      child: Container(
        width: double.infinity,
        height: ScreenAdapter.height(this.height),
        margin: EdgeInsets.all(7),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: this.color,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(this.text,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
