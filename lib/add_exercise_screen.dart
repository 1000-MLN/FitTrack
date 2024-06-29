import 'package:flutter/material.dart';

class AddExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Exercise')),
      body: Center(
        child: Column(
          children: [
            Text('Add Exercise Screen', style: TextStyle(fontSize: 24)),
            // Add more widgets to define the exercise details
          ],
        ),
      ),
    );
  }
}
