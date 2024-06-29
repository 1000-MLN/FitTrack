import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'section_detail_screen.dart';
import 'dart:convert';

class WorkoutDetailScreen extends StatefulWidget {
  final String workoutName;

  WorkoutDetailScreen({required this.workoutName});

  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<Map<String, dynamic>> sections = [];

  void _addSection() {
    TextEditingController _sectionNameController = TextEditingController();
    TextEditingController _setsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _sectionNameController,
                decoration: InputDecoration(labelText: 'Section Name'),
              ),
              TextField(
                controller: _setsController,
                decoration: InputDecoration(labelText: 'Number of Sets'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_sectionNameController.text.isNotEmpty &&
                    _setsController.text.isNotEmpty) {
                  setState(() {
                    sections.add({
                      'name': _sectionNameController.text,
                      'sets': int.parse(_setsController.text),
                      'exercises': [],
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addExercise(int sectionIndex) {
    TextEditingController _exerciseNameController = TextEditingController();
    TextEditingController _repsController = TextEditingController();
    TextEditingController _timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _exerciseNameController,
                decoration: InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: _repsController,
                decoration: InputDecoration(labelText: 'Number of Reps'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time (in seconds)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_exerciseNameController.text.isNotEmpty &&
                    _repsController.text.isNotEmpty &&
                    _timeController.text.isNotEmpty) {
                  setState(() {
                    sections[sectionIndex]['exercises'].add({
                      'name': _exerciseNameController.text,
                      'reps': int.parse(_repsController.text),
                      'time': int.parse(_timeController.text),
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final workouts = prefs.getStringList('workouts') ?? [];

    final workoutData = {
      'name': widget.workoutName,
      'sections': sections,
    };

    workouts.add(jsonEncode(workoutData));
    await prefs.setStringList('workouts', workouts);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sections[index]['name']),
            subtitle: Text('Sets: ${sections[index]['sets']}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _addExercise(index),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SectionDetailScreen(
                    section: sections[index],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSection,
        child: Icon(Icons.add),
      ),
    );
  }
}
