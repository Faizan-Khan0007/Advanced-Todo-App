import 'package:advanced_todo_app/features/todo/domain/entities/task.dart';
import 'package:advanced_todo_app/features/todo/domain/repositories/task_repository.dart';

class UpdateTasksUsecase {
  final TaskRepository repository;

  UpdateTasksUsecase(this.repository);

  Future<void> execute(Task task) {
    return repository.updateTask(task);
  }
}