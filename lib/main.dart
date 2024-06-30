import 'package:fit_track/data/provider.dart';
import 'package:fit_track/ui/theme/theme.dart';
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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to listen to the theme changes
    final theme = ref.watch(themeProvider);

    // Return MaterialApp with the current theme
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
        themeMode: theme==lightTheme?ThemeMode.light:ThemeMode.dark,
      darkTheme: darkTheme,
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
