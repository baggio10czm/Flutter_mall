import 'dart:convert';

import 'Storage.dart';

class UserServices{

  static getUserInfo() async{
    List userInfo;
    try {
      userInfo = json.decode(await Storage.getString('userInfo'));
    } catch (err) {
      userInfo = [];
    }
    return userInfo;
  }

  static getUserLoginState() async{
    var userInfo = await UserServices.getUserInfo();
    if(userInfo.length > 0 && userInfo[0]['name'] != ""){
      return true;
    }
    return false;
  }

  static loginOut(){
    Storage.remove('userInfo');
  }
  
}