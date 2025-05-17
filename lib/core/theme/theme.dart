import 'package:advanced_todo_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
   static final lightApptheme=ThemeData.light().copyWith(
       scaffoldBackgroundColor: AppPallete.backgroundColor,
       appBarTheme: AppBarTheme(
        backgroundColor: AppPallete.backgroundColor,
       ),
   );
}