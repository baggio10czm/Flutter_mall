import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../services/ScreenAdapter.dart';
import '../../config/Config.dart';
import '../../mode/CategoryModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCategory = [];
  List _categoryProduct = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getLeftCategory();
  }


  // 左侧分类
  _getLeftCategory() async{
    String api = '${Config.domain}api/pcate';
    var response = await Dio().get(api);
    var leftCategory = CategoryModel.fromJson(response.data);
    setState(() {
      this._leftCategory = leftCategory.result;
    });
    this._getCategoryProduct(this._leftCategory[0].sId);
  }

  // 右侧分类商品
  _getCategoryProduct(id) async{
    String api = '${Config.domain}api/pcate?pid=$id';
    var response = await Dio().get(api);
    var categoryProduct = CategoryModel.fromJson(response.data);
    setState(() {
      this._categoryProduct = categoryProduct.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ScreenAdapter 必须先初始化
    ScreenAdapter.init(context);
    // 得到屏幕宽度
    var screenWidth = ScreenAdapter.getScreenWidth();
    // 计算左侧占屏幕1/4的宽度
    var leftWidth = screenWidth / 4;
    // 计算右侧 GridView 每一项宽度 = 右侧总宽度 - 外部padding值 - GridView间距值 除以3
    var rightItemWidth = (screenWidth - leftWidth - 20 - 20) / 3;
    // 因后面高度是用ScreenAdapter转化的来计算，所以宽度也要先转换一下
        rightItemWidth = ScreenAdapter.width(rightItemWidth);
        // 计算GridView 每一项高度，用来设置GridView宽高比
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        this.leftCategoryWidget(leftWidth),
        this.rightCategoryProductWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }

  Widget leftCategoryWidget(leftWidth){
    if(this._leftCategory.length > 0){
      return Container(
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(itemCount:this._leftCategory.length,itemBuilder: (context, index){
            return Column(
              children: <Widget>[
                InkWell(
                    onTap: (){
                      setState(() {
                        this._selectIndex = index;
                      });
                      this._getCategoryProduct(this._leftCategory[index].sId);
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(84),
                      padding: EdgeInsets.only(top:ScreenAdapter.height(24)),
                      color: _selectIndex==index? Color.fromRGBO(240, 246, 246, 0.9):Colors.white,
                      child: Text('${this._leftCategory[index].title}',textAlign: TextAlign.center),
                    )
                ),
                Divider(height: 1)
              ],
            );
          })
      );
    }else{
      return Container(
          width: leftWidth,
          height: double.infinity
      );
    }
  }

  Widget rightCategoryProductWidget(rightItemWidth, rightItemHeight){
    if(this._categoryProduct.length > 0) {
      return Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9),
              child: GridView.builder(
                  itemCount: this._categoryProduct.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: rightItemWidth/rightItemHeight,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemBuilder: (context, index){
                    String pic = Config.domain + this._categoryProduct[index].pic.toString().replaceAll('\\', '/');
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/productList',arguments: {'pid': this._categoryProduct[index].sId});
                      },
                      child: Container(
                          child: Column(
                            children: <Widget>[
                              AspectRatio(aspectRatio: 1/1,child:Image.network(pic, fit: BoxFit.cover)),
                              Container(
                                height: ScreenAdapter.height(28),
                                child: Text('${this._categoryProduct[index].title}'),
                              )
                            ],
                          )
                      )
                    );
                  })
          ));
    }else{
      return Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.all(10),
              height: double.infinity,
              color: Color.fromRGBO(240, 246, 246, 0.9)));
    }

  }
}
