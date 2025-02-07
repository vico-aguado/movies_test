import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../routes/app_routes.dart';

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
          return GridView.builder(
            controller: controller.scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount:
                controller.movies.length + (controller.isLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.movies.length) {
                return Center(child: CircularProgressIndicator());
              }

              final movie = controller.movies[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.movieDetail, arguments: movie);
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      movie.posterPath.isNotEmpty
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            )
                          : Container(
                              height: 200,
                              color: Colors.grey[300],
                              child: Center(child: Text('No Image Available')),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Release Date: ${movie.releaseDate}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
