part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  AuthRegister({required this.name, required this.email, required this.password});
}
