import 'package:mcini/data/interface/i_repository.dart';
import 'package:mcini/data/model/movie_model.dart';

class MovieRepository extends IRepository {
  final _movidModel = MovieModel();

  @override
  Future<bool> deleteData() async {
    String url = IRepository.apiBaseURL;
    return true;
  }

  @override
  Future<List<Object>> getAllData() async {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  Future<Object> getSingleData() async {
    // TODO: implement getSingleData
    throw UnimplementedError();
  }

  @override
  Future<bool> updateData() async {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
