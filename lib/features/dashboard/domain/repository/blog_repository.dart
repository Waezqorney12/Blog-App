import 'dart:io';

import 'package:blog_application/core/failure/failure_message.dart';
import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<FailureMessage, BlogEntities>> uploadBlog({
    required File imageFile,
    required String title,
    required String content,
    required String userId,
    required List<String> categories,
  });

  Future<Either<FailureMessage, List<BlogEntities>>> getBlogs();
}
