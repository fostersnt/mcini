import 'dart:convert';

import 'package:mcini/data/interface/i_repository.dart';
import 'package:mcini/utilities/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MovieModel {
  final String allMoviesEndpoint = '/movies';

  MovieModel({
    required this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.videoUrl,
    this.collectionName,
  });

  // final List<MovieModel> movies = [
  //   MovieModel(
  //     id: 1,
  //     title: 'title',
  //     description: 'description',
  //     thumbnail: 'thumbnail',
  //     videoUrl: 'videoUrl',
  //     collectionName: 'c1',
  //   ),
  //   MovieModel(
  //     id: 2,
  //     title: 'title',
  //     description: 'description',
  //     thumbnail: 'thumbnail',
  //     videoUrl: 'videoUrl',
  //     collectionName: 'c4',
  //   ),
  //   MovieModel(
  //     id: 3,
  //     title: 'title',
  //     description: 'description',
  //     thumbnail: 'thumbnail',
  //     videoUrl: 'videoUrl',
  //     collectionName: 'c2',
  //   ),
  //   MovieModel(
  //     id: 4,
  //     title: 'title',
  //     description: 'description',
  //     thumbnail: 'thumbnail',
  //     videoUrl: 'videoUrl',
  //     collectionName: 'c4',
  //   ),
  // ];

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
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? videoUrl;
  final String? collectionName;

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

  static Future<bool> like_Or_Unlike_Movie(
      String isFavourite, String movieId) async {
    String baseURL = IRepository.apiBaseURL;
    String endpoint = 'movies/favorites';
    String url = '$baseURL/$endpoint';
    bool result = false;
    String msisdn = '';
    try {
      Map<String, dynamic>? subscriber =
          await LocalStorage.getStoredSubscriber();
      if (subscriber != null) {
        msisdn = subscriber['msisdn'];
      }
      Map<String, dynamic> requestBody = {
        'msisdn': msisdn,
        'movieId': movieId,
        'isFavorite': isFavourite,
      };
      final response = await http.post(Uri.parse(url), body: requestBody);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('MOVIE LIKING/UNLIKING RESPONSE === ${jsonData}');
        if (jsonData['success'].toString().toLowerCase() == 'true') {
          result = true;
        }
      }
    } catch (e) {
      print('MOVIE LIKING/UNLIKING ERROR === ${e.toString()}');
    }
    return result;
  }
}
