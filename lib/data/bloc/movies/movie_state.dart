import 'package:equatable/equatable.dart';
import 'package:mcini/data/model/movie_model.dart';

sealed class MovieState extends Equatable {}

class MovieInitialState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieLoadingState extends MovieState {
  @override
  List<Object?> get props => [];
}

class MovieSuccessfulState extends MovieState {
  final List<MovieModel> movies;

  MovieSuccessfulState({required this.movies});
  @override
  List<Object?> get props => movies;
}

class LatestMovieState extends MovieState {
  final List<MovieModel> latestMovies;

  LatestMovieState({required this.latestMovies});
  @override
  List<Object?> get props => latestMovies;
}

class OtherMoviesState extends MovieState {
  final List<MovieModel> otherMovies;

  OtherMoviesState({required this.otherMovies});
  @override
  List<Object?> get props => otherMovies;
}

class MovieErrorState extends MovieState {
  final String errorMessage;

  MovieErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
