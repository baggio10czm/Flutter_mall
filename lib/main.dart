import 'package:flutter/material.dart';
import 'routers/router.dart';
import 'package:provider/provider.dart';
import 'provider/Cart.dart';
import 'provider/Checkout.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (_)=> Cart()),
      ChangeNotifierProvider(builder: (_)=> Checkout())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          primaryColor: Colors.white, backgroundColor: Colors.white),
    ));
  }
}
