import 'package:blog_application/features/auth/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
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
                controller: emailController,
                hint: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              AuthField(
                controller: passwordController,
                hint: 'Password',
                obscureText: true,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: AuthButton(
                    buttonName: 'Sign In',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        
                      }
                    },
                  )),
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
      ),
    );
  }
}
