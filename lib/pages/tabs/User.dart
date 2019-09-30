import 'package:flutter/material.dart';
import 'package:flutter_mall/widget/JdButton.dart';
import '../../services/UserServices.dart';
import '../../services/ScreenAdapter.dart';
import '../../services/EventBus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLogin = false;
  List _userInfo = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getUserInfo();

    // 监听登录页面广播
    eventBus.on<UserEvent>().listen((event){
      print(event.str);
      this._getUserInfo();
    });
  }

  void _getUserInfo() async{
    var isLogin = await UserServices.getUserLoginState();
    var userInfo = await UserServices.getUserInfo();
    setState(() {
      this._isLogin = isLogin;
      this._userInfo = userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.redAccent,
              //image: DecorationImage(
              //  image: AssetImage('images/user_bg.jpg'),
              //  fit: BoxFit.cover
              //)
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: ClipOval(
//                    child: Image.asset('images/user.png',fit: BoxFit.cover,width: ScreenAdapter.width(100),height: ScreenAdapter.height(100)),
                    child: Icon(Icons.supervised_user_circle,size: ScreenAdapter.width(100),color: Colors.white),
                  ),
                ),
                !this._isLogin ? Expanded(flex:1,child: InkWell(onTap:(){
                  Navigator.pushNamed(context, '/login');
                },child: Text('登录/注册',style: TextStyle(color: Colors.white)),)):
                Expanded(flex:1,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('用户名:${_userInfo[0]['username']}',style: TextStyle(color: Colors.white,fontSize: ScreenAdapter.size(28))),
                    SizedBox(height: 10),
                    Text('银章会员',style: TextStyle(color: Colors.white,fontSize: ScreenAdapter.size(28)))
                  ],
                )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books,color: Colors.redAccent),
            title: Text('订单列表'),
            onTap: () async{
              if(await UserServices.getUserLoginState()){
                Navigator.pushNamed(context, '/order');
              } else {
                Fluttertoast.showToast(
                  msg: "先登录",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.payment,color: Colors.blue),
            title: Text('已付款'),
          ),
          Divider(height: 1),
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
          Divider(height: 1),
          ListTile(
            leading: Icon(Icons.people,color: Colors.black54),
            title: Text('在线客服'),
          ),
          Divider(height: 1),
          this._isLogin ?Column(
            children: <Widget>[
              SizedBox(height: 35),
              JdButton(text: '退出登录',color:Colors.redAccent,callBack: (){
                UserServices.loginOut();
                this._getUserInfo();
              })
            ],
          ):Text('')
        ],
      ),
    );
  }
}
