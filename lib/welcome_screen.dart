import 'package:fit_track/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() =>
      _WelcomeScreen();
}

class _WelcomeScreen extends ConsumerState<WelcomeScreen> {
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
                Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  alignment: Alignment.center,
                  width: 370,
                  child: Text(
                    maxLines: 2,
                    "Nice to meet you, ${name.name}!",
                    style: theme.textTheme.displayLarge?.copyWith(color: Colors.white),
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/heart.png', height: 1500, width: 1000,))),
                const Padding(padding: EdgeInsets.all(16)),
                const Spacer(flex: 3),
                Expanded(
                  flex: 6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            IntrinsicWidth(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 80),
                                    child: Center(
                                        child: Text(
                                      'Let\'s start!',
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
