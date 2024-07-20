import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class SignInController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    context.read<AuthBloc>().add(AuthLogin(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ));
  }

  
}
