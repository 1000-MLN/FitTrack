import 'package:fit_track/models/functions.dart';
import 'package:fit_track/ui/widgets/appbar.dart';
import 'package:fit_track/ui/widgets/final_custom_icons_icons.dart';
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
  // ignore: library_private_types_in_public_api
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
                decoration: const InputDecoration(
                  labelText: 'Section Name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _setsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Sets',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_sectionNameController.text.isNotEmpty &&
                    isDigitsOnly(_setsController.text)) {
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
                decoration: const InputDecoration(
                  labelText: 'Section Name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _setsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Sets',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_sectionNameController.text.isNotEmpty &&
                      isDigitsOnly(_setsController.text)) {
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
                decoration: const InputDecoration(
                  labelText: 'Exercise Name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _repsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Reps',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (in seconds)',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_exerciseNameController.text.isNotEmpty &&
                    isDigitsOnly(_repsController.text) &&
                    isDigitsOnly(_timeController.text)) {
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
                decoration: const InputDecoration(
                  labelText: 'Exercise Name',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: _repsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Reps',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time (in seconds)',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_exerciseNameController.text.isNotEmpty &&
                   isDigitsOnly(_repsController.text) &&
                    isDigitsOnly(_timeController.text)) {
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
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/home');
  }

  void _deleteSection(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Section?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                sections.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCustom(
        context,
        widget.workoutName,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 16),
            child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _saveWorkout();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Center(
                      child: Text(
                    'Save',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                  ),
                )
                ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length + 1,
        itemBuilder: (context, index) {

          if (index == sections.length && sections.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Center(
                          child: Text(
                        'Start workout!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                    ),
                    onTap: () {
                      if (sections
                          .expand((section) => section['exercises'])
                          .toList()
                          .isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkoutProcessScreen(
                              workoutName: widget.workoutName,
                              exercises: sections
                                  .expand((section) => section['exercises'])
                                  .toList(),
                            ),
                          ),
                        );
                      } else {
                        showDialog(
                            context: context,
                            builder: (builder) => AlertDialog(
                                  title: const Center(child: Text("Error")),
                                  content: const Text(
                                      "Please add exercises to the workout"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Ok"))
                                  ],
                                ));
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (sections.isNotEmpty) {
            return ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Center(child: Text(sections[index]['name'])),
                  ),
                ],
              ),
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
                              icon: const Icon(FinalCustomIcons.edit),
                              onPressed: () =>
                                  _editExercise(index, exerciseIndex),
                            ),
                            IconButton(
                              icon: const Icon(FinalCustomIcons.delete),
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
          }
          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        tooltip: "Add section",
        onPressed: _addSection,
        child: const Icon(FinalCustomIcons.add,
            color: Color.fromARGB(255, 241, 241, 241)),
      ),
    );
  }
}
