// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:blog_application/core/common/widget/loader.dart';
import 'package:blog_application/core/routes/app_routes.dart';
import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:blog_application/features/cubits/app_user/app_user_cubit.dart';
import 'package:blog_application/features/dashboard/controller/add_blog_controller.dart';
import 'package:blog_application/features/dashboard/widget/blog_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/show_snackbar.dart';
import '../bloc/blog_bloc.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  late final AddBlogController _controller;
  final formKey = GlobalKey<FormState>();

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
            onPressed: () {
              if (_controller.formKey.currentState!.validate() &&
                  _controller.fileImage != null &&
                  _controller.selectedCategoriesList.isNotEmpty) {
                final userId = (context.read<AppUserCubit>().state as AppUserLoggedIn).userEntities.id;
                BlocProvider.of<BlogBloc>(context).add(_controller.uploadBlog(userId: userId));
              }
            },
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure)
            showSnackBar(context, state.message);
          else if (state is BlogSuccess)
            Navigator.pushAndRemoveUntil(
              context,
              Routes.dashboard(),
              (route) => false,
            );
        },
        builder: (context, state) {
          if (state is BlogLoading) const Loader();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _controller.selectImage<File>((image) {
                          setState(() {
                            _controller.fileImage = image;
                          });
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: widht,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppPallete.borderColor),
                        ),
                        child: _controller.fileImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _controller.fileImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Column(
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
        },
      ),
    );
  }
}
