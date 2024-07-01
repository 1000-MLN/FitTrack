import 'package:flutter/material.dart';

const Color black = Color.fromARGB(255, 10, 9, 9);
const Color white = Color(0xFFE5E5E5);
const Color purple = Color(0xFFC5AEF6);
const Color darkPurple = Color(0xFF4F3682);

ThemeData _baseTheme = ThemeData(
  fontFamily: 'Lexend',
  scrollbarTheme: ScrollbarThemeData(
    thumbVisibility: WidgetStateProperty.all<bool>(true),
    thumbColor: WidgetStateProperty.all<Color>(Colors.transparent),
  ),
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 24,
      ),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
        fontSize: 52,
        fontWeight: FontWeight.bold,
      )),
  primaryColor: const Color(0xFFC5AEF6),
);

ThemeData darkTheme = ThemeData(
    dividerColor: Colors.transparent,
    fontFamily: 'Lexend',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF4F3682),
    secondaryHeaderColor: const Color.fromARGB(255, 42, 42, 42),
    scaffoldBackgroundColor: black,
    cardColor: const Color(0xFF4F3682),
    dialogTheme: const DialogTheme(
      contentTextStyle: TextStyle(fontSize: 24, color: white),
      titleTextStyle:
          TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: white),
    ),
    textTheme: _baseTheme.textTheme.copyWith(
        bodyMedium:
            const TextStyle(fontSize: 18, color: white), //text in the body
        bodyLarge: const TextStyle(
            fontSize: 24, color: white), //common text, button text
        titleLarge: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: white),
        titleMedium: const TextStyle(fontSize: 24, color: white),
        headlineLarge:
            const TextStyle(fontSize: 35, color: white), // appbar texts
                headlineMedium: const TextStyle(fontSize: 20, color: white),//text workout process

        labelMedium: const TextStyle(fontSize: 24, color: white),
        displayMedium: const TextStyle(fontSize: 24, color: white),
        displayLarge: const TextStyle(
          fontSize: 42,
          color: white,
        )));

ThemeData lightTheme = ThemeData(
  dividerColor: Colors.transparent,
  fontFamily: 'Lexend',
  brightness: Brightness.light,
  primaryColor: const Color(0xFFC5AEF6),
  secondaryHeaderColor: Colors.grey[300],
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xFFD6C5F9),

  dialogTheme: const DialogTheme(
    contentTextStyle: TextStyle(fontSize: 24, color: black),
    titleTextStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: black,
        fontFamily: 'Lexend'),
  ),
  textTheme: _baseTheme.textTheme.copyWith(
    bodyMedium: const TextStyle(fontSize: 18, color: black), //text in the body

    bodyLarge:
        const TextStyle(fontSize: 24, color: black), //common text, button text
    titleLarge: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: black),
    titleMedium: const TextStyle(fontSize: 24, color: black),
    headlineLarge: const TextStyle(fontSize: 35, color: black), // appbar texts
    headlineMedium: const TextStyle(fontSize: 20, color: black), //text workout process
    labelMedium: const TextStyle(fontSize: 24, color: black),
    displayMedium: const TextStyle(fontSize: 24, color: black),
    displayLarge: const TextStyle(fontSize: 42, color: black), //welcome text
  ),
);
