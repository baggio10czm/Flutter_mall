import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context){
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }
  static height(double value){
    return ScreenUtil.getInstance().setHeight(value);
  }
  static width(double value){
    return ScreenUtil.getInstance().setWidth(value);
  }

  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }

  static size(double size){
    return ScreenUtil.getInstance().setSp(size);
  }
}