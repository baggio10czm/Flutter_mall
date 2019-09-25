import 'package:flutter/material.dart';
import '../pages/tabs/Cart.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';
import '../pages/ProductList.dart';
import '../pages/ProductContent.dart';
import '../pages/Login.dart';
import '../pages/RegisterFirst.dart';
import '../pages/RegisterSecond.dart';
import '../pages/RegisterThird.dart';
import '../pages/forgetPassword.dart';


//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
  '/cart': (context) => CartPage(),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/productContent': (context,{arguments}) => ProductContentPage(arguments:arguments),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context) => RegisterSecondPage(),
  '/registerThird': (context) => RegisterThirdPage(),
  '/forgetPassword': (context) => ForgetPasswordPage(),
};

// ignore: strong_mode_top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
// 路由统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};

