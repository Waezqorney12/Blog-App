import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/features/auth/data/datasource/auth_supabase_data_source.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/config/exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDataSource authSupabaseDataSource;
  AuthRepositoryImpl(this.authSupabaseDataSource);
  @override
  Future<Either<FailureMessage, String>> loginWithEmailPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<FailureMessage, String>> registerWithEmailPassword(
      {required String name, required String email, required String password}) async {
    try {
      final data = await authSupabaseDataSource.registerWithEmailPassword(name: name, email: email, password: password);
      return right(data);
    } on ServerException catch (e) {
      return left(FailureMessage(e.toString()));
    }
  }
}
