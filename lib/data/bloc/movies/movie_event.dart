import 'package:equatable/equatable.dart';

sealed class MovieEvent extends Equatable {}

//The event below is for managing all movies
class AllMoviesEvent extends MovieEvent {
  @override
  List<Object?> get props => [];
}

class SingleMovieEvent extends MovieEvent {
  @override
  List<Object?> get props => [];
}
