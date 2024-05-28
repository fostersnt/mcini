abstract class IRepository {
  static const String apiBaseURL = 'https://mcini.com/api';

  Future<Object> getSingleData();
  Future<List<Object>> getAllData();
  Future<bool> deleteData();
  Future<bool> updateData();
}
