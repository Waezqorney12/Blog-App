import 'dart:io';

import 'package:blog_application/features/dashboard/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/pick_image_utils.dart';

class AddBlogController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<String> selectedCategoriesList = [];

  // # This is used for handle single selection
  //String selectedCategories = "";
  File? fileImage;

  Future<void> selectImage<T>(void Function(T) pickingImage) async {
    final image = await pickImage();
    if (image != null) {
      pickingImage(image as T);
    }
  }

  BlogEvent uploadBlog({required String userId}) {
    return UploadBlogBloc(
      userId: userId,
      title: titleController.text,
      content: contentController.text,
      imageFile: fileImage!,
      categories: selectedCategoriesList,
    );
  }
}
