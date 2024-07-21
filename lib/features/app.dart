// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:blog_application/features/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/theme.dart';
import 'dashboard/presentation/pages/dashboard_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthGetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) => state is AppUserLoggedIn,
        builder: (context, state) => state ? const DashboardPage() : const SignInPage(),
      ),
    );
  }
}
