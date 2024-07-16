import 'package:blog_application/core/config/supabase_config.dart';
import 'package:blog_application/features/auth/data/datasource_impl/remote_datasource_impl.dart';
import 'package:blog_application/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_application/features/auth/domain/datasource/remote_datasource.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_register.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependecies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseConfig.supabaseURL ?? 'No URL found',
    anonKey: SupabaseConfig.supabaseKey ?? 'No Key found',
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserRegister(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userRegister: serviceLocator(),
      userLogin: serviceLocator(),
    ),
  );
}
