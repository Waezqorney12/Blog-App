import 'package:blog_application/core/config/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDataSource {
  Future<String> loginWithEmailPassword({required String email, required String password});
  Future<String> registerWithEmailPassword({required String name, required String email, required String password});
}

class AuthSupabaseDataSourceImpl implements AuthSupabaseDataSource {
  final SupabaseClient supabaseClient;
  AuthSupabaseDataSourceImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return 'sa';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> registerWithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) throw const ServerException(message: 'User is null');
      return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
