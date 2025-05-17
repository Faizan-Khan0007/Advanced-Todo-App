//
import 'package:advanced_todo_app/core/common/cubits/app_user/app_wide_user_cubit.dart';
import 'package:advanced_todo_app/core/usecase%20interface/usecase.dart';
import 'package:advanced_todo_app/features/auth/domain/usecases/current_user.dart';
import 'package:advanced_todo_app/features/auth/domain/usecases/user_login.dart';
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:advanced_todo_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UsecaseLogin _userlogin;
  final CurrentUser _currentUser;
  final AppWideUserCubit _appWideUserCubit;
  AuthBloc({
    required UserSignUp userSignUp, //named argument and required can be used
    required UsecaseLogin userlogin,
    required CurrentUser currentUser,
    required AppWideUserCubit appWideUserCubit,

  }) : _userSignUp = userSignUp,
       _userlogin = userlogin,
       _currentUser = currentUser,
       _appWideUserCubit=appWideUserCubit,
       super(AuthInitial()) {
    //here we are assigning the value to our private variable
    on<AuthEvent>((_, emit) => emit(AuthLoading()),);//so we dont have to mention authloading everywhere
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpparams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) =>  _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userlogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold((l) => emit(AuthFailure(l.message)), (r) =>  _emitAuthSuccess(r, emit));
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(Noparams());
    res.fold(
      (l) => emit(AuthFailure(l.message)), 
      (r){
         _emitAuthSuccess(r, emit);
      }
         );

  }

  void _emitAuthSuccess(User user,Emitter<AuthState>emit){
       _appWideUserCubit.updateUser(user);
       emit(AuthSuccess(user));
  }//here we are doing that whenever the user signsup,signin in all three cases we are emitting auth success
   //and updating the app wide state
}
