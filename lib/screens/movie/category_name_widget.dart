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
    final Size deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieViewAllPage(
              myMovies: movies,
              collectionName: categoryName,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              categoryName,
              style: TextStyle(
                color: AppColors.blueColor,
                fontSize: deviceSize.width * 0.05,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blueColor,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
