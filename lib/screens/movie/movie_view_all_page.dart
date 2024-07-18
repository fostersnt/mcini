import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';

class MovieViewAllPage extends StatelessWidget {
  final List<MovieModel> myMovies;
  final String collectionName;

  const MovieViewAllPage(
      {super.key, required this.myMovies, required this.collectionName});

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
          collectionName ?? 'Unknown Category',
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
            itemCount: myMovies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items per row
              crossAxisSpacing: 4, // Spacing between each item horizontally
              mainAxisSpacing: 4, // Spacing between each row vertically
              childAspectRatio: 0.8,
              // aspectRatio, // Ratio of width to height for each item
            ),
            itemBuilder: (context, index) {
              return Container(
                // width: itemWidth,
                // height: itemWidth / aspectRatio,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleMovieThumbnail(
                    deviceSize: deviceSize,
                    movieData: myMovies,
                    movieIndex: index,
                    childWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: InkWell(
                            onTap: () {
                              print(
                                  'FAVOURITE MOVIE ID === ${myMovies[index].id}');
                            },
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // child: Text(
                  //   myMovies[index].title ?? '',
                  //   style: TextStyle(
                  //     color: AppColors.whiteColor,
                  //     fontSize: deviceSize.width * 0.04,
                  //   ),
                  // ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
