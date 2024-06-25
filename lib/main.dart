import 'package:fit_track/ui/pages/excersice_screen_page.dart';
import 'package:fit_track/ui/pages/habit_screen_page.dart';
import 'package:fit_track/ui/pages/home_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      initialRoute: "/",
      routes: {
        '/': (context) => const HomeScreenPage(),
        '/habits': (context) => const HabitScreenPage(),
        '/excercises': (context) => const ExcersiceScreenPage(),
      },
    );
  }
}
