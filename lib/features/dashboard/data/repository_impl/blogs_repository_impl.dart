import 'dart:io';

import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/utils/log_utils.dart';
import 'package:blog_application/features/dashboard/data/model/blog_model.dart';
import 'package:blog_application/features/dashboard/domain/datasource/blogs_remote_datasource.dart';
import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';
import 'package:blog_application/features/dashboard/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/function_helper_utils.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;
  BlogRepositoryImpl(this.blogRemoteDatasource);

  @override
  Future<Either<FailureMessage, BlogEntities>> uploadBlog(
          {required File imageFile,
          required String title,
          required String content,
          required String userId,
          required List<String> categories}) async =>
      helperCall<BlogEntities>(
        apiCall: () async {
          BlogModel blogModel = BlogModel(
            id: const Uuid().v1(),
            userId: userId,
            title: title,
            content: content,
            imageUrl: '',
            topics: categories,
            updatedAt: DateTime.now(),
          );
          await blogRemoteDatasource
              .uploadBlogImage(model: blogModel, imageFile: imageFile)
              .then((value) => blogModel = blogModel.copyWith(imageUrl: value));
          Log.loggerError('URL: ${blogModel.imageUrl}');
          final upload = await blogRemoteDatasource.uploadBlog(blogModel);
          return upload;
        },
      );

  @override
  Future<Either<FailureMessage, List<BlogEntities>>> getBlogs() {
    return helperCall<List<BlogEntities>>(apiCall: () async {
      final blog = await blogRemoteDatasource.getBlogs();
      return blog;
    });
  }
}
