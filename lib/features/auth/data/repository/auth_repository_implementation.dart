import 'package:blog_application/core/config/exception.dart';
import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/utils/function_helper.dart';
import 'package:blog_application/features/auth/domain/datasource/remote_datasource.dart';
import 'package:blog_application/core/common/entities/user_entities.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource authSupabaseDataSource;
  AuthRepositoryImpl(this.authSupabaseDataSource);
  @override
  Future<Either<FailureMessage, UserEntities>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async =>
      helperApiCall<UserEntities>(
        apiCall: <UserEntities>() async => await authSupabaseDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        ),
      );

  @override
  Future<Either<FailureMessage, UserEntities>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async =>
      helperApiCall<UserEntities>(
        apiCall: <UserEntities>() async => await authSupabaseDataSource.registerWithEmailPassword(
          name: name,
          email: email,
          password: password,
        ),
      );

  @override
  Future<Either<FailureMessage, UserEntities>> getUser() async {
    try {
      final response = await authSupabaseDataSource.getUser();
      if (response == null) return left(FailureMessage('User not logged in'));
      return right(response);
    } on ServerException catch (e) {
      return left(
        FailureMessage(e.toString()),
      );
    }
  }
}
