import 'package:flutter/material.dart';
import '../Cart/CartItem.dart';
import '../Cart/CartNumProviderTest.dart';
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';
import '../../provider/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Counter countProvider = Provider.of<Counter>(context);
    Cart cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){countProvider.incCount();cartProvider.addData('Czm${countProvider.count}');},child: Icon(Icons.add)),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(child: Text('统计数量: ${countProvider.count}')),
          Divider(),
          CartItem(),
          Divider(height: 40),
          CartNumTest(),
        ],
      ),
    );
  }
}
