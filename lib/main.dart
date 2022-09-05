import 'package:flutter/material.dart';
import 'package:to_do_list/models/color_theme_data.dart';
import 'package:to_do_list/screens/home_page.dart';
import 'package:to_do_list/screens/splash_screen.dart';
import './screens/home_page.dart';
import 'package:provider/provider.dart'; 

void main() 
{
  runApp(ChangeNotifierProvider<ColorThemeData>(
    create: (BuildContext context) => ColorThemeData(), child: MyApp()));
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ColorThemeData>(context).selectedThemeData, //secili temaya gore sekil alma
      home: ScreenSplash(),
    );
  }
}

