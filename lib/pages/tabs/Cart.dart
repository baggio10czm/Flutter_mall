import 'dart:math';

import 'package:flutter/material.dart';
import '../../services/CartServices.dart';
import '../../services/UserServices.dart';
import '../../services/ScreenAdapter.dart';
import '../Cart/CartItem.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
import '../../provider/Checkout.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;
  Checkout checkoutProvider;
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    Cart cartProvider = Provider.of<Cart>(context);
    checkoutProvider = Provider.of<Checkout>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(icon: Icon(this._isEdit?Icons.delete_forever:Icons.delete), onPressed:(){
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
                            )
                  ),
                  Container(
                    width: ScreenAdapter.width(170),
                    child: this._isEdit==false? RaisedButton(
                        child: Text('结算',style: TextStyle(color: Colors.white)),
                        color: Colors.redAccent,
                        onPressed: doCheckout):RaisedButton(
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
      ):Center(child: Text('毫无数据?')),
    );
  }

  // 去结算
  void doCheckout() async{
    // 获取购物车选中的数据
    List checkoutData = await CartServices.getCheckoutData();
    // 保存购物车选中数据到 结算provider
    checkoutProvider.changeCheckoutListData(checkoutData);
    // 判断是否有选中的商品
    if(checkoutData.length>0){
      // 判断用户是否登录,保存购物车选中数据
      // 异步方法记得加 await
      if(await UserServices.getUserLoginState()){
        Navigator.pushNamed(context, '/checkout');
      }else{
        Fluttertoast.showToast(
          msg: "先登录",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        Navigator.pushNamed(context, '/login');
      }
    }else{
      Fluttertoast.showToast(
        msg: "没有选中商品",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
