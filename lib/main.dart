import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/my_colors.dart';
import 'screens/article_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: ArticleScreen(),
//        routes: {
//          Library.routeName: (ctx) => Library(),
//          EditArticleScreen.routeName: (ctx) => EditArticleScreen(),
//        },
    );
  }
}
