import 'package:flutter/material.dart';

class ChooseCharacterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 10,
                  child: Container(width: 500, height: 500, color: Colors.pink)),
              const Padding(padding: EdgeInsets.all(16)),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Container(
                            child: Ink(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                    255, 255, 213, 227),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                     Navigator.pushNamed(context, '/home');
                                    
                                  },
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Center(
                                          child: Text(
                                      'Let\'s start!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      
    );
  }
}
