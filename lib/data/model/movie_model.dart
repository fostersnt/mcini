class MovieModel {
  final String allMoviesEndpoint = '/movies';

  MovieModel({required this.title});

  String singleMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/$movieId";
  }

  String deleteMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/delete/$movieId";
  }

  String updateMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/update/$movieId";
  }

  // final String name;
  final String title;
  // final String category;
  // final String thumbnail;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
