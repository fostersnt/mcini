import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/provider/movie_provider.dart';
import 'package:mcini/data/repository/movie_repository.dart';
import 'package:mcini/screens/home/hero_section.dart';
import 'package:mcini/screens_commons/single_movie_thumbnail.dart';
import 'package:mcini/utilities/app_colors.dart';

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
    return SafeArea(
      child: Scaffold(
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
              } else if (state is MovieSuccessfulState) {
                final movieData = state.movies;
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
                    //First category
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text(
                          "Latest Movies",
                          style: TextStyle(
                            color: AppColors.blueColor,
                            fontSize: screenSize.width * 0.05,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: SingleMovieThumbnail(
                                deviceSize: screenSize,
                                movieData: MovieModel(
                                  title: movieData[index].title,
                                ),
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
          )),
    );
  }
}
