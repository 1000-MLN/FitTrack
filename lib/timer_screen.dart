import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(
    home: TimerScreen(),
  ));
}

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool _isActive = false;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );

    _controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isActive = false;
        });
      }
    });
  }

  void _startTimer() {
    int totalSeconds = _hours * 3600 + _minutes * 60 + _seconds;
    _controller!.duration = Duration(seconds: totalSeconds);
    _controller!.reset();
    _controller!.forward();
    setState(() {
      _isActive = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            if (_hours > 0) {
              _hours--;
              _minutes = 59;
              _seconds = 59;
            } else {
              _timer!.cancel();
              _isActive = false;
              _hours = 0;
              _minutes = 0;
              _seconds = 0;
            }
          }
        }
      });
    });
  }

  void _pauseTimer() {
    _controller!.stop();
    setState(() {
      _isActive = false;
    });
    _timer?.cancel();
  }

  void _resetTimer() {
    _controller!.reset();
    setState(() {
      _isActive = false;
      _hours = 0;
      _minutes = 0;
      _seconds = 0;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
         "Timer",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: const Color(0xFFC5AEF6)),
        ),
      ),
    
      
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              size: const Size(200, 200),
              painter: TimerPainter(
                animation: _controller!,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                color:  Theme.of(context).cardColor,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ListWheelScrollView(
                    itemExtent: 60,
                    diameterRatio: 1.5,
                    physics: const FixedExtentScrollPhysics(),
                    children: List.generate(60, (index) {
                      return Center(
                          child: Text('$index',
                              style: Theme.of(context).textTheme.headlineMedium));
                    }),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _minutes = value;
                      });
                    },
                  ),
                ),
                Text(':', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: ListWheelScrollView(
                    itemExtent: 60,
                    diameterRatio: 1.5,
                    physics: const FixedExtentScrollPhysics(),
                    children: List.generate(60, (index) {
                      return Center(
                          child: Text('$index',
                              style:Theme.of(context).textTheme.headlineMedium));
                    }),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _seconds = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Selected time: $_minutes min. $_seconds sec.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Theme.of(context).cardColor),
                  onPressed: _isActive ? null : _startTimer,
                ),
                IconButton(
                  icon: Icon(Icons.pause, color: Theme.of(context).cardColor),
                  onPressed: _isActive ? _pauseTimer : null,
                ),
                IconButton(
                  icon: Icon(Icons.stop, color: Theme.of(context).cardColor),
                  onPressed: _resetTimer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  TimerPainter({
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
  bool shouldRepaint(TimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
