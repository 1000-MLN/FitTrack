import 'package:flutter/material.dart';
import 'create_workout_screen.dart';
import 'workout_history_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Map<String, dynamic>> workoutHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: Theme.of(context).cardColor,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.67,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.elliptical(200, 225),
                topRight: Radius.elliptical(200, 225),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Expanded(
                    flex: 16,
                    child: Container(
                      alignment: Alignment.center,
                      height: 500,
                      child: Image.asset('assets/images/base.png'),
                    )),
                const Padding(padding: EdgeInsets.all(16)),
                const Spacer(flex: 1),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                       IntrinsicWidth(
                        child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateWorkoutScreen(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 60),
                              child: Center(
                                  child: Text(
                                'Add workout',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              )),
                            )),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 16)),
                      IntrinsicWidth(
                        child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkoutHistoryScreen(
                                      workouts: workoutHistory),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 40),
                              child: Center(
                                  child: Text(
                                'Choose workout',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: Colors.white),
                              )),
                            )),
                      ),
            
              ],
            ),
          )
           ],
            ),
          ),
        ],
      ),
    );
  }
}
