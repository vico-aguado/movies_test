import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widgets/thumb_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        controller.loadMoreMovies();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                controller.filterMovies(query);
              },
              decoration: InputDecoration(
                labelText: 'search'.tr,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.filteredMovies.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                  controller: controller.scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.51,
                  ),
                  itemCount: controller.filteredMovies.length +
                      (controller.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == controller.filteredMovies.length) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final movie = controller.filteredMovies[index];
                    return ThumbWidget(movie: movie);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
