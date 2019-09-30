import 'package:flutter/material.dart';
import '../widget/JdButton.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  String selectPay = 'alipay';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('去支付')),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 40),
                ListTile(
                  leading: Image.network('https://www.itying.com/themes/itying/images/alipay.png'),
                  title: Text('支付宝'),
                  trailing: Icon(Icons.check,color: selectPay == 'alipay' ? Colors.redAccent:Colors.black12,),
                  onTap: (){
                    setState(() {
                      this.selectPay = 'alipay';
                    });
                  }
                ),
                Divider(height: 26),
                ListTile(
                  leading: Image.network('https://www.itying.com/themes/itying/images/weixinpay.png'),
                  title: Text('微信支付'),
                  trailing: Icon(Icons.check,color: selectPay == 'weixinpay' ? Colors.redAccent:Colors.black12,),
                  onTap: (){
                    setState(() {
                      this.selectPay = 'weixinpay';
                    });
                  },
                ),
                Divider(height: 26),
              ],
            ),
          ),
          JdButton(
            text: '支付',
            color: Colors.redAccent,
            height: 78,
            callBack: (){
              print('5=55=');
            },
          )
        ],
      )
    );
  }
}
