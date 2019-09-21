import 'package:flutter/material.dart';
import 'package:flutter_mall/mode/ProductContentModel.dart';
import '../../services/ScreenAdapter.dart';
import '../../mode/ProductContentModel.dart';  //引入以后可以在下面定义  ProductContentItem 方便字段自动查询

class CartNum extends StatefulWidget {
  final ProductContentItem _productContent;
  CartNum(this._productContent,{Key key}):super(key: key);
  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  ProductContentItem _productContent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._productContent = widget._productContent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(170),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12)
      ),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      )
    );
  }
  // 左侧按钮
  Widget _leftBtn(){
    return InkWell(
      onTap: (){
        if(this._productContent.count >1) {
          setState(() {
            this._productContent.count --;
          });
        }
      },
      child: Container(
        width: ScreenAdapter.width(48),
        height: ScreenAdapter.height(48),
        alignment: Alignment.center,
        child: Icon(Icons.remove),
      ),
    );
  }
  // 右侧按钮
  Widget _rightBtn(){
    return InkWell(onTap: (){
      setState(() {
        this._productContent.count ++;
      });
    },child:Container(
      width: ScreenAdapter.width(48),
      height: ScreenAdapter.height(48),
      alignment: Alignment.center,
      child: Icon(Icons.add),
    ));
  }
  // 中间
  Widget _centerArea(){
    return Container(
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(48),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black12
          ),
          right: BorderSide(
              color: Colors.black12
          ),
        )
      ),
      child: Text('${this._productContent.count}'),
    );
  }

}
