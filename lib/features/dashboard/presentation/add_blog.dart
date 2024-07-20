import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:blog_application/features/dashboard/controller/add_blog_controller.dart';
import 'package:blog_application/features/dashboard/widget/blog_editor.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  late final AddBlogController _controller;

  @override
  void initState() {
    _controller = AddBlogController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.titleController.dispose();
    _controller.contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widht = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: widht,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppPallete.borderColor),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 50,
                      ),
                      SizedBox(height: 20),
                      Text('Select your image'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['Technology', 'Programming', 'Health', 'Business', 'Entertainment', 'Sports']
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  //selectedCategories = e;
                                  if (_controller.selectedCategoriesList.contains(e)) {
                                    _controller.selectedCategoriesList.remove(e);
                                  } else {
                                    _controller.selectedCategoriesList.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  label: Text(e),
                                  color: MaterialStatePropertyAll(
                                    //_controller.selectedCategories == e ? AppPallete.gradient2 : AppPallete.backgroundColor,
                                    _controller.selectedCategoriesList.contains(e)
                                        ? AppPallete.gradient2
                                        : AppPallete.backgroundColor,
                                  ),
                                  side: BorderSide(
                                    color:

                                        // _controller.selectedCategories == e ? AppPallete.backgroundColor : AppPallete.borderColor,
                                        _controller.selectedCategoriesList.contains(e)
                                            ? AppPallete.backgroundColor
                                            : AppPallete.borderColor,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: BlogEditor(controller: _controller.titleController, hintText: 'Blog Title'),
              ),
              BlogEditor(controller: _controller.contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
