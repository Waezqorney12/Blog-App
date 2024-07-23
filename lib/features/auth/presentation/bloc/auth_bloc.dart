import 'package:blog_application/features/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/core/utils/log_utils.dart';
import 'package:blog_application/core/common/entities/user_entities.dart';
import 'package:blog_application/features/auth/domain/usecases/user_data.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRegister _userRegister;
  final UserLogin _userLogin;
  final UserData _userData;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserRegister userRegister,
    required UserLogin userLogin,
    required UserData userData,
    required AppUserCubit appUserCubit,
  })  : _userRegister = userRegister,
        _userLogin = userLogin,
        _userData = userData,
        _appUserCubit = appUserCubit,
        // -------------------------------------
        super(AuthInitial()) {
    // Loading state
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    // User Register
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
        (response) => _emitAuthSuccess(response, emit),
      );
    });
    // User Login
    on<AuthLogin>((event, emit) async {
      final response = await _userLogin(
        UserLoginParams(
          email: event.email,
          password: event.password,
        ),
      );
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (response) => _emitAuthSuccess(response, emit),
      );
    });
    // Get Current User
    on<AuthGetUser>((event, emit) async {
      final response = await _userData(NoParams());
      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (response) {
          Log.loggerDebug('User Email: ${response.email}');
          _emitAuthSuccess(response, emit);
        },
      );
    });
  }

  void _emitAuthSuccess(UserEntities userEntities, Emitter<AuthState> emit) {
    _appUserCubit.userLoggedIn(userEntities);
    emit(AuthSuccess(user: userEntities));
  }
}
