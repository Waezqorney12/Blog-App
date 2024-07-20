import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';

class BlogModel extends BlogEntities {
  BlogModel(
      {required super.id,
      required super.userId,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      topics: json['topics'] ?? '',
    );
  }


  // # This method doesn't needed if using supabase it will be handled by supabase
  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'userId': super.userId,
      'title': super.title,
      'content': super.content,
      'imageUrl': super.imageUrl,
      'topics': super.topics,
    };
  }
}
