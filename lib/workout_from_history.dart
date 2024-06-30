import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WorkoutFromHistoryScreen extends StatefulWidget {
  final String workoutName;
  final List<dynamic> sections;

  WorkoutFromHistoryScreen({required this.workoutName, required this.sections});
  @override
  _WorkoutFromHistoryScreenState createState() => _WorkoutFromHistoryScreenState();
}

class _WorkoutFromHistoryScreenState extends State<WorkoutFromHistoryScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
        
        ],
      ),
      body: ListView.builder(
        itemCount: widget.sections.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                widget.sections[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Sets: ${widget.sections[index]['sets']}'),
              children: [
                ...widget.sections[index]['exercises']
                    .map<Widget>((exercise) => ListTile(
                          title: Text(
                            exercise['name'],
                            style: TextStyle(fontSize: 14.0),
                          ),
                          subtitle: Text(
                            'Reps: ${exercise['reps']} Time: ${exercise['time']} seconds',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ))
                    .toList(),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
