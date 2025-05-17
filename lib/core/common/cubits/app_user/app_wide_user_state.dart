part of 'app_wide_user_cubit.dart';

@immutable
sealed class AppWideUserState {}

final class AppWideUserInitial extends AppWideUserState {}

final class AppWideUserLoggedIn extends AppWideUserState{
  final User user;

  AppWideUserLoggedIn(this.user);
}

//core cannot depend on other features
//other features can depend on core
