import 'package:flutter/material.dart';

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer Screen')),
      body: Center(
        child: Text('Timer Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
