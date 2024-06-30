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
      {super.key, required this.workoutName, this.sections, this.workout, this.id});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutName),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveWorkout,
          ),
          
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length+1,
        itemBuilder: (context, index) {
          if (index == sections.length && sections.isNotEmpty ) {
return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    IntrinsicWidth(
      child: ElevatedButton(
                  onPressed: () {
                    if (sections.expand((section) => section['exercises']).toList().isNotEmpty){
Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutProcessScreen(
                          workoutName: widget.workoutName,
                          exercises: sections.expand((section) => section['exercises']).toList(),
                        ),
                      ),
                    );
                    } else {
                      showDialog(context: context, builder: (builder) => AlertDialog(title: Text("Please add exercises to the workout"),
                      actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))],));
                    }
                   
                    
                  },
                  child:Text("Lets start!", style: Theme.of(context).textTheme.bodyLarge),
                 
                ),
    ),
  ],
);
          } else if(sections.isNotEmpty) {
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
                            'Reps: ${exercise['reps']} Time: ${exercise['time']} sec',
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
       
          }
           },
      ),
      floatingActionButton: 
          FloatingActionButton(
            onPressed: _addSection,
            child: const Icon(Icons.add),
            tooltip: 'Add Section',
          ),
         
    
    );
  }
}