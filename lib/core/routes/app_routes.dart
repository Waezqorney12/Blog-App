import 'package:blog_application/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_application/features/dashboard/presentation/add_blog.dart';
import 'package:blog_application/features/dashboard/presentation/dashboard.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/sign_in_page.dart';

class Routes {
  static login() => MaterialPageRoute(builder: (context) => const SignInPage());
  static register() => MaterialPageRoute(builder: (context) => const SignUpPage());
  static dashboard() => MaterialPageRoute(builder: (context) => const DashboardPage());
  static blogForm() => MaterialPageRoute(builder: (context) => const AddBlogPage());
}
