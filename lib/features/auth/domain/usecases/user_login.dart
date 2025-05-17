// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:advanced_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:advanced_todo_app/core/usecase%20interface/usecase.dart';


class UsecaseLogin implements Usecase<User,UserLoginParams >{
  final AuthRepository authRepository;

  UsecaseLogin(this.authRepository);
  
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await authRepository.loginWithEmailPasswd(email: params.email, password: params.password);
  }
  
  
  
}
class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({
    required this.email,
    required this.password,
  });
}
