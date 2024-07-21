part of 'blog_bloc.dart';

@immutable
sealed class BlogState {
  const BlogState();
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;
  const BlogFailure({required this.message});
}

final class BlogLoaded extends BlogState {
  final List<BlogEntities> blogs;
  const BlogLoaded({required this.blogs});
}
