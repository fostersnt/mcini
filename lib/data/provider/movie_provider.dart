import 'dart:convert';

import 'package:mcini/data/interface/i_repository.dart';
import 'package:mcini/data/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends IRepository {
  @override
  Future<bool> deleteData() async {
    return true;
  }

  @override
  Future<List<MovieModel>> getAllData() async {
    List<MovieModel> movies = [];
    String url = IRepository.apiBaseURL;
    final response = await http.post(Uri.parse("$url/movies/list"));
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonData['success'] == 'true') {
      final mainData = jsonData['data'];
      print(mainData);
      if (mainData.isNotEmpty) {
        // print("MY MOVIES DATA RECENT: $jsonData");
        for (var i = 0; i < mainData.length; i++) {
          MovieModel myCurrentMovie = MovieModel(
            id: mainData[i]['id'],
            title: mainData[i]['title'] ?? '',
            description: mainData[i]['description'] ?? '',
            thumbnail: mainData[i]['default_thumbnail_filename'] ?? '',
            videoUrl: mainData[i]['video_url'] ?? '',
            collectionName: mainData[i]['collection_name'] ?? '',
          );
          movies.add(myCurrentMovie);
        }
      }
    }
    print("MY MOVIES DATA: ${movies[0].id}");
    return movies;
  }

  @override
  Future<MovieModel> getSingleData() async {
    // TODO: implement getSingleData
    throw UnimplementedError();
  }

  @override
  Future<MovieModel> updateData() async {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
