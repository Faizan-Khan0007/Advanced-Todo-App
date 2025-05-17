import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class SaveCancel extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SaveCancel({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppPallete.gradient1,
      child: Text(text),
    );
  }
}
