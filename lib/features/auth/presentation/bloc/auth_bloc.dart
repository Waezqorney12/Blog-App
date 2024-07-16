import 'package:blog_application/features/auth/domain/entities/user_entities.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  final UserLogin _userLogin;

  AuthBloc({
    required UserRegister userRegister,
    required UserLogin userLogin,
  })  : _userRegister = userRegister,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthRegister>((event, emit) async {
      emit(AuthLoading());
      final response = await _userRegister(
        UserRegisterParameters(
          email: event.email,
          name: event.name,
          password: event.password,
        ),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (response) => emit(AuthSuccess(user: response)),
      );
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final response = await _userLogin(
        UserLoginParams(
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (response) => emit(AuthSuccess(user: response)),
      );
    });
  }
}
