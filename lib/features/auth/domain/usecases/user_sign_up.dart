// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:advanced_todo_app/core/usecase%20interface/usecase.dart';
import 'package:advanced_todo_app/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements Usecase<User,UserSignUpparams> {
  final AuthRepository authRepository;
  UserSignUp({
    required this.authRepository,
  });

  @override
  Future<Either<Failure, User>> call(UserSignUpparams params) async{
    return await authRepository.signUpWithEmailPasswd(name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpparams {
     final String name;
     final String email;
     final String password;
  UserSignUpparams({
    required this.name,
    required this.email,
    required this.password,
  });
     
}
