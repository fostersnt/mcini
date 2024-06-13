class MovieModel {
  final String allMoviesEndpoint = '/movies';

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.collectionName,
  });

  String singleMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/$movieId";
  }

  String deleteMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/delete/$movieId";
  }

  String updateMovieEndpoint(int movieId) {
    return "$allMoviesEndpoint/update/$movieId";
  }

  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final String collectionName;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        thumbnail: json['default_thumbnail_filename'],
        videoUrl: json['video_url'],
        collectionName: json['collection_name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'default_thumbnail_filename': thumbnail,
      'video_url': videoUrl,
    };
  }
}
