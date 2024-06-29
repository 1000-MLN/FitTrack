import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/hamster.png'),
            SizedBox(height: 20),
            Text('Hi!', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chooseCharacter');
              },
              child: Text('Start your journey!'),
            ),
          ],
        ),
      ),
    );
  }
}
