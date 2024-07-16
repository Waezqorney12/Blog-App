import 'package:blog_application/core/config/exception.dart';
import 'package:blog_application/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/datasource/remote_datasource.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final SupabaseClient supabaseClient;
  RemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if (response.user == null) throw const ServerException(message: 'User not found');
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) throw const ServerException(message: 'User is null');
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
