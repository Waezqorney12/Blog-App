import 'package:blog_application/core/common/widget/loader.dart';
import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:blog_application/core/utils/show_snackbar.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/core/routes/app_routes.dart';
import 'package:blog_application/features/auth/presentation/controller/sign_up_controller.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpController _controller;
  @override
  void initState() {
    _controller = SignUpController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.emailController.dispose();
    _controller.nameController.dispose();
    _controller.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) showSnackBar(context, state.message);
          },
          builder: (context, state) {
            if (state is AuthLoading) return const Loader();
            return Form(
              key: _controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    controller: _controller.nameController,
                    hint: 'Name',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AuthField(
                      controller: _controller.emailController,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  AuthField(
                    controller: _controller.passwordController,
                    hint: 'Password',
                    obscureText: true,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: AuthButton(
                        buttonName: 'Sign Up',
                        onTap: () {
                          if (_controller.formKey.currentState!.validate()) _controller.signup(context);
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account? ', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(context, Routes.login()),
                        child: Text('Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppPallete.gradient2, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
