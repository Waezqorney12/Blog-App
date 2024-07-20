import 'package:flutter/material.dart';

class AddBlogController  {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  List<String> selectedCategoriesList = [];

  // # This is used for handle single selection
  //String selectedCategories = "";

  
}
