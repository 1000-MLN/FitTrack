import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                  flex: 14,
                  child:
                      Container(width: 500, height: 500, color: Colors.pink)),
              const Padding(padding: EdgeInsets.all(16)),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 1),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              expands: false,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: nameController,
                              style: Theme.of(context).textTheme.titleLarge,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: "Enter your name",
                                hintStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
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
                                        if (nameController.text.isNotEmpty) {
                                          //TODO:add here provider to remember name
                                          Navigator.pushNamed(
                                              context, '/chooseCharacter');
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text("Error")),
                                                    content: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            "Please enter a name"),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text("Ok"),
                                                          ))
                                                    ],
                                                  ));
                                        }
                                      },
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Center(
                                              child: Text(
                                            "Continue",
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
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
