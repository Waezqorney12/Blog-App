import 'package:blog_application/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

import '../pages/sign_in_page.dart';

class Routes {
  static login() => MaterialPageRoute(builder: (context) => const SignInPage());
  static register() => MaterialPageRoute(builder: (context) => const SignUpPage());
}
