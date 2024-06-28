import 'package:flutter/material.dart';

class DarkTheme {
  ThemeData get theme => ThemeData(
      textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 25.0)
      ),
      brightness: Brightness.dark,
      primaryColor: Color(0xFF2c4a44),
      scaffoldBackgroundColor: Color(0xFF1a322e),
      cardColor: Color(0xFF2c4a44),
      focusColor: Color(0xFF549e66),
      canvasColor: Colors.white,
      shadowColor: Color(0xFF3b7a6f),
      indicatorColor: Color(0xFF0e1715),
      primaryColorLight: Colors.white,
      primaryColorDark: Colors.black,
      backgroundColor: Color(0xFF222222),
      hoverColor: Color(0xFF1f1f1f),
      dividerColor: Color(0xFF222222));

}
