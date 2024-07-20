import 'package:blog_application/features/auth/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/config/supabase_config.dart';
import 'package:blog_application/features/auth/data/datasource_impl/auth_remote_datasource_impl.dart';
import 'package:blog_application/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_application/features/auth/domain/datasource/auth_remote_datasource.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_application/features/auth/domain/usecases/user_data.dart';
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

  //Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator
    // Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Use Cases
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserData(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserRegister(
        serviceLocator(),
      ),
    )

    // State Management (Bloc)
    ..registerLazySingleton(
      () => AuthBloc(
        userRegister: serviceLocator(),
        userLogin: serviceLocator(),
        userData: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
