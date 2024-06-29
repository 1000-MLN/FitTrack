import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(
    home: TimerScreen(),
  ));
}

class TimerScreen extends StatefulWidget {
  @override
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
      duration: Duration(seconds: 0), 
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

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
        title: Text('Таймер'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size(200, 200),
              painter: TimerPainter(
                animation: _controller!,
                backgroundColor: Colors.grey[200]!,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 200, // Ограничиваем высоту
                  child: ListWheelScrollView(
                    itemExtent: 60,
                    diameterRatio: 1.5,
                    physics: FixedExtentScrollPhysics(),
                    children: List.generate(60, (index) {
                      return Center(
                          child:
                              Text('$index', style: TextStyle(fontSize: 20)));
                    }),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _minutes = value;
                      });
                    },
                  ),
                ),
                Text(':', style: TextStyle(fontSize: 24)),
                SizedBox(
                  width: 100,
                  height: 200, // Ограничиваем высоту
                  child: ListWheelScrollView(
                    itemExtent: 60,
                    diameterRatio: 1.5,
                    physics: FixedExtentScrollPhysics(),
                    children: List.generate(60, (index) {
                      return Center(
                          child:
                              Text('$index', style: TextStyle(fontSize: 20)));
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
            SizedBox(height: 20),
            Text(
              'Выбранное время: $_minutes мин. $_seconds сек.',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: _isActive ? null : _startTimer,
                ),
                IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: _isActive ? _pauseTimer : null,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
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
