import 'package:flutter/material.dart';
ThemeData _baseTheme = ThemeData(
  fontFamily: 'Lexend',
  scrollbarTheme: ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all<bool>(true),
    thumbColor: WidgetStateProperty.all<Color>(Colors.transparent),
    
  ),
   textTheme: const TextTheme(
     bodyLarge: TextStyle(fontSize: 24,),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 52, fontWeight: FontWeight.bold,
      )
  ),
  primaryColor: const Color(0xFFC5AEF6),
);

ThemeData darkTheme = ThemeData(
      fontFamily: 'Lexend',

  
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFC5AEF6),

    
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color(0xFFD6C5F9),
  textTheme:  _baseTheme.textTheme.copyWith(
     bodyLarge: TextStyle(fontSize: 24, color: Colors.white),
        titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        headlineLarge: TextStyle(fontSize: 35, color: Colors.white)
  )
);

ThemeData lightTheme = ThemeData(

    fontFamily: 'Lexend',

    brightness: Brightness.light,
  primaryColor: const Color(0xFFC5AEF6),

  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xFFD6C5F9),
  textTheme:  _baseTheme.textTheme.copyWith(
   bodyLarge: TextStyle(fontSize: 24, color: Colors.black),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      headlineLarge: TextStyle(fontSize: 35, color: Colors.black)
  ),
);
