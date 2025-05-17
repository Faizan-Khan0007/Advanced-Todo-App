import 'package:advanced_todo_app/core/error/exception.dart';
import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:advanced_todo_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:advanced_todo_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user=await authRemoteDataSource.getCurrentUserData();
      if(user==null){
        return left(Failure(message: "User not logged in"));
      }
      return right(user);
    }on ServerException catch(e){
      return left((Failure(message: e.message)));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPasswd({required String email, required String password})async {
    try{
        final user=await authRemoteDataSource.loginwithEmailPasswd(email: email, password: password);
        return right(user);
    }
    on ServerException catch(e){
        return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPasswd({required String name, required String email, required String password}) async{
    try{
       final user=await authRemoteDataSource.signUpwithEmailPasswd(name: name, email: email, password: password);
       return right(user);
    }on ServerException catch(e){
      return left(Failure(message: e.message));
    }//The message given in ServerException inside AuthRemoteDataSource will be caught in AuthRepositoryImpl and passed forward as a Failure object.
  }
}