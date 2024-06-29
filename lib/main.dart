import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'choose_character_screen.dart';
import 'bottom_nav_bar.dart';
import 'new_workout_section_screen.dart';
import 'workout_sections_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/chooseCharacter': (context) => ChooseCharacterScreen(),
        '/home': (context) => BottomNavBar(),
        '/newWorkoutSection': (context) => NewWorkoutSectionScreen(),
        '/workoutSections': (context) => WorkoutSectionsScreen(),
      },
    );
  }
}
