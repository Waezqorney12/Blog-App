import 'package:blog_application/features/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/core/config/supabase_config.dart';
import 'package:blog_application/features/auth/data/datasource_impl/auth_remote_datasource_impl.dart';
import 'package:blog_application/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:blog_application/features/auth/domain/datasource/auth_remote_datasource.dart';
import 'package:blog_application/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_application/features/auth/domain/usecases/user_data.dart';
import 'package:blog_application/features/auth/domain/usecases/user_login.dart';
import 'package:blog_application/features/auth/domain/usecases/user_register.dart';
import 'package:blog_application/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_application/features/dashboard/data/datasource_impl/blogs_remote_datasource_impl.dart';
import 'package:blog_application/features/dashboard/data/repository_impl/blogs_repository_impl.dart';
import 'package:blog_application/features/dashboard/domain/datasource/blogs_remote_datasource.dart';
import 'package:blog_application/features/dashboard/domain/repository/blog_repository.dart';
import 'package:blog_application/features/dashboard/domain/usecases/get_blog.dart';
import 'package:blog_application/features/dashboard/domain/usecases/upload_blog.dart';
import 'package:blog_application/features/dashboard/presentation/bloc/blog_bloc.dart';
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
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Use Cases
    ..registerFactory(
      () => GetBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
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
    )
    ..registerLazySingleton(
      () => BlogBloc(
        getBlog: serviceLocator(),
        uploadBlog: serviceLocator(),
      ),
    );
}
