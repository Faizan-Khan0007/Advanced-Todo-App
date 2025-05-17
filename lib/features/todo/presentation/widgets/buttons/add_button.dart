import 'package:advanced_todo_app/features/todo/presentation/widgets/dialog_box.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  void createNewTask(BuildContext context){
     showDialog(context: context, builder: (context){
         return DialogBox();
     });
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()=>createNewTask(context),
      child: Icon(Icons.add,),
      );
  }
}