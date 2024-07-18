part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {
  const AppUserState();
}

final class AppUserLoggedOut extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserEntities userEntities;
  const AppUserLoggedIn({required this.userEntities});
}
