import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'welcome_screen.dart';
import 'choose_character_screen.dart';
import 'bottom_nav_bar.dart';
import 'create_workout_screen.dart';
import 'workout_history_screen.dart';
import 'workout_detail_screen.dart';
import 'section_detail_screen.dart';

void main() {
  runApp(
    ProviderScope(child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lexend',
      ),
      title: 'Workout App',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/chooseCharacter': (context) => ChooseCharacterScreen(),
        '/home': (context) => BottomNavBar(),
        '/createWorkout': (context) => CreateWorkoutScreen(),
        '/workoutHistory': (context) => WorkoutHistoryScreen(workouts: []),
        '/workoutDetail': (context) => WorkoutDetailScreen(workoutName: ''),
        '/sectionDetail': (context) => SectionDetailScreen(section: {}),
      },
    );
  }
}
