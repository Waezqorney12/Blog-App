import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/features/auth/domain/entities/user_entities.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UserCase<UserEntities, UserLoginParams> {
  final AuthRepository authRepository;
  UserLogin(this.authRepository);
  @override
  Future<Either<FailureMessage, UserEntities>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({required this.email, required this.password});
}
