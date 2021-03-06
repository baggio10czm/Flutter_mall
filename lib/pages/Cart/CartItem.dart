import 'package:flutter/material.dart';
import 'CartNum.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  final Map _cartItem;
  CartItem(this._cartItem,{Key key}):super(key:key);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _cartItem;
  Cart cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  _cartItem = widget._cartItem;
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 必须放在build里 不然删除,重新渲染页面时不会走 initState,会导致数据错误
    _cartItem = widget._cartItem;
    this.cartProvider = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenAdapter.height(220),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12
        ))
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(value: _cartItem['checked'], onChanged: (value){
              _cartItem['checked'] = !_cartItem['checked'];
              cartProvider.itemChange();
            },activeColor: Colors.pink,),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network('${_cartItem['pic']}'),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_cartItem['title']}',maxLines: 2),
                  Text('${_cartItem['selectedAttr']}',maxLines: 1),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('￥${_cartItem['price']}',style: TextStyle(color: Colors.redAccent),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(_cartItem),
                      )
                    ],
                  )
                ],
              )
            )
          )
        ],
      ),
    );
  }
}
