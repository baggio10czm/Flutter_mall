import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class ProductContentSecond extends StatefulWidget {
  final _productContentItem;
  ProductContentSecond(this._productContentItem, {Key key}) : super(key: key);

  @override
  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin {
  double progress;

  // 在pageView 和 TabBarView子页面里继承 AutomaticKeepAliveClientMixin 设置 wantKeepAlive = true 就可以缓存页面
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget._productContentItem.sId);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: InAppWebView(
            initialUrl: "http://jd.itying.com/pcontent?id=${widget._productContentItem.sId}",
            onProgressChanged: (InAppWebViewController controller, int progress) {
              setState(() {
                this.progress = progress/100;
              });
            },
          ))
        ],
      ),
    );
  }
}
