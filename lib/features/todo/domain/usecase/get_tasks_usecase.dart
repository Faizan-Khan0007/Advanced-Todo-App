import 'package:advanced_todo_app/features/todo/domain/entities/task.dart';
import 'package:advanced_todo_app/features/todo/domain/repositories/task_repository.dart';

class GetTasksUsecase {
  final TaskRepository repository;

  GetTasksUsecase(this.repository);
  Future<List<Task>> execute()=>repository.getAllTasks();
}