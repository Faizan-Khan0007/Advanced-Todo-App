import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:advanced_todo_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPasswd({//future because while getting the data from the supabase it will be asynchronous
    required String name,
    required String  email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPasswd({
    required String  email,
    required String password,
  });
  Future<Either<Failure,User>>currentUser();
}
