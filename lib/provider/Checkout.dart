import 'package:flutter/material.dart';
//import 'dart:convert';
//import '../services/Storage.dart';

class Checkout with ChangeNotifier {
  List _checkoutListData = [];
  List get checkoutList => this._checkoutListData;

  changeCheckoutListData(data){
    this._checkoutListData = data;
    notifyListeners();
  }
}
