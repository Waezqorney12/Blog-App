import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserRegister implements UserCase<String, UserRegisterParameters> {
  final AuthRepository authRepository;
  UserRegister(this.authRepository);

  @override
  Future<Either<FailureMessage, String>> call(UserRegisterParameters params) async {
    return await authRepository.registerWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserRegisterParameters {
  final String email;
  final String name;
  final String password;
  UserRegisterParameters({required this.email, required this.name, required this.password});
}
