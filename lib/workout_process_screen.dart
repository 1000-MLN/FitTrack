import 'dart:async';
import 'package:flutter/material.dart';

class WorkoutProcessScreen extends StatefulWidget {
  final List<dynamic> exercises;
  final String workoutName;

  WorkoutProcessScreen({required this.workoutName, required this.exercises});

  @override
  _WorkoutProcessScreenState createState() => _WorkoutProcessScreenState();
}

class _WorkoutProcessScreenState extends State<WorkoutProcessScreen> {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  int currentReps = 0;
  int remainingTime = 0;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    setupExercise();
  }

  void setupExercise() {
    setState(() {
      currentReps = widget.exercises[currentExerciseIndex]['reps'];
      remainingTime = widget.exercises[currentExerciseIndex]['time'];
      isRunning = false;
    });
  }

  void startExercise() {
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        setState(() {
          if (currentReps > 1) {
            currentReps--;
            remainingTime = widget.exercises[currentExerciseIndex]['time'];
                        timer.cancel();
                        isRunning = false;

          } else {
            timer.cancel();
            nextSetOrExercise();
          }
        });
      }
    });
  }

  void stopExercise() {
    setState(() {
      isRunning = false;
    });
    timer?.cancel();
  }

  void nextSetOrExercise() {
    if (currentSet < widget.exercises[currentExerciseIndex]['sets'] && currentExerciseIndex == widget.exercises.length - 1) {
      print("HUI");
      print( widget.exercises[currentExerciseIndex]['sets']);
      print("$currentSet");
      setState(() {
        currentSet++;
        currentExerciseIndex = 0;
        currentReps = widget.exercises[0]['reps'];
        remainingTime = widget.exercises[0]['time'];
        isRunning = false;
      });
    } else if (currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        currentExerciseIndex++;
        setupExercise();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Workout Completed!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.exercises[currentExerciseIndex];
    return Scaffold(
      appBar: AppBar(title: Text(widget.workoutName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentExercise['name'],
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Reps: $currentReps',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: remainingTime / currentExercise['time'],
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    Text(
                      '$remainingTime sec',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC5AEF6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: isRunning ? stopExercise : startExercise,
              child: Text(
                isRunning ? 'Stop' : 'Start',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
