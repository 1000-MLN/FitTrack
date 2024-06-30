import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class CreateWorkoutScreen extends StatelessWidget {
  final TextEditingController _workoutNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
              icon: Icon(Icons.arrow_back), 
              onPressed: () {
                Navigator.of(context).pop(); // Manually handle the navigation
              },),
        ),
  
        backgroundColor: Colors.transparent,
        title: Text('New workout', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color:  Color(0xFFC5AEF6)) ,)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _workoutNameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
             IntrinsicWidth(
              child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (_workoutNameController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WorkoutDetailScreen(
                            workoutName: _workoutNameController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),
                    child: Center(
                        child: Text(
                      'Create',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                    )),
                  )),
            ),
           ],
        ),
      ),
    );
  }
}
