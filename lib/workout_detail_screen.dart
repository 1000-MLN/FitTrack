import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WorkoutDetailScreen extends StatefulWidget {
  final String workoutName;
  final List<dynamic>? sections;
  final Map<String, dynamic>? workout;
  final int? id;

  const WorkoutDetailScreen(
      {super.key, required this.workoutName, this.sections, this.workout, this.id});
  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  List<dynamic> sections = [];
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
                decoration: const InputDecoration(labelText: 'Time (in seconds)'),
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
              child: const Text('Add'),
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

  // Future<void> _deleteWorkworkout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final workouts = prefs.getStringList('workouts') ?? [];
  //   final updatedWorkouts = workouts
  //       .where((workout) => jsonDecode(workout)['id'] != widget.id)
  //       .toList();
  //   final workoutsId = workouts
  //       .map((workout) => jsonDecode(workout) as Map<String, dynamic>)
  //       .toList();
  //   final workoutData = {
  //     'name': widget.workoutName,
  //     'sections': sections,
  //     'id': workoutsId.isEmpty ? 1 : workoutsId[workouts.length - 1]['id'] + 1
  //   };
  //   updatedWorkouts.remove(jsonEncode(workoutData));
  //   prefs.clear();

  //   await prefs.setStringList('workouts', updatedWorkouts);

  //   // Pop the current screen to go back to the previous screen
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    widget.sections != null ? sections = widget.sections! : sections;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
          // IconButton(
          //   icon: Icon(Icons.delete),
          //   onPressed: _deleteWorkworkout,
          // ),
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(
                sections[index]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Sets: ${sections[index]['sets']}'),
              children: [
                ...sections[index]['exercises']
                    .map<Widget>((exercise) => ListTile(
                          title: Text(
                            exercise['name'],
                            style: const TextStyle(fontSize: 14.0),
                          ),
                          subtitle: Text(
                            'Reps: ${exercise['reps']} Time: ${exercise['time']} seconds',
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ))
                    .toList(),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add Exercise'),
                  onTap: () => _addExercise(index),
                ),
              ],
            ),
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
