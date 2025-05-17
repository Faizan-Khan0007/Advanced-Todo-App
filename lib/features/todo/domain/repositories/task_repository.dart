import 'package:advanced_todo_app/features/todo/domain/entities/task.dart';

abstract interface class TaskRepository {
  Future<List<Task>> getAllTasks(); // <-- Add this
  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> updateTask(Task task);
  Future<Task> getTaskById(String id);
}