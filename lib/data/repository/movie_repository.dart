import 'dart:convert';

import 'package:mcini/data/interface/i_repository.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:mcini/data/provider/movies_provider.dart';

class MovieRepository {
  final MoviesProvider movieProvider;

  MovieRepository(this.movieProvider);

  Future<List<MovieModel>> getMovies() async {
    final movies = await movieProvider.getAllData();
    return movies;
  }
}
