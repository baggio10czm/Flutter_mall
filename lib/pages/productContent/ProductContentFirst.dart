import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../services/CartServices.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JdButton.dart';
import '../../config/Config.dart';
import 'CartNum.dart';
import 'package:provider/provider.dart';
import '../../provider/Cart.dart';
import '../../provider/Checkout.dart';
import '../../services/UserServices.dart';

// 广播引入
import '../../services/EventBus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductContentFirst extends StatefulWidget {
  final _productContentItem;

  ProductContentFirst(this._productContentItem, {Key key}) : super(key: key);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin {
  List attr = [];
  String _selectAttrData = '';
  var actionEventBus;
  var _productContent;
  Cart cartProvider;
  Checkout checkoutProvider;

  // 在pageView 和 TabBarView子页面里继承 AutomaticKeepAliveClientMixin 设置 wantKeepAlive = true 就可以缓存页面
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent = widget._productContentItem;
    attr = _productContent.attr;
    // 制作属性数据
    _makeAttrList();
    // 所选属性
    _makeSelectAttrData();
    //监听ProductContentEvent广播
    actionEventBus = eventBus.on<ProductContentEvent>().listen((event) {
      print('触发ProductContentFirst的方法');
      this._attrBottomSheet();
    });
    // 监听所有广播 去掉  <ProductContentEvent>
    //eventBus.on().listen((event){
    //  print(event);
    //});
  }

  //组件销毁时，一定要取消广播监听
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    actionEventBus.cancel();
  }

  @override
  Widget build(BuildContext context) {
    this.cartProvider = Provider.of<Cart>(context);

    String pic = Config.domain + _productContent.pic.toString().replaceAll('\\', '/');
    checkoutProvider = Provider.of<Checkout>(context);

    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(18), ScreenAdapter.width(18), ScreenAdapter.width(18), ScreenAdapter.width(88)),
      child: ListView(
        children: <Widget>[
          // 图
          AspectRatio(aspectRatio: 16 / 9, child: Image.network(pic, fit: BoxFit.cover)),
          // 标题
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${_productContent.title}",
                style: TextStyle(color: Colors.black87, fontSize: ScreenAdapter.size(32)),
              ),
              SizedBox(height: ScreenAdapter.height(8)),
              Text("${_productContent.subTitle}", style: TextStyle(color: Colors.black54, fontSize: ScreenAdapter.size(28))),
            ],
          )),
          // 价格
          Container(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Row(children: <Widget>[
                      Text('特价'),
                      Text('￥${_productContent.price}', style: TextStyle(color: Colors.red, fontSize: ScreenAdapter.size(36)))
                    ])),
                Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                      Text('原价'),
                      Text(
                        '￥${_productContent.oldPrice}',
                        style: TextStyle(color: Colors.black26, fontSize: ScreenAdapter.size(26), decoration: TextDecoration.lineThrough),
                      )
                    ]))
              ],
            ),
          ),
          // 规格
          Container(
            child: Column(
              children: <Widget>[
                this.attr.length > 0
                    ? Container(
                        margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
                        height: ScreenAdapter.height(66),
                        child: InkWell(
                          onTap: () {
                            _attrBottomSheet();
                          },
                          child: Row(
                            children: <Widget>[Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)), Text(_selectAttrData)],
                          ),
                        ))
                    : Text(''),
                Divider(),
                Container(
                  height: ScreenAdapter.height(66),
                  child: Row(
                    children: <Widget>[
                      Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: ScreenAdapter.width(20)),
                      Text("满68元免运费")
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 制作 attr 数据集合 + checked 属性方便数据使用,统计
  void _makeAttrList() {
    for (var i = 0; i < attr.length; ++i) {
      // TabBar切换会触发iniStatus 避免数据重复添加 先清空数组 用clear()
      attr[i].attrList.clear();
      for (var j = 0; j < attr[i].list.length; ++j) {
        attr[i].attrList.add({
          'title': attr[i].list[j],
          'checked': j == 0 ? true : false,
        });
      }
    }
  }

  // 属性Widget
  List<Widget> _makeAttrWidget(setBottomSheetStatus) {
    var list = attr.map((item) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: ScreenAdapter.width(170),
              padding: EdgeInsets.only(top: ScreenAdapter.height(18)),
              child: Text('${item.cate}:', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700))),
          Expanded(flex: 1, child: Wrap(children: this._attrItemWidget(item.cate, item.attrList, setBottomSheetStatus)))
        ],
      );
    });
    return list.toList();
  }

  // 改变属性处理
  void _changeAttrSelect(attrList, title, setBottomSheetStatus) {
    setBottomSheetStatus(() {
      // 方式① 传 cate 来对比找到对应 attrList
      // for (var i = 0; i < attr.length; ++i) {
      //   if(attr[i].cate == cate){
      //     for (var j = 0; j < attr[i].attrList.length; ++j) {
      //       if(attr[i].attrList[j]['title'] == title){
      //         attr[i].attrList[j]['checked'] = true;
      //       }else{
      //         attr[i].attrList[j]['checked'] = false;
      //       }
      //     }
      //   }
      // }
      // 方式② 直接传 attrList 过来直接处理
      for (var i = 0; i < attrList.length; ++i) {
        if (attrList[i]['title'] == title) {
          attrList[i]['checked'] = true;
        } else {
          attrList[i]['checked'] = false;
        }
      }
    });
  }

  // 计算选中属性值
  void _makeSelectAttrData() {
    var tmpList = [];
    for (var i = 0; i < attr.length; ++i) {
      for (var j = 0; j < attr[i].attrList.length; ++j) {
        if (attr[i].attrList[j]['checked']) {
          tmpList.add(attr[i].attrList[j]['title']);
        }
      }
    }
    setState(() {
      this._selectAttrData = tmpList.join(',');
    });
    // 给选择属性赋值
    this._productContent.selectedAttr = this._selectAttrData;
  }

  // 属性子项目Widget  注意 attrList 前面要+List才能map
  List<Widget> _attrItemWidget(cate, List attrList, setBottomSheetStatus) {
    return attrList.map((item) {
      return Container(
          margin: EdgeInsets.only(left: ScreenAdapter.width(12), right: ScreenAdapter.width(12)),
          child: InkWell(
              onTap: () {
                this._changeAttrSelect(attrList, item['title'], setBottomSheetStatus);
                this._makeSelectAttrData();
              },
              child: Chip(
                  label: Text(
                    '${item['title']}',
                    style: TextStyle(color: item['checked'] ? Colors.white : Colors.black87),
                  ),
                  padding: EdgeInsets.all(6),
                  backgroundColor: item['checked'] ? Colors.redAccent : Colors.black12)));
    }).toList();
  }

  // 属性底部弹框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          // StatefulBuilder 用来更新底部弹框状态 需要传递setBottomSheetStatus 下去
          return StatefulBuilder(builder: (BuildContext context, setBottomSheetStatus) {
            // 加GestureDetector手势检测, 解决弹出层点击消时的问题(不加好像也没问题,就没加了),配置behavior 解决穿透问题
            // GestureDetector(behavior: HitTestBehavior.opaque,onTap: (){})
            return Container(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: ScreenAdapter.height(76)),
                    child: ListView(children: <Widget>[
                      Column(
                        children: this._makeAttrWidget(setBottomSheetStatus),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
                        height: ScreenAdapter.height(66),
                        child: Row(
                          children: <Widget>[Text("数量: ", style: TextStyle(fontWeight: FontWeight.bold)), CartNum(_productContent)],
                        ),
                      ),
                    ]),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: ScreenAdapter.width(750),
                        height: ScreenAdapter.height(88),
                        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color.fromRGBO(211, 211, 211, .8)))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              child: JdButton(
                                text: '加入购物车',
                                color: Colors.redAccent,
                                callBack: () async {
                                  // 把商品添加到缓存中
                                  await CartServices.addCart(this._productContent);
                                  // 关闭选择属性弹框
                                  Navigator.of(context).pop();
                                  // 调用 Provider 更新数据
                                  cartProvider.updateCartList();
                                  Fluttertoast.showToast(
                                    msg: "已加入购物车",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                },
                              ),
                            )),
                            Expanded(
                                child: Container(
                              child: JdButton(
                                text: '立即购买',
                                color: Colors.orangeAccent,
                                callBack: () async {
                                  // 必须把对象转换成Map类型的数据,并过滤 !!!!!!
                                  List tempList = [CartServices.formatCartData(this._productContent)];
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
                                },
                              ),
                            ))
                          ],
                        ),
                      ))
                ],
              ),
            );
          });
        });
  }
}
