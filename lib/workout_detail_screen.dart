import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'workout_process_screen.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final String workoutName;
  final List<dynamic>? sections;
  final Map<String, dynamic>? workout;
  final int? id;

  const WorkoutDetailScreen(
      {super.key,
      required this.workoutName,
      this.sections,
      this.workout,
      this.id});

  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<dynamic> sections = [];

  @override
  void initState() {
    super.initState();
    widget.sections != null ? sections = widget.sections! : sections;
  }

  void _addSection() {
    TextEditingController _sectionNameController = TextEditingController();
    TextEditingController _setsController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _sectionNameController,
                decoration: const InputDecoration(labelText: 'Section Name'),
              ),
              TextField(
                controller: _setsController,
                decoration: const InputDecoration(labelText: 'Number of Sets'),
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
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editSection(int sectionIndex) {
    TextEditingController _sectionNameController =
        TextEditingController(text: sections[sectionIndex]['name']);
    TextEditingController _setsController =
        TextEditingController(text: sections[sectionIndex]['sets'].toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Section'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _sectionNameController,
                decoration: const InputDecoration(labelText: 'Section Name'),
              ),
              TextField(
                controller: _setsController,
                decoration: const InputDecoration(labelText: 'Number of Sets'),
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
                    sections[sectionIndex]['name'] =
                        _sectionNameController.text;
                    sections[sectionIndex]['sets'] =
                        int.parse(_setsController.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
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
          title: const Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _exerciseNameController,
                decoration: const InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: _repsController,
                decoration: const InputDecoration(labelText: 'Number of Reps'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration:
                    const InputDecoration(labelText: 'Time (in seconds)'),
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
                      'sets': sections[sectionIndex]['sets'],
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editExercise(int sectionIndex, int exerciseIndex) {
    TextEditingController _exerciseNameController = TextEditingController(
        text: sections[sectionIndex]['exercises'][exerciseIndex]['name']);
    TextEditingController _repsController = TextEditingController(
        text: sections[sectionIndex]['exercises'][exerciseIndex]['reps']
            .toString());
    TextEditingController _timeController = TextEditingController(
        text: sections[sectionIndex]['exercises'][exerciseIndex]['time']
            .toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _exerciseNameController,
                decoration: const InputDecoration(labelText: 'Exercise Name'),
              ),
              TextField(
                controller: _repsController,
                decoration: const InputDecoration(labelText: 'Number of Reps'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration:
                    const InputDecoration(labelText: 'Time (in seconds)'),
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
                    sections[sectionIndex]['exercises'][exerciseIndex] = {
                      'name': _exerciseNameController.text,
                      'reps': int.parse(_repsController.text),
                      'time': int.parse(_timeController.text),
                      'sets': sections[sectionIndex]['sets'],
                    };
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveWorkout() async {
    final prefs = await SharedPreferences.getInstance();
    final workouts = prefs.getStringList('workouts') ?? [];
    final workoutsId = workouts
        .map((workout) => jsonDecode(workout) as Map<String, dynamic>)
        .toList();

    final workoutData = {
      'name': widget.workoutName,
      'sections': sections,
      'id': workoutsId.isEmpty ? 1 : workoutsId[workouts.length - 1]['id'] + 1
    };
    List<String> workoutsUpdated = workouts;
    if (widget.workout != null) {
      workoutsUpdated = workouts
          .where((workout) => jsonDecode(workout)['id'] != widget.id)
          .toList();
      workouts.remove(jsonEncode(widget.workout));
    }
    workoutsUpdated.add(jsonEncode(workoutData));

    await prefs.setStringList('workouts', workoutsUpdated);
    Navigator.pushNamed(context, '/home');
  }

  void _deleteSection(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Section?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                sections.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
          TextButton(
            onPressed: _saveWorkout,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(sections[index]['name']),
            children: [
              Column(
                children: [
                  for (int exerciseIndex = 0;
                      exerciseIndex < sections[index]['exercises'].length;
                      exerciseIndex++)
                    ListTile(
                      title: Text(sections[index]['exercises'][exerciseIndex]
                          ['name']),
                      subtitle: Text(
                          'Reps: ${sections[index]['exercises'][exerciseIndex]['reps']} Time: ${sections[index]['exercises'][exerciseIndex]['time']} seconds'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editExercise(index, exerciseIndex),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                sections[index]['exercises']
                                    .removeAt(exerciseIndex);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => _addExercise(index),
                        child: const Text('Add Exercise'),
                      ),
                      TextButton(
                        onPressed: () => _editSection(index),
                        child: const Text('Edit Section'),
                      ),
                      TextButton(
                        onPressed: () => _deleteSection(index),
                        child: const Text('Delete Section'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSection,
        child: const Icon(Icons.add),
      ),
    );
  }
}
