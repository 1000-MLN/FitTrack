import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models.dart';

class NewWorkoutScreen extends StatefulWidget {
  @override
  _NewWorkoutScreenState createState() => _NewWorkoutScreenState();
}

class _NewWorkoutScreenState extends State<NewWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _workoutName = '';
  String _workoutDuration = '';

  void _saveWorkout() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> workoutsJson = prefs.getStringList('workouts') ?? [];
      List<Workout> workouts = workoutsJson.map((e) => Workout.fromJson(json.decode(e))).toList();

      Workout workout = Workout(
        name: _workoutName,
        duration: _workoutDuration,
        sections: [],
      );

      workouts.add(workout);
      prefs.setStringList('workouts', workouts.map((e) => json.encode(e.toJson())).toList());

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Workout Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a workout name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _workoutName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Workout Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a workout duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _workoutDuration = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveWorkout,
                child: Text('Save Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
