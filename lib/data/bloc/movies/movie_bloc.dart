import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcini/data/bloc/movies/movie_event.dart';
import 'package:mcini/data/bloc/movies/movie_state.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;
  MovieBloc({required this.movieRepository}) : super(MovieInitialState()) {
    //FETCHING ALL MOVIES
    on<MovieEvent>((event, emit) async {
      emit(MovieLoadingState());
      String error = '';
      try {
        final myMovies = await movieRepository.getMovies();
        // print('HAHAHAHA ${myMovies}');

        if (myMovies.isNotEmpty) {
          emit(MovieSuccessfulState(movies: myMovies));
        } else {
          error = "No movies available";
          emit(MovieErrorState(errorMessage: error));
        }
      } catch (e) {
        error = e.toString();
        emit(MovieErrorState(errorMessage: error));
        print('ERROR MESSAGE === $error');
        //Make an implementation to send error message to API
      }
    });
  }
}
