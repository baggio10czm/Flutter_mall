import 'package:flutter/material.dart';
import '../pages/tabs/Tabs.dart';
import '../pages/Search.dart';


//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
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

