// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/network/connection_network.dart';
import 'package:blog_application/features/auth/data/model/user_model.dart';
import 'package:blog_application/features/auth/domain/datasource/auth_remote_datasource.dart';
import 'package:blog_application/core/common/entities/user_entities.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/function_helper_utils.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authSupabaseDataSource;
  final ConnectionNetwork connectionNetwork;
  AuthRepositoryImpl(
    this.authSupabaseDataSource,
    this.connectionNetwork,
  );
  @override
  Future<Either<FailureMessage, UserEntities>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    if (await (connectionNetwork.isConnected)) {
      helperCall<UserEntities>(
        apiCall: <UserEntities>() async => await authSupabaseDataSource.loginWithEmailPassword(
          email: email,
          password: password,
        ),
      );
    }
    return left(FailureMessage('No internet connection'));
  }

  @override
  Future<Either<FailureMessage, UserEntities>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await (connectionNetwork.isConnected)) {
      helperCall<UserEntities>(
        apiCall: <UserEntities>() async => await authSupabaseDataSource.registerWithEmailPassword(
          name: name,
          email: email,
          password: password,
        ),
      );
    }
    return left(FailureMessage('No internet connection'));
  }

  @override
  Future<Either<FailureMessage, UserEntities>> getUser() async {
    try {
      if (!await (connectionNetwork.isConnected)) {
        final session = authSupabaseDataSource.currentSession;
        if (session != null)
          return right(UserModel(id: session.user.id, email: session.user.email ?? '', name: ''));
        else
          return left(FailureMessage('No internet connection'));
      }
      final response = await authSupabaseDataSource.getUser();
      if (response == null) return left(FailureMessage('User not logged in'));
      return right(response);
    } catch (e) {
      return left(
        FailureMessage(e.toString()),
      );
    }
  }
}
