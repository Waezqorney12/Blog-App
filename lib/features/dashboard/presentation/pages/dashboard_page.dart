import 'package:blog_application/core/common/widget/loader.dart';
import 'package:blog_application/core/utils/calculate_reading_time_utils.dart';
import 'package:blog_application/core/utils/show_snackbar_utils.dart';
import 'package:blog_application/features/dashboard/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/app_routes.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(GetAllBlogBloc());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(Routes.blogForm()),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) showSnackBar(context, state.message);
        },
        builder: (context, state) {
          return switch (state) {
            BlogLoading() => const Loader(),
            BlogLoaded() => Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.blogs.asMap().entries.map((entry) {
                      final index = entry.key;
                      final blog = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: InkWell(
                          onTap: () => Navigator.push(context, Routes.blogDetail(blog)),
                          child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index % 3 == 0
                                    ? const Color.fromARGB(255, 131, 44, 102)
                                    : index % 3 == 1
                                        ? const Color.fromARGB(255, 44, 102, 131)
                                        : const Color.fromARGB(255, 102, 131, 44),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: blog.topics
                                                .map((e) => Padding(
                                                      padding: const EdgeInsets.only(right: 4),
                                                      child: Chip(label: Text(e)),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                        Text(
                                          blog.title.length > 25 ? '${blog.title.substring(0, 25)}..' : blog.title,
                                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Text(calculateReadingTime(blog.content) == 0
                                        ? '1 min read'
                                        : '${calculateReadingTime(blog.content)} min read'),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            _ => const Center(
                child: Text('No data available'),
              ),
          };
        },
      ),
    );
  }
}
