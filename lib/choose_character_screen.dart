import 'package:fit_track/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChooseCharacterScreen extends ConsumerStatefulWidget {
  const ChooseCharacterScreen({super.key});

  @override
  ConsumerState<ChooseCharacterScreen> createState() =>
      _ChooseCharacterScreen();
}

class _ChooseCharacterScreen extends ConsumerState<ChooseCharacterScreen> {
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
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        Text(
                          "Nice to meet you, ${name.name}!",
                        ),
                        Container(
                          child: Ink(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 213, 227),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
