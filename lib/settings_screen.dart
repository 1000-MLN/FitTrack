import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_track/data/provider.dart'; // Assuming your ThemeProvider is defined here

class SettingsScreen extends ConsumerStatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _toggleDarkMode(bool newValue, WidgetRef ref) {
    ref.read(themeProvider.notifier).toggleTheme(newValue);
  }

  void _changeLanguage() {
    // Your logic for changing language
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Темная тема'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (newValue) {
                _toggleDarkMode(newValue, ref);
              },
            ),
          ),
          ListTile(
            title: Text('Язык'),
            onTap: _changeLanguage,
          ),
        ],
      ),
    );
  }
}
