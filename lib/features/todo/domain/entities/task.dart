class Task {
  final String id;
  final String name;
  final bool isCompleted;

  Task({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  // ✅ Add this
  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      name: name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

