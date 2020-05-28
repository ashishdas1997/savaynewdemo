import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savaynewdemo/screens/articles.dart';
import 'models/my_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Savay',
      theme: ThemeData(
          fontFamily: 'sen',
          primaryColor: MyColor.primaryColor,
          primaryColorDark: MyColor.primaryDarkColor,
          primaryColorLight: MyColor.primaryLightColor,
          accentColor: MyColor.primaryAssentColor),
      home: Articles(),
    );
  }
}
