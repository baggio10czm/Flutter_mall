import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {

  final Map _cartItem;
  CartNum(this._cartItem,{Key key}):super(key:key);
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(170),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      )
    );
  }
  // 左侧按钮
  Widget _leftBtn(){
    return InkWell(
      onTap: (){
        print('-');
      },
      child: Container(
        width: ScreenAdapter.width(48),
        height: ScreenAdapter.height(48),
        alignment: Alignment.center,
        child: Icon(Icons.remove),
      ),
    );
  }
  // 右侧按钮
  Widget _rightBtn(){
    return InkWell(onTap: (){
      print('+++');
    },child:Container(
      width: ScreenAdapter.width(48),
      height: ScreenAdapter.height(48),
      alignment: Alignment.center,
      child: Icon(Icons.add),
    ));
  }
  // 中间
  Widget _centerArea(){
    return Container(
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black12
          ),
          right: BorderSide(
              color: Colors.black12
          ),
        )
      ),
      child: Text('${ widget._cartItem['count']}'),
    );
  }

}
