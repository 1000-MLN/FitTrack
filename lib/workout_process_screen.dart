import 'dart:async';
import 'dart:math' as math;
import 'package:fit_track/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

class WorkoutProcessScreen extends StatefulWidget {
  final List<dynamic> exercises;
  final String workoutName;

  const WorkoutProcessScreen({super.key, required this.workoutName, required this.exercises});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutProcessScreenState createState() => _WorkoutProcessScreenState();
}

class _WorkoutProcessScreenState extends State<WorkoutProcessScreen>
    with SingleTickerProviderStateMixin {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  int currentReps = 0;
  int remainingTime = 0;
  Timer? timer;
  bool isRunning = false;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    setupExercise();
  }

  void setupExercise() {
    setState(() {
      currentReps = widget.exercises[currentExerciseIndex]['reps'];
      remainingTime = widget.exercises[currentExerciseIndex]['time'];
      isRunning = false;
      _controller!.duration = Duration(seconds: remainingTime);
      _controller!.reset();
    });
  }

  void startExercise() {
    setState(() {
      isRunning = true;
    });

    _controller!.forward();

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
            _controller!.duration = Duration(seconds: remainingTime);
            _controller!.reset();
            _controller!.forward();
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
    _controller!.stop();
  }

  void nextSetOrExercise() {
    if (currentSet < widget.exercises[currentExerciseIndex]['sets'] &&
        currentExerciseIndex == widget.exercises.length - 1) {
      setState(() {
        currentSet++;
        currentExerciseIndex = 0;
        currentReps = widget.exercises[0]['reps'];
        remainingTime = widget.exercises[0]['time'];
        _controller!.duration = Duration(seconds: remainingTime);
        _controller!.reset();
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
                Navigator.pushNamed(context, '/home');
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
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = widget.exercises[currentExerciseIndex];
    return Scaffold(
      appBar: appBarCustom(context, widget.workoutName),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentExercise['name'],
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    'Reps: $currentReps',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: SizedBox(
                width: 400,
                height: 400,
                child: Center(
                  child: CustomPaint(
                    size: const Size(200, 200),
                    painter: WorkoutTimerPainter(
                      animation: _controller!,
                      backgroundColor: Theme.of(context).secondaryHeaderColor,
                      color: Theme.of(context).cardColor,
                    ),
                    child: Center(
                      child: Text(
                        '$remainingTime sec',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: isRunning ? stopExercise : startExercise,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Center(
                          child: Text(
                        isRunning ? 'Stop' : 'Start',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

class WorkoutTimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  WorkoutTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    double progress = (1.0 - animation.value) * 2 * math.pi;

    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2),
      math.pi * 1.5,
      -progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(WorkoutTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
