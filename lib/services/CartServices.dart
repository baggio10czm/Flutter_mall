import 'dart:convert';
import '../config/Config.dart';

import 'Storage.dart';

class CartServices {

  static addCart(item)async{
    // 把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    print(item);

    // 没有数据会报错，所以要用try...catch
    try {
      var cartListData = json.decode(await Storage.getString('cartList'));
      print(cartListData);

      // 有数据时，判断当前数据有不有keyword,有的话不处理
      bool hasData = cartListData.any((value) {
        return value['_id'] == item['_id'] && value['selectedAttr'] == item['selectedAttr'];
      });

      if (!hasData) {
        // 没有的话，添加...
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }else {
        // 有的话，找到对应项目 数量+1
        for (var i = 0; i < cartListData.length; ++i) {
          if(cartListData[i]['_id'] == item['_id'] && cartListData[i]['selectedAttr'] == cartListData[i]['selectedAttr']){
            cartListData[i]['count']++;
          }
        }
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (err) {
      // 没有数据进入catch
      List tempList = new List();
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }

  }

  // 过滤数据
  static formatCartData(item){
    String pic = Config.domain +  item.pic.toString().replaceAll('\\', '/');
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['count'] = item.count;
    data['selectedAttr'] = item.selectedAttr;
    data['pic'] = pic;
    //是否选中
    data['checked']= true;
    return data;
  }


}