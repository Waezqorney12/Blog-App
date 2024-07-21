import 'package:blog_application/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  // Fetching user session
  Session? get currentSession;

  Future<UserModel?> getUser();

  // Login with email and password
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  // Register with email and password
  Future<UserModel> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
}
