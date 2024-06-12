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
    final Map<String, dynamic> jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonData.isNotEmpty) {
        for (var i = 0; i < jsonData.length; i++) {
          movies.add(jsonData[i]);
        }
      }
    }
    // print(jsonData.);
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
