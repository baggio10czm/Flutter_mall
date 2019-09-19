import 'package:flutter/material.dart';
import 'Home.dart';
import 'Category.dart';
import 'Cart.dart';
import 'User.dart';
import '../../services/ScreenAdapter.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = PageController(
      initialPage: _currentIndex,
    );
  }


  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: this._currentIndex != 3?AppBar(
        leading: IconButton(icon: Icon(Icons.center_focus_weak,size: 28,color: Colors.black87), onPressed: null),
        title: InkWell(
          child: Container(
            width: double.infinity,
            height: ScreenAdapter.height(68),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Icon(Icons.search),
               Text('搜索',style: TextStyle(fontSize: ScreenAdapter.size(28)))
              ]
            ),
          ),
          onTap: (){
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.message,size: 28,color: Colors.black87), onPressed: null)
        ],
      ):AppBar(
        title: Text("用户中心"),
    ),
      body: PageView(  // PageView 可以保存页面状态， 还有一种方式是  IndexedStack 简单应用可考虑使用
        controller: this._controller,
        children: _pageList,
        onPageChanged: (index){
          setState(() {
            this._currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止滑动切换页面
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (index) {
            setState(() {
              this._currentIndex = index;
            });
            _controller.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(icon: Icon(Icons.category), title: Text('分类')),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('购物车')),
            BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的'))
          ]),
    );
  }
}
