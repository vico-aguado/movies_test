import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

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
      body: Obx(() {
        if (controller.isLoading.value && controller.movies.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount:
                controller.movies.length + (controller.isLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.movies.length) {
                return Center(child: CircularProgressIndicator());
              }

              final movie = controller.movies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Release Date: ${movie.releaseDate}'),
                    Text('Genres: ${movie.genres}'),
                    Text(movie.overview),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
