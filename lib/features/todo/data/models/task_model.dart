import 'package:advanced_todo_app/features/todo/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String name;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  // Convert model to Map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted,
    };
  }

  // Create model from Map from Hive
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'],
    );
  }
}

// ✅ MAPPERS between Model ↔ Entity

extension TaskModelMapper on TaskModel {
  Task toEntity() {
    return Task(
      id: id,
      name: name,
      isCompleted: isCompleted,
    );
  }
}

extension TaskEntityMapper on Task {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      name: name,
      isCompleted: isCompleted,
    );
  }
}
