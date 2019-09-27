import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class SignServices{

  static getSign(Map jsonData){
    // 将所有key转换成数组
    List attrKeys = jsonData.keys.toList();
    // 排序 按照ASCII码
    attrKeys.sort();

    String str ='';
    for (var i = 0; i < attrKeys.length; ++i) {
      str+="${attrKeys[i]}${jsonData[attrKeys[i]]}";
    }
    // print(str);
    // print(md5.convert(utf8.encode(str)));

    // 必须转换成字符串
    return md5.convert(utf8.encode(str)).toString();
  }

}