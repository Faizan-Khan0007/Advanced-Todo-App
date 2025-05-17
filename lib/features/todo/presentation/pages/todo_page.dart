import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:advanced_todo_app/features/auth/presentation/widgets/two_circles.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_state.dart';
import 'package:advanced_todo_app/features/todo/presentation/widgets/buttons/add_button.dart';
import 'package:advanced_todo_app/features/todo/presentation/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      floatingActionButton: const AddButton(),
      body: Stack(
        children: [
          const TwoCircles(),
          Column(
            children: [
              const SizedBox(height: 100),
              Center(
                child: Text(
                  "Todo Tasks",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TaskLoaded) {
                      final tasks = state.tasks;

                      if (tasks.isEmpty) {
                        return const Center(child: Text("No tasks found"));
                      }

                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return TodoTile(
                            taskIndex: index,
                            taskname: task.name,
                            taskcompleted: task.isCompleted,
                            onChanged: (isChecked) {
                              // dispatch toggle event
                              context.read<TaskBloc>().add(ToggleTask(task.id));
                            },
                            deleteTask: (_) {
                              context.read<TaskBloc>().add(DeleteTask(task.id));
                            },
                          );
                        },
                      );
                    } else if (state is TaskError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const SizedBox(); // Fallback
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
