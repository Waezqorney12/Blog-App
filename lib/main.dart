import 'package:blog_application/features/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/app.dart';
import 'package:blog_application/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'features/dashboard/presentation/bloc/blog_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await initDependecies();

  initializeDateFormatting();
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) =>
        //       AuthBloc(userRegister: UserRegister(AuthRepositoryImpl(AuthSupabaseDataSourceImpl(supabase.client)))),
        // ) --> Dependency injection manually
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const App(),
    ),
  );
}
