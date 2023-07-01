class Student {
  String name;
  bool isPresent;

  Student({required this.name, required this.isPresent});

  factory Student.fromMap(Map<dynamic, dynamic>? map) {
    return Student(
      name: map?['name'] ?? '',
      isPresent: map?['isPresent'] ?? false,
    );
  }
}
