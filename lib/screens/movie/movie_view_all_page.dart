import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/utilities/app_colors.dart';

class MovieViewAllPage extends StatelessWidget {
  final List<MovieModel> myMovies;

  MovieViewAllPage({Key? key, required this.myMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    // Calculate the item width based on the screen size
    double itemWidth = deviceSize.width * 0.3; // 30% of screen width
    double aspectRatio = 2 / 3; // Width to Height ratio of the item

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: myMovies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of items per row
        crossAxisSpacing: 8, // Spacing between each item horizontally
        mainAxisSpacing: 8, // Spacing between each row vertically
        childAspectRatio: aspectRatio, // Ratio of width to height for each item
      ),
      itemBuilder: (context, index) {
        return Container(
          color: AppColors.greySub,
          width: itemWidth,
          height: itemWidth / aspectRatio,
          child: Center(
            child: Text(
              myMovies[index].title ?? '',
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
        );
      },
    );
  }
}
