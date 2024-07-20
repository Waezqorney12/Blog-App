// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:bloc/bloc.dart';
import 'package:blog_application/core/common/entities/user_entities.dart';
import 'package:flutter/material.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserLoggedOut());

  void userLoggedIn(UserEntities? user){
    if(user != null) emit(AppUserLoggedIn(userEntities: user));
    else emit(AppUserLoggedOut());
  }
}
