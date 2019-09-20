import 'package:flutter/material.dart';
import 'CartNum.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenAdapter.height(200),
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
            child: Checkbox(value: true, onChanged: (value){
              print(value);
            },activeColor: Colors.pink,),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network('https://www.itying.com/images/flutter/list2.jpg'),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('商品-11111111阿萨是否低洼瞧得起我的青蛙打网球请问大师的阿萨伟大萨乌丁阿斯顿',maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('￥${1220}',style: TextStyle(color: Colors.redAccent),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
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
