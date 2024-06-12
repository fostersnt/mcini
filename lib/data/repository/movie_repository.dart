import 'package:mcini/data/model/movie_model.dart';
import 'package:mcini/data/provider/movie_provider.dart';

class MovieRepository {
  final MovieProvider movieProvider;

  MovieRepository({required this.movieProvider});

  Future<List<MovieModel>> getMovies() async {
    final movies = await movieProvider.getAllData();
    return movies;
  }
}
