import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/Storage.dart';

class Cart with ChangeNotifier {
  List _carList = [];
  bool _isCheckedAll = false;

  // 获取状态
  List get carList => _carList;
  bool get isCheckedAll => _isCheckedAll;

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
    //判断全选的状态
    this._isCheckedAll = this.isCheckAll();
    notifyListeners();
  }

  updateCartList(){
    this.init();
  }
  // 改变数量，每次_carList改变都需要更新缓存
  itemCountChange(){
    Storage.setString('cartList', json.encode(_carList));
    notifyListeners();
  }
  // 全选，反选,每次_carList改变都需要更新缓存
  checkAll(value){
    for (var i = 0; i < carList.length; ++i) {
      carList[i]['checked']=value;
    }
    this._isCheckedAll = value;
    Storage.setString('cartList', json.encode(_carList));
    notifyListeners();
  }
  // 判断是否全选
  bool isCheckAll(){
    return !(carList.any((item){
      return item['checked'] == false;
    }));
  }
  //监听每一项的点击事件,每次_carList改变都需要更新缓存
  itemChange(){
    this._isCheckedAll = this.isCheckAll();
    Storage.setString('cartList', json.encode(_carList));
    notifyListeners();
  }
}
