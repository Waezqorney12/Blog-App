import 'package:blog_application/features/dashboard/domain/entities/blog_entities.dart';
import 'package:flutter/material.dart';

class DetailBlogPage extends StatelessWidget {
  final BlogEntities blogModel;
  const DetailBlogPage({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(blogModel.imageUrl),
            Text(
              blogModel.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(blogModel.content),
            ),
          ],
        ),
      ),
    );
  }
}
