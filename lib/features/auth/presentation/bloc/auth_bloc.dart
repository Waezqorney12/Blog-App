import 'package:blog_application/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;

  AuthBloc({required UserRegister userRegister})
      : _userRegister = userRegister,
        super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      final response = await _userRegister(
        UserRegisterParameters(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (response) => AuthSuccess(uid: response),
      );
    });
  }
}
