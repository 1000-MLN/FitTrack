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
    super.initState();
    ref.read(nameProvider);
  }

  @override
  Widget build(BuildContext context) {
    final name = ref.watch(nameProvider);
    final theme = Theme.of(context);
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 52)),
                Text(
                  "Nice to meet you, ${name.name}!",
                  style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
                Expanded(
                    flex: 10,
                    child: Container(
                        width: 500, height: 500, color: Colors.transparent)),
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
                            Container(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Center(
                                          child: Text(
                                        'Let\'s start!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge?.copyWith(color: Colors.white),
                                      )),
                                    ),
                                  )),
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
        ],
      ),
    );
  }
}
