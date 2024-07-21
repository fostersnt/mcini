import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';

class MovieViewAllPage extends StatefulWidget {
  final List<MovieModel> myMovies;
  final String collectionName;

  const MovieViewAllPage(
      {super.key, required this.myMovies, required this.collectionName});

  @override
  State<MovieViewAllPage> createState() => _MovieViewAllPageState();
}

class _MovieViewAllPageState extends State<MovieViewAllPage> {
  List<bool> isFavoriteList = []; // List to store favorite state for each movie
  List<int> favoriteMovieIds = [];
  @override
  void initState() {
    super.initState();
    // Initialize the isFavoriteList with false for each movie
    isFavoriteList = List.generate(widget.myMovies.length, (index) => false);
    _fetchFavoriteMovies();
  }

  Future<void> _fetchFavoriteMovies() async {
    final List<MovieModel> data = await MovieModel.fetchFavoriteMovies();
    if (data.isNotEmpty) {
      for (var i = 0; i < data.length; i++) {
        setState(() {
          favoriteMovieIds.add(data[i].id);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;

    // Calculate the item width based on the screen size
    double itemWidth = deviceSize.width * 0.3; // 30% of screen width
    double aspectRatio = 2 / 3; // Width to Height ratio of the item

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.collectionName ?? 'Unknown Category',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.myMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 4, // Spacing between each item horizontally
              mainAxisSpacing: 4, // Spacing between each row vertically
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              return Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleMovieThumbnail(
                    deviceSize: deviceSize,
                    movieData: widget.myMovies,
                    movieIndex: index,
                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.myMovies[index].title ?? '',
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
                              bool check = favoriteMovieIds
                                  .contains(widget.myMovies[index].id);
                              bool result = false;
                              if (check) {
                                result = await MovieModel.like_Or_Unlike_Movie(
                                    '0', '${widget.myMovies[index].id}');
                              }
                              if (!check) {
                                result = await MovieModel.like_Or_Unlike_Movie(
                                    '1', '${widget.myMovies[index].id}');
                              }

                              if (result && check) {
                                setState(() {
                                  favoriteMovieIds.remove(widget.myMovies[index]
                                      .id); // Update favorite state for this movie
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  AppColors.customSnackBar(
                                    'Movie removed favorites',
                                    deviceSize,
                                    false,
                                  ),
                                );
                                print(
                                    'FAVOURITE MOVIE ID === ${widget.myMovies[index].id}');
                              } else if (result && !check) {
                                setState(() {
                                  favoriteMovieIds.add(widget.myMovies[index]
                                      .id); // Update favorite state for this movie
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  AppColors.customSnackBar(
                                    'Movie added to favorites',
                                    deviceSize,
                                    false,
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              Icons.favorite,
                              color: favoriteMovieIds
                                      .contains(widget.myMovies[index].id)
                                  ? AppColors.blueColor
                                  : AppColors.whiteColor,
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
      ),
    );
  }
}
