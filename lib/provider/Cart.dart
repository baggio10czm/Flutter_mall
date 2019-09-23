import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/Storage.dart';

class Cart with ChangeNotifier {
  List _carList = [];

  // 获取状态
  List get carList => _carList;

  Cart() {
    this.init();
  }

  init() async {
    try {
      var cartListData = json.decode(await Storage.getString('cartList'));
      this._carList = cartListData;
    } catch (err) {
      this._carList = [];
    }
    notifyListeners();
  }

  updateCartList(){
    this.init();
  }
}
