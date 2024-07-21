import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/features/dashboard/domain/usecases/get_blog.dart';
import 'package:blog_application/features/dashboard/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../domain/entities/blog_entities.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlog _getBlog;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlog getBlog,
  })  : _uploadBlog = uploadBlog,
        _getBlog = getBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogBloc>((event, emit) async {
      final response = await _uploadBlog(UploadBlogParams(
          userId: event.userId,
          title: event.title,
          content: event.content,
          imageFile: event.imageFile,
          categories: event.categories));

      response.fold(
        (failure) => emit(BlogFailure(message: failure.message)),
        (response) => emit(BlogSuccess()),
      );
    });
    on<GetAllBlogBloc>((event, emit) async {
      final response = await _getBlog(
        NoParams(),
      );
      response.fold(
        (failure) => emit(BlogFailure(message: failure.message)),
        (response) => emit(BlogLoaded(blogs: response)),
      );
    });
  }
}
