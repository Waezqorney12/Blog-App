class BlogEntities {
  // # Variable topics is used for categories blog

  final String id;
  final String userId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;

  BlogEntities(
      {required this.id,
      required this.userId,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.topics});
}
