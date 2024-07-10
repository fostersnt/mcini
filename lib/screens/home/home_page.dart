import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/screens/home/custom_padding.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/screens/movie/category_name_widget.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:collection/collection.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider(
//       create: (context) => MovieRepository(movieProvider: MovieProvider()),
//       child: BlocProvider(
//         create: (context) => MovieBloc(
//           movieRepository: MovieRepository(
//             movieProvider: MovieProvider(),
//           ),
//         ),
//         child: const HomeView(),
//       ),
//     );
//   }
// }

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(AllMoviesEvent());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.miniBlueColor,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.blueColor,
              ),
            );
          }
          if (state is MovieSuccessfulState) {
            final movieData = state.movies;
            List<MovieModel> latestMovies =
                movieData.sublist(movieData.length - 10);

            if (movieData.length > 100) {
              latestMovies = movieData.sublist(movieData.length - 20);
              print('LATEST MOVIES COUNT ==== ${latestMovies.length}');
            }

            final Map<String, List<MovieModel>> groupedMovies =
                groupBy(movieData, (movie) => movie.collectionName ?? 'N/A');
            final List<MapEntry<String, List<MovieModel>>> groupedMoviesList =
                groupedMovies.entries.toList();

            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: HeroSection(
                    deviceSize: screenSize,
                  ),
                ),
                CustomPadding(
                  screenSize: screenSize,
                  categoryLabel: CategoryNameWidget(
                    categoryName: 'Latest Movies',
                    movies: latestMovies,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: latestMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child: SingleMovieThumbnail(
                            deviceSize: screenSize,
                            movieData: latestMovies,
                            movieIndex: index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: List.generate(groupedMoviesList.length, (index) {
                      String category = groupedMoviesList[index].key;
                      List<MovieModel> moviesInCategory =
                          groupedMoviesList[index].value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomPadding(
                            screenSize: screenSize,
                            categoryLabel: CategoryNameWidget(
                                categoryName: category,
                                movies: moviesInCategory),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: moviesInCategory.length,
                                itemBuilder: (context, subIndex) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 10),
                                    child: SingleMovieThumbnail(
                                      deviceSize: screenSize,
                                      movieData: moviesInCategory,
                                      movieIndex: subIndex,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            );
          } else if (state is MovieErrorState) {
            final error = state.errorMessage;
            return Scaffold(
              body: Center(
                child: Text(
                  error,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Unknown error just occurred',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
