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
    final response = await http.get(Uri.parse("$url/posts"));
    final jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData.isNotEmpty) {
        print("MY MOVIES DATA RECENT: $jsonData");
        for (var i = 0; i < jsonData.length; i++) {
          MovieModel myCurrentMovie = MovieModel(title: jsonData[i]['title']);
          movies.add(myCurrentMovie);
        }
      }
    }
    print("MY MOVIES DATA: $jsonData");
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
