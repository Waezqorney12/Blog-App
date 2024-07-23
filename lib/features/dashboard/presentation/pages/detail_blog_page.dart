import 'package:blog_application/core/utils/app_date_utils.dart';
import 'package:blog_application/core/utils/calculate_reading_time_utils.dart';
import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';
import 'package:flutter/material.dart';

class DetailBlogPage extends StatelessWidget {
  final BlogEntities blogModel;
  const DetailBlogPage({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogModel.title,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'By ${blogModel.userName}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  '${AppDateUtil.formatDateTime(format: CustomDateFormat.date, dateTime: blogModel.updatedAt)}, ${calculateReadingTime(blogModel.content) != 0 ? calculateReadingTime(blogModel.content) : 1} min read',
                  style: const TextStyle(fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(blogModel.imageUrl),
                  ),
                ),
                Text(
                  textAlign: TextAlign.justify,
                  blogModel.content,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
