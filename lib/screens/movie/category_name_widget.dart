import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/movie/movie_view_all_page.dart';
import 'package:mcini/utilities/app_colors.dart';

class CategoryNameWidget extends StatelessWidget {
  final String categoryName;
  final List<MovieModel> movies;

  const CategoryNameWidget(
      {super.key, required this.categoryName, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            categoryName,
            style: TextStyle(
              color: AppColors.blueColor,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieViewAllPage(myMovies: movies),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.forward,
              color: AppColors.blueColor,
            ),
          ),
        ),
      ],
    );
  }
}
