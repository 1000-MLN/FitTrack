import 'package:fit_track/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreen();
}

class _StartScreen extends ConsumerState<StartScreen> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(nameProvider);
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameProvider);
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: theme.cardColor,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * 0.67,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(200, 225),
                  topRight: Radius.elliptical(200, 225),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  Text("Fit Track", style: theme.textTheme.displayLarge?.copyWith(color: Colors.white, fontSize: 52)),
                  Spacer(flex: 2),
                  Expanded(
                      flex: 8,
                      child: Container(
                        height: 280,
                        width: 280,
                        child: Image.asset('assets/images/base_dinosaur.png'),
                      )),
                  const Padding(padding: EdgeInsets.all(16)),
                  const Spacer(flex: 2),
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
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              expands: false,
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              controller: nameController,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: "Type your name here",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: const Color(0x50000000)),
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
                                      context, '/welcome');
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
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 100.2),
                                child: Center(
                                    child: Text(
                                  "Continue",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
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
