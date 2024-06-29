import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NewExerciseScreen extends StatefulWidget {
  final String sectionName;

  NewExerciseScreen({required this.sectionName});

  @override
  _NewExerciseScreenState createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _exerciseName = '';
  String _description = '';
  int _repetitions = 0;
  int _time = 0;

  void _saveExercise() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> exercises = prefs.getStringList(widget.sectionName) ?? [];
      Map<String, dynamic> exercise = {
        'name': _exerciseName,
        'description': _description,
        'repetitions': _repetitions,
        'time': _time,
      };
      exercises.add(json.encode(exercise));
      await prefs.setStringList(widget.sectionName, exercises);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Exercise Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an exercise name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _exerciseName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Repetitions'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter repetitions';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repetitions = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Time (seconds)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter time in seconds';
                  }
                  return null;
                },
                onSaved: (value) {
                  _time = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveExercise,
                child: Text('Save Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
