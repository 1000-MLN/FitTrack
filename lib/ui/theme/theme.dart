import 'package:flutter/material.dart';



ThemeData _baseTheme = ThemeData(
  fontFamily: 'Lexend',
  scrollbarTheme: ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all<bool>(true),
      thumbColor: WidgetStateProperty.all<Color>(Colors.transparent)),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontSize: 24, color: Colors.white),
        titleLarge: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ), 
      // buttonTheme: ButtonThemeData(
      //   buttonColor: const Color(0xFFC5AEF6),
      // ),
      primaryColor: const Color(0xFFC5AEF6)

);

ThemeData darkTheme = _baseTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardColor: const Color(0xFFD6C5F9),
  
);

ThemeData lightTheme = _baseTheme.copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
    cardColor: const Color(0xFFD6C5F9),



 
);
