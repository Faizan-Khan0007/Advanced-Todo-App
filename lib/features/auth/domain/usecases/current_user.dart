// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';

import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:advanced_todo_app/core/usecase%20interface/usecase.dart';
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:advanced_todo_app/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements Usecase<User,Noparams> {
  final AuthRepository authRepository;
  CurrentUser( this.authRepository,);
  @override
  Future<Either<Failure, User>> call(Noparams params) async{
    return await authRepository.currentUser();
  }
}
