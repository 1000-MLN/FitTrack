import 'package:flutter/material.dart';

class ChooseCharacterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/rabbit.png'),
            SizedBox(height: 20),
            Text('Choose your character', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Let\'s start!'),
            ),
          ],
        ),
      ),
    );
  }
}
