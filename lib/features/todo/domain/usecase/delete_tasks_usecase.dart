import 'package:advanced_todo_app/features/todo/domain/repositories/task_repository.dart';

class DeleteTasksUsecase {
  final TaskRepository repository;
  DeleteTasksUsecase(this.repository);
  Future<void> execute(String id){
    return repository.deleteTask(id);
  }
}