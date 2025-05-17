// lib/features/todo/presentation/bloc/task_event.dart

import '../../domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String id;
  DeleteTask(this.id);
}

class ToggleTask extends TaskEvent {
  final String id;
  ToggleTask(this.id);
}
