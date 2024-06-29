import 'package:flutter/material.dart';
import 'create_workout_screen.dart';
import 'workout_history_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Map<String, dynamic>> workoutHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Main Screen', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateWorkoutScreen(),
                  ),
                );
              },
              child: Text('Создать новую тренировку'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutHistoryScreen(workouts: workoutHistory),
                  ),
                );
              },
              child: Text('История тренировок'),
            ),
          ],
        ),
      ),
    );
  }
}
