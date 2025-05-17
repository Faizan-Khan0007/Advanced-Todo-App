import 'package:advanced_todo_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<successType,params> {
  Future<Either<Failure,successType>>call(params params);
}

class Noparams{
  
}