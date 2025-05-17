import 'package:hive/hive.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Box box;

  TaskRepositoryImpl(this.box);

  @override
  Future<void> addTask(Task task) async {
    final model = task.toModel();
    await box.put(model.id, model.toMap());
  }

  @override
  Future<void> deleteTask(String id) async {
    await box.delete(id);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return box.values
        .map((e) => TaskModel.fromMap(Map<String, dynamic>.from(e)).toEntity())
        .toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    await box.put(task.id, task.toModel().toMap());
  }

  @override
  Future<Task> getTaskById(String id) async {
    final data = box.get(id);
    if (data == null) throw Exception("Task not found");
    return TaskModel.fromMap(Map<String, dynamic>.from(data)).toEntity();
  }
}
