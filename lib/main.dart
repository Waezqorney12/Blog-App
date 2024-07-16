import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/auth/presentation/dashboard.dart';
import 'package:blog_application/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependecies();
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      // BlocProvider(
      //   create: (context) =>
      //       AuthBloc(userRegister: UserRegister(AuthRepositoryImpl(AuthSupabaseDataSourceImpl(supabase.client)))),
      // ) --> Dependency injection manually

      BlocProvider(create: (_) => serviceLocator<AuthBloc>())
    ],
    child: const Dashboard(),
  ));
}
