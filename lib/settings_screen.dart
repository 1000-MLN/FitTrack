import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; 

  void _toggleDarkMode(bool newValue) {
    setState(() {
      //логика
    });
  }

  void _changeLanguage() {
    //логика
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Темная тема'),
            trailing: Switch(
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
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
