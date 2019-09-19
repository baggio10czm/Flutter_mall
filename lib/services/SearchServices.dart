import 'dart:convert';
import 'Storage.dart';

class SearchServices {

  static setHistoryData(keyword) async {
    // 没有数据会报错，所以要用try...catch
    try {
      var searchListData = json.decode(await Storage.getString('searchList'));
      print(searchListData);

      // 有数据时，判断当前数据有不有keyword,有的话不处理
      bool hasData = searchListData.any((v) {
        return v == keyword;
      });

      // 没有的话，添加...
      if (!hasData) {
        searchListData.add(keyword);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch (err) {
      // 没有数据进入catch
      print(err);
      List tempList = new List();
      tempList.add(keyword);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getHistoryList() async {
    try {
      var searchListData = json.decode(await Storage.getString('searchList'));
      return searchListData;
    } catch (err) {
      // 没有数据进入catch
      return [];
    }
  }

  static clearHistory() async{
    await Storage.remove('searchList');
  }

  static removeHistoryData(keyword) async{
    var searchListData = json.decode(await Storage.getString('searchList'));
    searchListData.remove(keyword);
    await Storage.setString('searchList', json.encode(searchListData));
  }
}
