import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/provider/movie_provider.dart';
import 'package:mcini/data/repository/movie_repository.dart';
import 'package:mcini/screens/home/custom_padding.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';
import 'package:collection/collection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(movieProvider: MovieProvider()),
      child: BlocProvider(
        create: (context) => MovieBloc(
          movieRepository: MovieRepository(
            movieProvider: MovieProvider(),
          ),
        ),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(AllMoviesEvent());
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.blackColor,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            );
          }
          if (state is MovieSuccessfulState) {
            final movieData = state.movies;
            List<MovieModel> latestMovies =
                movieData.sublist(movieData.length - 10);

            if (movieData.length > 100) {
              latestMovies = movieData.sublist(movieData.length - 20);
            }
            final otherMovies = groupBy(movieData, (movie) => movie.title);

            return ListView(
              padding: const EdgeInsets.all(0),
              children: [
                //Image and top text
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: HeroSection(
                    deviceSize: screenSize,
                  ),
                ),
                //Latest Movie category
                CustomPadding(
                    screenSize: screenSize, category: 'Latest Movies'),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: screenSize.width * 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: latestMovies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                          child: SingleMovieThumbnail(
                            deviceSize: screenSize,
                            movieData: latestMovies[index],
                          ),
                        );
                      },
                    ),
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
                  style: TextStyle(fontSize: 30),
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
