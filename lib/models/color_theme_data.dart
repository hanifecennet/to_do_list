import 'package:flutter/material.dart';

class ColorThemeData with ChangeNotifier{ //changenotifer -> yayinlama
  final ThemeData purpleTheme = ThemeData(
        primaryColor: Colors.purple,
        primarySwatch: Colors.purple, //mor ve morun tonlari
        scaffoldBackgroundColor: Colors.purple[400],
        accentColor: Colors.deepPurple, //buton
        appBarTheme: AppBarTheme(color:  Colors.purple),
        textTheme: TextTheme(subtitle1:  TextStyle(color: Colors.white), headline3: TextStyle(color: Colors.white) ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        );

  final ThemeData orangeTheme = ThemeData(
        primaryColor: Colors.orange[800],
        primarySwatch: Colors.orange, 
        scaffoldBackgroundColor: Colors.orange[400],
        accentColor: Colors.deepOrange, //buton
        appBarTheme: AppBarTheme(color:  Colors.orange[800]),
        textTheme: TextTheme(subtitle1:  TextStyle(color: Colors.white), headline3: TextStyle(color: Colors.white) ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        );

  ThemeData _selectedThemeData = ThemeData(
      primaryColor: Colors.purple,
      primarySwatch: Colors.purple, //mor ve morun tonlari
      scaffoldBackgroundColor: Colors.purple[400],
      accentColor: Colors.deepPurple, //buton
      appBarTheme: AppBarTheme(color:  Colors.purple),
      textTheme: TextTheme(subtitle1:  TextStyle(color: Colors.white), headline3: TextStyle(color: Colors.white) ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      );
  void switchTheme(bool selected) //disardan erisip selectedTheme degisme
  {
    _selectedThemeData = selected ? purpleTheme : orangeTheme; // _ private olmasini saglar
    notifyListeners();
  }
  //get ile erisim saglanir private oldg ici
  ThemeData get selectedThemeData=>_selectedThemeData;
}