// ignore_for_file: sized_box_for_whitespace

import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:advanced_todo_app/features/todo/domain/entities/task.dart';
import 'package:advanced_todo_app/features/todo/presentation/widgets/buttons/save_cancel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_event.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final TextEditingController _controller = TextEditingController();

  void saveTask() {
  final taskName = _controller.text.trim();
  if (taskName.isNotEmpty) {
    final newTask = Task(
      id: DateTime.now().toString(), // or use uuid package
      name: taskName,
      isCompleted: false,
    );

    context.read<TaskBloc>().add(AddTask(newTask));
    Navigator.of(context).pop(); // close the dialog
  }
}

  void cancelTask() {
    Navigator.of(context).pop(); // just close dialog
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.backgroundColor,
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new Task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SaveCancel(
                  text: "Save",
                  onPressed: saveTask,
                ),
                const SizedBox(width: 8),
                SaveCancel(
                  text: "Cancel",
                  onPressed: cancelTask,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
