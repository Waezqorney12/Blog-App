import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
      body: const Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
