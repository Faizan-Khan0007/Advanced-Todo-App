import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String content){
    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text(content)),);
}//.. -> are known as cascade notation 
// Cascade notation allows you to perform multiple operations on the same object in a sequence without repeating the object name.
//always use cascading from start