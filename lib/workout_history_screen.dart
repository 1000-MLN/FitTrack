import 'package:fit_track/workout_from_history.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'workout_detail_screen.dart';
import 'dart:convert';

class WorkoutHistoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> workouts;
  WorkoutHistoryScreen({required this.workouts});
  @override
  _WorkoutHistoryScreenState createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<Map<String, dynamic>> workouts = [];
  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsData = prefs.getStringList('workouts') ?? [];
    setState(() {
      workouts = workoutsData
          .map((workout) => jsonDecode(workout) as Map<String, dynamic>)
          .toList();
    });
  }

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
                  builder: (context) => WorkoutFromHistoryScreen(
                    workoutName: workouts[index]['name'],
                    sections: workouts[index]['sections'],
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
