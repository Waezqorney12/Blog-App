// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:blog_application/core/utils/show_snackbar_utils.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/core/routes/app_routes.dart';
import 'package:blog_application/features/auth/presentation/controller/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widget/loader.dart';
import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInController _controller;

  @override
  void initState() {
    _controller = SignInController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure)
            showSnackBar(context, state.message);
          else if (state is AuthSuccess)
            Navigator.pushAndRemoveUntil(
              context,
              Routes.dashboard(),
              (route) => false,
            );
        },
        builder: (context, state) {
          if (state is AuthLoading) const Loader();
          return Form(
            key: _controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    controller: _controller.emailController,
                    hint: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    controller: _controller.passwordController,
                    hint: 'Password',
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: AuthButton(
                      buttonName: 'Sign In',
                      onTap: () {
                        if (_controller.formKey.currentState!.validate()) _controller.login(context);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont\'t have account? ', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, Routes.register()),
                        child: Text('Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppPallete.gradient2, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
