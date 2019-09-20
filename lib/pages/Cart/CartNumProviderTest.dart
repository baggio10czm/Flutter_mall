import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';

class CartNumTest extends StatefulWidget {
  @override
  _CartNumTestState createState() => _CartNumTestState();
}

class _CartNumTestState extends State<CartNumTest> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Column(
      children: <Widget>[
        Text('${cartProvider.cartNum}')
      ],
    );
  }
}
