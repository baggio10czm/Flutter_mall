import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _count = 0;

  Counter(){
    this._count = 10;
  }

  // 获取状态
  int get count=> _count;
  //更新状态
  incCount(){
    this._count ++;
    notifyListeners(); //更新状态
  }

}