import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc(super.initialState, this.movieRepository) {
    //FETCHING ALL MOVIES
    on<MovieEvent>((event, emit) async {
      emit(MovieInitialState());
      try {
        final myMovies = await movieRepository.getMovies();
        emit(MovieSuccessfulState(movies: myMovies));
      } catch (e) {
        String error = e.toString();
        emit(MovieErrorState(errorMessage: 'Unable to fetch movies'));
        //Make an implementation to send error message to API
      }
    });
  }
}
