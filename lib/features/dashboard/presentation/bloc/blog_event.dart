part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {
  const BlogEvent();
}

final class UploadBlogBloc extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File imageFile;
  final List<String> categories;

  const UploadBlogBloc({
    required this.userId,
    required this.title,
    required this.content,
    required this.imageFile,
    required this.categories,
  });
}

final class GetAllBlogBloc extends BlogEvent{}
