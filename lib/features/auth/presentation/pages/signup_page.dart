import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog_application/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: AuthButton(buttonName: 'Sign Up')),
              RichText(
                text: TextSpan(text: 'Don\'t have account? ', style: Theme.of(context).textTheme.titleMedium, children: [
                  TextSpan(
                      text: 'Sign In',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppPallete.gradient2, fontWeight: FontWeight.bold))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
