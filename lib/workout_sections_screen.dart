import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'new_exercise_screen.dart';
import 'dart:convert';

class WorkoutSectionsScreen extends StatefulWidget {
  @override
  _WorkoutSectionsScreenState createState() => _WorkoutSectionsScreenState();
}

class _WorkoutSectionsScreenState extends State<WorkoutSectionsScreen> {
  List<Map<String, dynamic>> _sections = [];

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  void _loadSections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _sections = prefs.getStringList('workoutSections')?.map((e) => {'name': e, 'exercises': []}).toList() ?? [];
      for (var section in _sections) {
        List<String> exercisesJson = prefs.getStringList(section['name']) ?? [];
        section['exercises'] = exercisesJson.map((e) => json.decode(e)).toList();
      }
    });
  }

  void _navigateToNewExercise(String sectionName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewExerciseScreen(sectionName: sectionName),
      ),
    ).then((_) {
      _loadSections(); // Reload sections after adding a new exercise
    });
  }

  void _navigateToNewWorkoutSection() {
    Navigator.pushNamed(context, '/newWorkoutSection').then((_) {
      _loadSections(); // Reload sections after adding a new section
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Sections'),
      ),
      body: ListView.builder(
        itemCount: _sections.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(_sections[index]['name']),
            children: _sections[index]['exercises'].map<Widget>((exercise) {
              return ListTile(
                title: Text(exercise['name']),
                subtitle: Text('Repetitions: ${exercise['repetitions']}, Time: ${exercise['time']} seconds'),
              );
            }).toList(),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _navigateToNewExercise(_sections[index]['name']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewWorkoutSection,
        child: Icon(Icons.add),
      ),
    );
  }
}
