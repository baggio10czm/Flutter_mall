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
  int _currentIndex = 3;
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
