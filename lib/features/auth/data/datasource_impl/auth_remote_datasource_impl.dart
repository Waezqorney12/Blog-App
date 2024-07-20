import 'package:blog_application/core/config/exception.dart';
import 'package:blog_application/core/utils/log.dart';
import 'package:blog_application/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/datasource/auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  /* 
  #In case confused why i added the .copyWith to all function

  Adding copyWith to every function is prevent a bugs in the future because there might a problem with email field is empty
  in the login and signup methods so that's why we are adding .copyWith email field to ensure is not empty
  */

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if (response.user == null) throw const ServerException(message: 'User not found');
      return UserModel.fromJson(response.user!.toJson()).copyWith(email: email);
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> registerWithEmailPassword({required String name, required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) throw const ServerException(message: 'User is null');
      return UserModel.fromJson(response.user!.toJson()).copyWith(email: email);
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getUser() async {
    try {
      if (currentSession != null) {
        final response = await supabaseClient.from('profiles').select().eq('id', currentSession!.user.id).single();
        Log.loggerInformation('Response: $response');
        return UserModel.fromJson(response).copyWith(email: currentSession!.user.email);
      }
      return null;
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
