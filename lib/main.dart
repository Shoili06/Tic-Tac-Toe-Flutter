import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primaryColor: Colors.black),
      home: new HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
