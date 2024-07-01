import 'package:fit_track/ui/widgets/appbar.dart';
import 'package:fit_track/ui/widgets/final_custom_icons_icons.dart';
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

  Future<void> _deleteWorkout(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsData = prefs.getStringList('workouts') ?? [];
    workoutsData.removeAt(index);

    setState(() {
      workouts.removeAt(index);
    });

    await prefs.setStringList('workouts', workoutsData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(context, "Workout History"),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(workouts[index]['name']),
            trailing: IconButton(
              icon: Icon(FinalCustomIcons.delete),
              onPressed: () => showDialog(
                builder: (context) => AlertDialog(
                  title: Text('Delete workout?',  style: Theme.of(context).textTheme.bodyLarge),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _deleteWorkout(index);
                          Navigator.pop(context);
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'))
                  ],
                ), context: context,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutDetailScreen(
                    workoutName: workouts[index]['name'],
                    sections: workouts[index]['sections'],
                    workout: workouts[index],
                    id: workouts[index]['id'],
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
