import 'package:fit_track/data/provider.dart';
import 'package:fit_track/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'start_screen.dart';
import 'welcome_screen.dart';
import 'bottom_nav_bar.dart';
import 'create_workout_screen.dart';
import 'workout_history_screen.dart';
import 'workout_detail_screen.dart';

void main() {
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      themeMode: theme == lightTheme ? ThemeMode.light : ThemeMode.dark,
      darkTheme: darkTheme,
      title: 'Workout App',
      initialRoute: '/start',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/start': (context) => const StartScreen(),
        '/home': (context) => const BottomNavBar(),
        '/createWorkout': (context) => CreateWorkoutScreen(),
        '/workoutHistory': (context) => const WorkoutHistoryScreen(workouts: []),
        '/workoutDetail': (context) => const WorkoutDetailScreen(workoutName: ''),      },
    );
  }
}
