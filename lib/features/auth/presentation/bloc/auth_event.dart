part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const AuthRegister({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin({
    required this.email,
    required this.password,
  });
}

final class AuthGetUser extends AuthEvent {}
