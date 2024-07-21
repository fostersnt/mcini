// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mcini/data/interface/i_repository.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:mcini/utilities/shared_preferences.dart';

class FavoriteMoviesPage extends StatefulWidget {
  const FavoriteMoviesPage({super.key});

  @override
  State<FavoriteMoviesPage> createState() => _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState extends State<FavoriteMoviesPage> {
  List<MovieModel> movies = [];
  final String collectionName = 'Favorites';

  @override
  void initState() {
    super.initState();
    _fetchFavoriteMovies();
  }

  Future<void> _fetchFavoriteMovies() async {
    final List<MovieModel> data = await MovieModel.fetchFavoriteMovies();
    if (data.isNotEmpty) {
      setState(() {
        movies = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          collectionName,
          style: TextStyle(
            color: AppColors.blueColor,
          ),
        ),
        backgroundColor: AppColors.blackColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
            size: 20,
          ),
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: movies.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of items per row
                    crossAxisSpacing:
                        4, // Spacing between each item horizontally
                    mainAxisSpacing: 4, // Spacing between each row vertically
                    childAspectRatio:
                        0.8, // Ratio of width to height for each item
                  ),
                  itemBuilder: (context, index) {
                    print('CURRENT INDEX: $index');
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleMovieThumbnail(
                          deviceSize: deviceSize,
                          movieData: movies,
                          movieIndex: index,
                          childWidget: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  movies[index].title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: deviceSize.width * 0.03,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: InkWell(
                                  onTap: () async {
                                    print(
                                        'FAVOURITE MOVIE ID === ${movies[index].id}');
                                    final bool result =
                                        await MovieModel.like_Or_Unlike_Movie(
                                            '0', '${movies[index].id}');
                                    if (result) {
                                      setState(() {
                                        movies.removeAt(index);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        AppColors.customSnackBar(
                                            'Movie removed from favorites',
                                            deviceSize,
                                            false),
                                      );
                                    }
                                    if (movies.isEmpty) {
                                      setState(() {
                                        movies = [];
                                      });
                                    }
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColors.blueColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Center(
              child: Text(
                'No favorites movies found',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: deviceSize.width * 0.04,
                ),
              ),
            ),
    );
  }
}
