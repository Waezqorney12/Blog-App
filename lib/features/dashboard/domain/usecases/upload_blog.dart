import 'dart:io';

import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';
import 'package:blog_application/features/dashboard/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UserCase<BlogEntities, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<FailureMessage, BlogEntities>> call(UploadBlogParams params) {
    return blogRepository.uploadBlog(
      imageFile: params.imageFile,
      title: params.title,
      content: params.content,
      userId: params.userId,
      categories: params.categories,
    );
  }
}

class UploadBlogParams {
  final String userId;
  final String title;
  final String content;
  final File imageFile;
  final List<String> categories;

  UploadBlogParams({
    required this.userId,
    required this.title,
    required this.content,
    required this.imageFile,
    required this.categories,
  });
}
