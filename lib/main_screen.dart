import 'package:flutter/material.dart';
import 'create_workout_screen.dart';
import 'workout_history_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Map<String, dynamic>> workoutHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
           Container(
            color: Theme.of(context).cardColor,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.67,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(200, 225),
                topRight: Radius.elliptical(200, 225),
              ),
            ),
          ),
          Center(
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
        ],
      ),
    );
  }
}
