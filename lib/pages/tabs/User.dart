import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Counter countProvider = Provider.of<Counter>(context);
    return Scaffold(
      //appBar: AppBar(
      //  title: Text('用户'),
      //  actions: <Widget>[
      //    IconButton(icon: Icon(Icons.launch), onPressed: null)
      //  ],
      //),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(220),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/user_bg.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ClipOval(
                    child: Image.asset('images/user.png',fit: BoxFit.cover,width: ScreenAdapter.width(100),height: ScreenAdapter.height(100)),
                  ),
                ),
                Expanded(flex:1,child: InkWell(onTap:(){
                  Navigator.pushNamed(context, '/login');
                },child: Text('登录/注册',style: TextStyle(color: Colors.white)),)),
//                Expanded(flex:1,child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text('用户名:紫影锋',style: TextStyle(color: Colors.white,fontSize: ScreenAdapter.size(32))),
//                    SizedBox(height: 10),
//                    Text('银章会员',style: TextStyle(color: Colors.white,fontSize: ScreenAdapter.size(32)))
//                  ],
//                )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books,color: Colors.redAccent),
            title: Text('订单列表'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.blue),
            title: Text('已付款'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.directions_car,color: Colors.blueGrey),
            title: Text('待收货'),
          ),
          Container(
            height: 20,
            width: double.infinity,
            color: Color.fromRGBO(235, 235, 235, .9),
          ),
          ListTile(
            leading: Icon(Icons.favorite,color: Colors.lightGreen),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people,color: Colors.black54),
            title: Text('在线客服'),
          ),
          Divider(),
        ],
      ),
    );
  }
}
