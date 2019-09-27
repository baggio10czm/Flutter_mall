import 'package:event_bus/event_bus.dart';

// 初始化
EventBus eventBus = EventBus();

class ProductContentEvent{
  String str;

  ProductContentEvent(String str){
    this.str = str;
  }
}

// 用户中心广播
class UserEvent {
  String str;
  UserEvent(String str){
    this.str = str;
  }
}

// 地址列表广播
class AddressEvent {
  String str;
  AddressEvent(String str){
    this.str = str;
  }
}

// 结算页面广播
class CheckoutEvent {
  String str;
  CheckoutEvent(String str){
    this.str = str;
  }
}