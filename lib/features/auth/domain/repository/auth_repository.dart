import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/features/auth/domain/entities/user_entities.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<FailureMessage, UserEntities>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<FailureMessage, UserEntities>> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
