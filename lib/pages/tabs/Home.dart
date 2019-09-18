import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart';
import '../../services/ScreenAdapter.dart';
import '../../config/Config.dart';
import '../../mode/FocusModel.dart';
import '../../mode/ProductModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List _focusList = [];
  List _likeProductList = [];
  List _recProductList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFocus();
    _getLikeProduct();
    _getRecProduct();
  }

  // 轮播图
  _getFocus() async{
    String api = '${Config.domain}api/focus';
    var response = await Dio().get(api);
    var focus = FocusModel.fromJson(response.data);
    setState(() {
      this._focusList = focus.result;
    });
  }

  // 猜你喜欢
  _getLikeProduct() async{
    String api = '${Config.domain}api/plist?is_hot=1';
    var response = await Dio().get(api);
    var likeProduct = ProductModel.fromJson(response.data);
    setState(() {
      this._likeProductList = likeProduct.result;
    });
  }

  // 推荐商品
  _getRecProduct() async{
    String api = '${Config.domain}api/plist?is_best=1';
    var response = await Dio().get(api);
    var recProduct = ProductModel.fromJson(response.data);
    setState(() {
      this._recProductList = recProduct.result;
    });
    //print(this._recProductList);
    //print(this._recProductList.length);
  }


  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        // 轮播图
        this._swiperWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        this._titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdapter.height(20)),
        // 猜你喜欢
        this._likeProductListWidget(),
        this._titleWidget('热门推荐'),
        // 热门推荐
        this._recProductItemWidget()
      ],
    );
  }

  // 轮播图
  Widget _swiperWidget(){
    if(_focusList.length > 0){
      return AspectRatio(aspectRatio: 2/1, child:Swiper(
        itemBuilder: (BuildContext context,int index){
          String pic = _focusList[index].pic;
          return new Image.network('${Config.domain}${pic.replaceAll('\\', '/')}',fit: BoxFit.fill);
        },
        itemCount: _focusList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ));
    }else{
      return Text('loading……');
    }
  }

  // 标题组件
  Widget _titleWidget(value){
    return Container(
        height: ScreenAdapter.height(35),
        margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
        padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.red,width: ScreenAdapter.height(10))
          )
        ),
        child: Text(value,style: TextStyle(color: Colors.black54)));
  }

  // 猜你喜欢-商品
  Widget _likeProductListWidget(){
    if(this._likeProductList.length > 0 ){
      return Container(
        width: double.infinity,
        height: ScreenAdapter.height(230),
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView.builder(scrollDirection:Axis.horizontal,itemCount: this._likeProductList.length,itemBuilder: (context,int index){
          String sPic = Config.domain + this._likeProductList[index].sPic.toString().replaceAll('\\', '/');
          return Column(
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(140),
                height: ScreenAdapter.height(140),
                margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                child: Image.network(sPic),
              ),
              Container(
                width: ScreenAdapter.width(140),
                height: ScreenAdapter.height(40),
                padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                child: Text('￥${this._likeProductList[index].price}',overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.red)),
              )
            ],
          );
        }),
      );
    }else{
      return Text('加载中...');
    }
  }

  // 推荐商品
  Widget _recProductItemWidget(){
    if(this._recProductList.length > 0 ){
      double itemWidth = (ScreenAdapter.getScreenWidth() - 30) /2;
      return Container(
        padding: EdgeInsets.all(10),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: this._recProductList.map((value){
            String pic = Config.domain + value.pic.toString().replaceAll('\\', '/');
            return Container(
              width: itemWidth,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Color.fromRGBO(233, 233, 233, 0.9))
              ),
              child: Column(
                children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(  // 用 AspectRatio 防止服务器的图片比例不统一
                    aspectRatio: 1/1,
                    child: Image.network(pic, fit: BoxFit.cover) ,
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(value.title,
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('${value.price}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('${value.oldPrice}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }else {
      return Text('加载中......');
    }
  }

}
