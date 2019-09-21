import 'package:flutter/material.dart';

class Cart with ChangeNotifier{

  List _carList = [];

  // 获取状态
  List get carList => _carList;

}