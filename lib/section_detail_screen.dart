import 'package:flutter/material.dart';

class SectionDetailScreen extends StatelessWidget {
  final Map<String, dynamic> section;

  const SectionDetailScreen({super.key, required this.section});

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
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Exercise?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          section['exercises'].removeAt(index);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
