import 'package:blog_application/core/failure/failure_message.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserCase<T, Params> {
  Future<Either<FailureMessage, T>> call(Params params);
}
