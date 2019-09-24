import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../Cart/CartItem.dart';
import 'package:provider/provider.dart';
//import '../../provider/Counter.dart';
import '../../provider/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
//    Counter countProvider = Provider.of<Counter>(context);
    Cart cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.launch), onPressed:(){
            setState(() {
              this._isEdit = !this._isEdit;
            });
          })
        ],
      ),
      body: cartProvider.carList.length>0 ? Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(88)),
            children: cartProvider.carList.map((item){
              return CartItem(item);
            }).toList()
          ),
          Positioned(bottom:0,width:ScreenAdapter.width(750),child: Container(
            width: double.infinity,
            height: ScreenAdapter.height(76),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12)
              )
            ),
            child:
            //Stack(children: <Widget>[
            //  Align(
            //    alignment: Alignment.centerLeft,
            //    child: Row(
            //      children: <Widget>[
            //        Container(
            //          width: ScreenAdapter.width(60),
            //          child:Checkbox(value: true, activeColor: Colors.pink, onChanged: (value){
            //            print('=22');
            //          }),
            //        ),
            //        Text('全选')
            //      ],
            //    ),
            //  ),
            //  Align(
            //    alignment: Alignment.centerRight,
            //    child: RaisedButton(
            //      child: Text('结算',style: TextStyle(color: Colors.white)),
            //      color: Colors.redAccent,
            //      onPressed: (){
            //        print('结算');
            //      },
            //    ),
            //  )
            //])
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenAdapter.width(60),
                                  child:Checkbox(value: cartProvider.isCheckedAll, activeColor: Colors.pink, onChanged: (value){
                                    cartProvider.checkAll(value);
                                  }),
                                ),
                                Text('全选'),
                                SizedBox(width: 20),
                                this._isEdit==false ? Text('合计:'):Text(''),
                                this._isEdit==false ? Text('${cartProvider.allPrice}',style: TextStyle(color: Colors.redAccent, fontSize: ScreenAdapter.size(32))):Text('')
                              ],
                            ),
                  ),
                  Container(
                    width: ScreenAdapter.width(170),
                    child: this._isEdit==false? RaisedButton(
                        child: Text('结算',style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                        onPressed: (){
                          print('结算');
                        }):RaisedButton(
                        child: Text('删除',style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                        onPressed: (){
                          cartProvider.removeItem();
                        }),
                  )
                ],
              ),

          ))
        ],
      ):Text('毫无数据?'),
    );
  }
}
