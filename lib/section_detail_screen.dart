import 'package:flutter/material.dart';

class SectionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> section;

  SectionDetailScreen({required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(section['name'])),
      body: ListView.builder(
        itemCount: section['exercises'].length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(section['exercises'][index]['name']),
            subtitle: Text('Reps: ${section['exercises'][index]['reps']} Time: ${section['exercises'][index]['time']} seconds'),
          );
        },
      ),
    );
  }
}
