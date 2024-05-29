import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/provider/movies_provider.dart';
import 'package:mcini/data/repository/movie_repository.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/screens/home/home_page.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:collection/collection.dart';

class MovieCategoriesGroup extends StatelessWidget {
  const MovieCategoriesGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesProvider _mr = MoviesProvider();
    final screenSize = MediaQuery.of(context).size;
    List<Map<String, dynamic>> movies = [
      {
        'name': 'movie first',
        'title': 'Ghanaian movie',
        'category': 'Latest Movies',
        'thumbnail': 'lib/images/banner.png'
      },
      {
        'name': 'movie 1',
        'title': 'Ghanaian movie',
        'category': 'Ghana Girls',
        'thumbnail': 'lib/images/banner.png'
      },
      {
        'name': 'movie new',
        'title': 'Af movie',
        'category': 'Latest Movies',
        'thumbnail': 'lib/images/banner.png'
      },
      {
        'name': 'movie main',
        'title': 'Pp movie',
        'category': 'Latest Movies',
        'thumbnail': 'lib/images/banner.png'
      },
    ];

    final groupedMovies = groupBy(movies, (movie) => movie['category']);
    print(groupedMovies.keys.toList());

    final data = _mr.getAllData();
    // print(data);
    return Scaffold(
      body: GroupedListView(
        elements: movies,
        groupBy: (singleMovie) => singleMovie['category'],
        itemBuilder: (context, movies) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Container(
              width: 100,
              height: 100,
              color: AppColors.blueColor,
              child: Text(movies['category']),
            ),
          );
        },
        groupSeparatorBuilder: (currentMovie) {
          return ListTile(
            title: Text(currentMovie),
          );
        },
      ),
    );
  }
}
