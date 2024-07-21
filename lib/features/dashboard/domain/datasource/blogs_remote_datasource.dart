import 'dart:io';

import 'package:blog_application/features/dashboard/data/model/blog_model.dart';

abstract interface class BlogRemoteDatasource{
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage({required BlogModel model, required File imageFile});
  Future<List<BlogModel>> getBlogs();
}