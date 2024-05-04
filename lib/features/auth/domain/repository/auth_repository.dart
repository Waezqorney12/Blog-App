import 'package:blog_application/core/failure/failure_message.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<FailureMessage, String>> registerWithEmailPassword(
      {required String name, required String email, required String password});
  Future<Either<FailureMessage, String>> loginWithEmailPassword({required String email, required String password});
}
