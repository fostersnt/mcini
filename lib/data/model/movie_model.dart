class MovieModel {
  final String allMoviesEndpoint = '/movies';

  MovieModel(
      {required this.name,
      required this.title,
      required this.category,
      required this.thumbnail});

  String singleMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/$movieId";
  }

  String deleteMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/delete/$movieId";
  }

  String updateMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/update/$movieId";
  }

  final String name;
  final String title;
  final String category;
  final String thumbnail;
}
