class Exercise {
  String name;
  String description;
  int repetitions;
  int time;

  Exercise({
    required this.name,
    required this.description,
    required this.repetitions,
    required this.time,
  });

  factory Exercise.fromJson(Map<String, dynamic> jsonData) {
    return Exercise(
      name: jsonData['name'],
      description: jsonData['description'],
      repetitions: jsonData['repetitions'],
      time: jsonData['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'repetitions': repetitions,
      'time': time,
    };
  }
}

class Section {
  String name;
  List<Exercise> exercises;

  Section({
    required this.name,
    required this.exercises,
  });

  factory Section.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['exercises'] as List;
    List<Exercise> exerciseList = list.map((i) => Exercise.fromJson(i)).toList();

    return Section(
      name: jsonData['name'],
      exercises: exerciseList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}

class Workout {
  String name;
  String duration;
  List<Section> sections;

  Workout({
    required this.name,
    required this.duration,
    required this.sections,
  });

  factory Workout.fromJson(Map<String, dynamic> jsonData) {
    var list = jsonData['sections'] as List;
    List<Section> sectionList = list.map((i) => Section.fromJson(i)).toList();

    return Workout(
      name: jsonData['name'],
      duration: jsonData['duration'],
      sections: sectionList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'duration': duration,
      'sections': sections.map((s) => s.toJson()).toList(),
    };
  }
}
