import 'package:advanced_todo_app/core/common/cubits/app_user/app_wide_user_cubit.dart';
import 'package:advanced_todo_app/core/theme/theme.dart';
import 'package:advanced_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advanced_todo_app/features/auth/presentation/pages/home_page.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:advanced_todo_app/features/todo/presentation/pages/todo_page.dart';
import 'package:advanced_todo_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppWideUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<TaskBloc>()..add(LoadTasks())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task app',
      theme: AppTheme.lightApptheme,
      home: BlocSelector<AppWideUserCubit, AppWideUserState, bool>(
        selector: (state) {
          return state is AppWideUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if(isLoggedIn){
            return TodoPage();//not this but the first page of your app
          }
          return HomePage();
        },
      ),
    );
  }
}
