import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
    );
  }
}
