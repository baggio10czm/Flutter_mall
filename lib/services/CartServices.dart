
class CartServices {

  static addCart(item){
    // 把对象转换成Map类型的数据
    item = CartServices.formatCartData(item);
    print(item);
  }

  // 过滤数据
  static formatCartData(item){
    final Map data = new Map<String, dynamic>();
    data['id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['count'] = item.count;
    data['selectedAttr'] = item.selectedAttr;
    data['pic'] = item.pic;
    //是否选中
    data['checked']= true;
    return data;
  }

}