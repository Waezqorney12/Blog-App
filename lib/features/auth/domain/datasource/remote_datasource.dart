import 'package:blog_application/features/auth/data/model/user_model.dart';

abstract interface class RemoteDataSource {
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}
