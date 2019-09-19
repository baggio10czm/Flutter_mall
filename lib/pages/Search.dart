import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/SearchServices.dart';
import '../services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyword;
  List _historyListData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getHistoryData();
  }

  _getHistoryData() async {
    var searchHistory = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = searchHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: ScreenAdapter.height(68),
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, 0.8), borderRadius: BorderRadius.circular(30)),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
              onChanged: (value) {
                this._keyword = value;
              },
            ),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                width: ScreenAdapter.height(80),
                height: ScreenAdapter.height(68),
                child: Row(
                  children: <Widget>[Text('搜索')],
                ),
              ),
              onTap: () {
                SearchServices.setHistoryData(this._keyword);
                Navigator.pushReplacementNamed(context, '/productList', arguments: {'keyword': this._keyword});
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
              children: <Widget>[
                Text('热搜', style: Theme.of(context).textTheme.title),
                Divider(),
                Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('太难了'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('海淘'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('悲剧了'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('noNot'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('礼品'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('孩之宝玩具'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('钻石显卡G0051'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('黄金cPU'),
                    ),
                    Container(
                      margin: EdgeInsets.all(ScreenAdapter.width(12)),
                      padding: EdgeInsets.all(ScreenAdapter.width(10)),
                      decoration: BoxDecoration(color: Color.fromRGBO(233, 233, 233, .9), borderRadius: BorderRadius.circular(10)),
                      child: Text('魔兽世界怀旧'),
                    ),
                  ],
                ),
                SizedBox(height: ScreenAdapter.width(16)),
                _historyListWidget()
              ],
            )));
  }

  Widget _historyListWidget() {
    if (this._historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('历史记录', style: Theme.of(context).textTheme.title),
          Divider(),
          Column(
              children: this._historyListData.map((item) {
            return Column(children: <Widget>[
              ListTile(title: Text("$item"),onLongPress:(){
                  this._showAlertDialog(item);
              }),
              Divider()
            ]);
          }).toList()),
          SizedBox(height: 60),
          InkWell(
              onTap: () {
                SearchServices.clearHistory();
                this._getHistoryData();
              },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, .9),
                  borderRadius: BorderRadius.circular(20),
//                    border: Border.all(color: Colors.black45, width: 1)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(Icons.delete), Text('清空历史记录')],
                ),
              ))
        ],
      );
    } else {
      return Text('毫无历史记录');
    }
  }

  void _showAlertDialog(keywords) async{

    var result= await showDialog(
        barrierDismissible:false,   //表示点击灰色背景的时候是否消失弹出框
        context:context,
        builder: (context){
          return AlertDialog(
            title: Text("提示信息!"),
            content:Text("您确定要删除吗?") ,
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: (){
                  print("取消");
                  Navigator.pop(context,'Cancle');
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async{
                  //注意异步!
                  await SearchServices.removeHistoryData(keywords);
                  this._getHistoryData();
                  Navigator.pop(context,"Ok");
                },
              )
            ],

          );
        }
    );

    //  print(result);
  }


}
