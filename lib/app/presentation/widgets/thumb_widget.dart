import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/movie_entity.dart';
import '../routes/app_routes.dart';

class ThumbWidget extends StatelessWidget {
  const ThumbWidget({
    super.key,
    required this.movie,
  });

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
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
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      height: 300,
                      width: double.infinity,
                    ),
                  )
                : Container(
                    height: 300,
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
                '${'release_date'.tr}: ${movie.releaseDate}',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
