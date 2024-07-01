import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_track/data/provider.dart'; // Assuming your ThemeProvider is defined here

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _toggleDarkMode(bool newValue, WidgetRef ref) {
    ref.read(themeProvider.notifier).toggleTheme(newValue);
  }

  void _changeLanguage() {
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
          leading: Container(),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: Text(
            "Settings",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: const Color(0xFFC5AEF6)),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 20)),
          ListTile(
            title: const Text('Dark theme'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (newValue) {
                _toggleDarkMode(newValue, ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
