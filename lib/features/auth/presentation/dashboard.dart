import 'package:blog_application/features/auth/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkMode,
      home: const SignInPage(),
    );
  }
}
