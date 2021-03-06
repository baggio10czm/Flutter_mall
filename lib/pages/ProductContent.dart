import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall/services/ScreenAdapter.dart';
import 'productContent/ProductContentFirst.dart';
import 'productContent/ProductContentSecond.dart';
import 'productContent/ProductContentThird.dart';
import '../widget/JdButton.dart';
import '../widget/LoadingWidget.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';
import '../mode/ProductContentModel.dart';
import 'package:provider/provider.dart';
import '../provider/Cart.dart';
import '../services/CartServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../provider/Checkout.dart';
import '../services/UserServices.dart';

// 广播引入
import '../services/EventBus.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  ProductContentPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  ProductContentItem _productContentItem;
  Checkout checkoutProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getProductContent();
  }

  void _getProductContent() async {
    String api = Config.domain + 'api/pcontent?id=' + widget.arguments['id'];
    var response = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(response.data);
    setState(() {
      this._productContentItem = productContent.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    checkoutProvider = Provider.of<Checkout>(context);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  width: ScreenAdapter.width(400),
                  child: TabBar(
                      indicatorColor: Colors.redAccent,
                      labelColor: Colors.black54,
                      unselectedLabelColor: Colors.black54,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: <Widget>[Tab(text: '商品'), Tab(text: '详情'), Tab(text: '评价')]))
            ]),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(context: context, position: RelativeRect.fromLTRB(ScreenAdapter.width(600), 80, 10, 0), items: [
                      PopupMenuItem(
                          child: Row(
                        children: <Widget>[Icon(Icons.home), Text('首页')],
                      )),
                      PopupMenuItem(
                          child: Row(
                        children: <Widget>[Icon(Icons.search), Text('搜索')],
                      )),
                    ]);
                  })
            ],
          ),
          body: this._productContentItem?.sId != null
              ? Stack(
                  children: <Widget>[
                    // 中间切换页面
                    TabBarView(
                        //禁止滑动切换页面,优化体验
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          ProductContentFirst(this._productContentItem),
                          ProductContentSecond(this._productContentItem),
                          ProductContentThird(),
                        ]),
                    // 底部button区
                    Positioned(
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(88),
                      bottom: 0,
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, border: Border(top: BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 0.8)))),
                        child: Row(
                          children: <Widget>[
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/cart');
                                },
                                child: Container(
                                    width: ScreenAdapter.width(180),
                                    padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                                    child: Column(children: <Widget>[
                                      Icon(
                                        Icons.shopping_cart,
                                        size: ScreenAdapter.size(36),
                                      ),
                                      Text('购物车', style: TextStyle(fontSize: ScreenAdapter.size(24)))
                                    ]))),
                            Expanded(
                                flex: 1,
                                child: JdButton(
                                    text: '加入购物车',
                                    color: Colors.redAccent,
                                    callBack: () async {
                                      if (this._productContentItem.attr.length > 0) {
                                        // 商品有属性,就弹起 ProductContentFirst 的底部属性弹框
                                        eventBus.fire(ProductContentEvent('加入购物车'));
                                      } else {
                                        // 把商品添加到缓存中
                                        await CartServices.addCart(this._productContentItem);
                                        // 调用 Provider 更新数据
                                        cartProvider.updateCartList();
                                        Fluttertoast.showToast(
                                          msg: "已加入购物车",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                    })),
                            Expanded(
                                flex: 1,
                                child: JdButton(
                                  text: '立即购买',
                                  color: Colors.orangeAccent,
                                  callBack: () async {
                                    if (this._productContentItem.attr.length > 0) {
                                      // 商品有属性,就弹起 ProductContentFirst 的底部属性弹框
                                      eventBus.fire(ProductContentEvent('立即购买'));
                                    } else {
                                      // 必须把对象转换成Map类型的数据,并过滤 !!!!!!
                                      List tempList = [CartServices.formatCartData(this._productContentItem)];
                                      // 保存购物车选中数据到 结算provider
                                      checkoutProvider.changeCheckoutListData(tempList);
                                      // 判断用户是否登录,保存购物车选中数据
                                      // 异步方法记得加 await
                                      if (await UserServices.getUserLoginState()) {
                                        Navigator.pushNamed(context, '/checkout');
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "先登录",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                        Navigator.pushNamed(context, '/login');
                                      }
                                    }
                                  },
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : LoadingWidget(),
        ));
  }
}
