import 'package:flutter/material.dart';
import 'routers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          primaryColor: Colors.redAccent, backgroundColor: Colors.white),
    );
  }
}
