import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
  List _carList = [];

  // 获取状态
  int get cartNum => this._carList.length;
  List get carList => _carList;

  // 购物车加项目
  addData(value){
    this._carList.add(value);
    notifyListeners(); //更新状态
  }
  // 购物车加项目
  deleteData(value){
    this._carList.remove(value);
    notifyListeners(); //更新状态
  }

}