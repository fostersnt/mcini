import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({required this.movieRepository}) : super(MovieInitialState()) {
    //FETCHING ALL MOVIES
    on<MovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      try {
        final myMovies = await movieRepository.getMovies();
        emit(MovieSuccessfulState(movies: myMovies));
      } catch (e) {
        String error = e.toString();
        emit(MovieErrorState(errorMessage: error));
        //Make an implementation to send error message to API
      }
    });
  }
}
