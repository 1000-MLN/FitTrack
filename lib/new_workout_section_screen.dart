import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewWorkoutSectionScreen extends StatefulWidget {
  @override
  _NewWorkoutSectionScreenState createState() => _NewWorkoutSectionScreenState();
}

class _NewWorkoutSectionScreenState extends State<NewWorkoutSectionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _sectionName = '';

  void _saveSection() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> sections = prefs.getStringList('workoutSections') ?? [];
      sections.add(_sectionName);
      await prefs.setStringList('workoutSections', sections);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Workout Section'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Section Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a section name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _sectionName = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSection,
                child: Text('Save Section'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
