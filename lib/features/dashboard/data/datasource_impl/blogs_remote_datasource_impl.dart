import 'dart:io';

import 'package:blog_application/core/config/exception.dart';
import 'package:blog_application/core/utils/log.dart';
import 'package:blog_application/features/dashboard/data/model/blog_model.dart';
import 'package:blog_application/features/dashboard/domain/datasource/blogs_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient supabaseClient;
  BlogRemoteDatasourceImpl(this.supabaseClient);
  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final response = await supabaseClient.from('blogs').select('*, profiles (name)');
      final data = response
          .map((value) => BlogModel.fromJson(value).copyWith(
                userName: value['profiles']['name'],
              ))
          .toList();
      return data;
    } on ServerException catch (e) {
      throw ServerException(message: "ServerException error in datasource: $e");
    }
  }

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final request = await supabaseClient.from('blogs').insert(blogModel.toJson()).select();
      return BlogModel.fromJson(request.first);
    } on ServerException catch (e) {
      throw ServerException(message: "ServerException error in datasource: $e");
    }
  }

  @override
  Future<String> uploadBlogImage({required BlogModel model, required File imageFile}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(model.id, imageFile);
      final response = supabaseClient.storage.from('blog_images').getPublicUrl(model.id);
      Log.loggerInformation("Image URL: $response");
      return response;
    } on StorageException catch (e) {
      Log.loggerError("StorageException error in datasource: $e");
      throw ServerException(message: "StorageException error in datasource: $e");
    } on ServerException catch (e) {
      throw ServerException(message: "ServerException error in datasource: $e");
    }
  }
}
