import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class WorkoutHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> workouts;

  WorkoutHistoryScreen({required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout History')),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workouts[index]['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailScreen(
                    workoutName: workouts[index]['name'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
