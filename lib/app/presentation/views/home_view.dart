import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('home'.tr),
      ),
    );
  }
}
