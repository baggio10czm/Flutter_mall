import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mall/mode/FocusModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFocus();
  }

  _getFocus() async{

    String api = 'http://jd.itying.com/api/focus';
    var response = await Dio().get(api);
    print(response);
    var focus = FocusModel.fromJson(response.data);

    setState(() {
      this._focusList = focus.result;
    });
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
        this._hotProductListWidget(),
        this._titleWidget('热门推荐'),
        // 热门推荐
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        )
      ],
    );
  }

  // 轮播图
  Widget _swiperWidget(){
    if(_focusList.length > 0){
      return AspectRatio(aspectRatio: 2/1, child:Swiper(
        itemBuilder: (BuildContext context,int index){
          String pic = _focusList[index].pic;
          return new Image.network('http://jd.itying.com/${pic.replaceAll('\\', '/')}',fit: BoxFit.fill);
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

  // 热门商品
  Widget _hotProductListWidget(){
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(230),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ListView.builder(scrollDirection:Axis.horizontal,itemCount: 10,itemBuilder: (context,int index){
        return Column(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(140),
              height: ScreenAdapter.height(140),
              margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
              child: Image.network('https://www.itying.com/images/flutter/hot${index+1}.jpg'),
            ),
            Container(
              width: ScreenAdapter.width(140),
              height: ScreenAdapter.height(40),
              padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
              child: Text('第${index+1}个李阿斯顿AF',overflow: TextOverflow.ellipsis),
            )
          ],
        );
      }),
    );
  }

  // 推荐商品
  _recProductItemWidget(){
    double itemWidth = (ScreenAdapter.getScreenWidth() - 30) /2;
    return Container(
      width: itemWidth,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1,color: Color.fromRGBO(233, 233, 233, 0.9))
      ),
      child: Column(
        children: <Widget>[
          AspectRatio(  // 用 AspectRatio 防止服务器的图片比例不统一
            aspectRatio: 1/1,
            child: Image.network('https://www.itying.com/images/flutter/list1.jpg', fit: BoxFit.cover) ,
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Text('2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码',
                maxLines: 2,overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54)),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "¥188.0",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("¥198.0",
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
  }
}
