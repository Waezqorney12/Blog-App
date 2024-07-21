import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';

class BlogModel extends BlogEntities {
  const BlogModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.userName,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['image_url'] ?? '',
      topics: List<String>.from(json['topics'] ?? '' as List<String>),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'user_id': super.userId,
      'title': super.title,
      'content': super.content,
      'image_url': super.imageUrl,
      'topics': super.topics,
      'updated_at': super.updatedAt.toIso8601String(),
    };
  }

  BlogModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? userName,
  }) {
    return BlogModel(
      id: id ?? super.id,
      userId: userId ?? super.userId,
      title: title ?? super.title,
      content: content ?? super.content,
      imageUrl: imageUrl ?? super.imageUrl,
      topics: topics ?? super.topics,
      updatedAt: updatedAt ?? super.updatedAt,
      userName: userName ?? super.userName,
    );
  }
}
