import 'package:blog_application/core/common/widget/loader.dart';
import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:blog_application/core/utils/show_snackbar.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/auth/presentation/routes/app_routes.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
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
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    controller: nameController,
                    hint: 'Name',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: AuthField(
                      controller: emailController,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
                  AuthField(
                    controller: passwordController,
                    hint: 'Password',
                    obscureText: true,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: AuthButton(
                        buttonName: 'Sign Up',
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthRegister(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim()),
                                );
                          }
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
