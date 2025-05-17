import 'package:advanced_todo_app/core/common/cubits/app_user/app_wide_user_cubit.dart';
import 'package:advanced_todo_app/core/secrets/supabase_secrets.dart';
import 'package:advanced_todo_app/features/auth/domain/usecases/current_user.dart';
import 'package:advanced_todo_app/features/auth/domain/usecases/user_login.dart';
import 'package:advanced_todo_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:advanced_todo_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:advanced_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:advanced_todo_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:advanced_todo_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:advanced_todo_app/features/todo/data/repositories/task_repository_impl.dart';
import 'package:advanced_todo_app/features/todo/domain/repositories/task_repository.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:advanced_todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // 1️⃣ Initialize Hive and open your 'tasks' box
  await Hive.initFlutter();
  final tasksBox = await Hive.openBox('tasks');
  serviceLocator.registerLazySingleton<Box>(() => tasksBox);

  // 2️⃣ Initialize Supabase
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.supabaseanonkey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // 3️⃣ App-wide cubit
  serviceLocator.registerLazySingleton(() => AppWideUserCubit());

  // 4️⃣ Auth layer
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceimpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(() => UserSignUp(authRepository: serviceLocator()));
  serviceLocator.registerFactory(() => UsecaseLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userlogin: serviceLocator(),
      currentUser: serviceLocator(),
      appWideUserCubit: serviceLocator(),
    ),
  );

  // 5️⃣ Todo layer

  // — Repository: needs the Hive box
  serviceLocator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(serviceLocator<Box>()),
  );

  // — BLoC: needs the repository
  serviceLocator.registerFactory(
    () => TaskBloc(serviceLocator<TaskRepository>())..add(LoadTasks()),
  );
}
