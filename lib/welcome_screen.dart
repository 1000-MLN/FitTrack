import 'package:fit_track/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends ConsumerState<WelcomeScreen> {
  final nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(nameProvider);
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameProvider);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: const Color(0xFFD6C5F9),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.67,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(200, 225),
                  topRight: Radius.elliptical(200, 225),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 14,
                      child: Container(
                        width: 500,
                        height: 500,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                      )),
                  const Padding(padding: EdgeInsets.all(16)),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IntrinsicWidth(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC5AEF6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              expands: false,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: nameController,
                              style: Theme.of(context).textTheme.titleLarge,
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: "Type your name here",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 24,
                                        color: const Color(0x25000000)),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(8)),
                        IntrinsicWidth(
                          child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                if (nameController.text.isNotEmpty) {
                                  name.setName(nameController.text);
                                  Navigator.pushNamed(
                                      context, '/chooseCharacter');
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Align(
                                                alignment: Alignment.center,
                                                child: Text("Error")),
                                            content: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("Please enter a name"),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Align(
                                                    alignment: Alignment.center,
                                                    child: Text("Ok"),
                                                  ))
                                            ],
                                          ));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC5AEF6),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 100.2),
                                child: Center(
                                    child: Text(
                                  "Continue",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: Colors.white),
                                )),
                              )),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
