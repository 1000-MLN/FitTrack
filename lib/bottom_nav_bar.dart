import 'package:fit_track/ui/widgets/final_custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'timer_screen.dart';
import 'settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    TimerScreen(),
    MainScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FinalCustomIcons.timer),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(FinalCustomIcons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(FinalCustomIcons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
