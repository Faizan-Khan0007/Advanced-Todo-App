// lib/features/todo/presentation/bloc/task_bloc.dart

import 'package:advanced_todo_app/features/todo/domain/repositories/task_repository.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc(this.taskRepository) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.getAllTasks();
        emit(TaskLoaded(tasks));
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTask>((event, emit) async {
      if (state is TaskLoaded) {
        await taskRepository.addTask(event.task);
        add(LoadTasks());
      }
    });

    on<DeleteTask>((event, emit) async {
      await taskRepository.deleteTask(event.id);
      add(LoadTasks());
    });

    on<ToggleTask>((event, emit) async {
      final oldTask = await taskRepository.getTaskById(event.id);
      final updated = oldTask.copyWith(isCompleted: !oldTask.isCompleted);
      await taskRepository.updateTask(updated);
      add(LoadTasks());
    });
  }
}
