import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';

class SimilarMovies extends StatelessWidget {
  final List<MovieModel> myMovies;
  final int clickedMovieIndex;

  const SimilarMovies(
      {super.key, required this.myMovies, required this.clickedMovieIndex});

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    // Calculate the item width based on the screen size
    double itemWidth = deviceSize.width * 0.3; // 30% of screen width
    double aspectRatio = 2 / 3; // Width to Height ratio of the item

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myMovies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 4, // Spacing between each item horizontally
            mainAxisSpacing: 4, // Spacing between each row vertically
            childAspectRatio: 0.7,
            // aspectRatio, // Ratio of width to height for each item
          ),
          itemBuilder: (context, index) {
            if (index == clickedMovieIndex) {
              if (myMovies.length - index != 0) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleMovieThumbnail(
                      deviceSize: deviceSize,
                      movieData: myMovies,
                      movieIndex: index + 1,
                      childWidget: Text(
                        myMovies[index].title ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: deviceSize.width * 0.03,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return null;
              }
            }

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleMovieThumbnail(
                  deviceSize: deviceSize,
                  movieData: myMovies,
                  movieIndex: index,
                  childWidget: Text(
                    myMovies[index].title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: deviceSize.width * 0.03,
                    ),
                  ),
                ),
              ),
            );
            // return Container(
            //   // color: AppColors.greySub,
            //   // width: itemWidth,
            //   // height: itemWidth / aspectRatio,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: index == clickedMovieIndex
            //         ? null
            //         : SingleMovieThumbnail(
            //             deviceSize: deviceSize,
            //             movieData: myMovies,
            //             movieIndex: index,
            //           ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
