import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutListScreen extends StatefulWidget {
  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  List<String> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  void _loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _workouts = prefs.getStringList('workouts') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Workouts'),
      ),
      body: ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_workouts[index]),
          );
        },
      ),
    );
  }
}
