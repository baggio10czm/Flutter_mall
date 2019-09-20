import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/Counter.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    Counter countProvider = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('用户'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.launch), onPressed: null)
        ],
      ),
      body: Column(
        children: <Widget>[
          Text('用户中心')
        ],
      ),
    );;
  }
}
