import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartNum extends StatefulWidget {
  final Map _cartItem;
  CartNum(this._cartItem,{Key key}):super(key:key);
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map _cartItem;
  Cart cartProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._cartItem = widget._cartItem;
  }
  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);
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
        if(_cartItem['count']>1){
          _cartItem['count']--;
          cartProvider.itemCountChange();
        }
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
      _cartItem['count']++;
      cartProvider.itemCountChange();
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
      child: Text('${ _cartItem['count'] }'),
    );
  }

}
