abstract class IRepository<GWOSEVO> {
  static const String apiBaseURL = 'https://jsonplaceholder.typicode.com';

  Future<List<GWOSEVO>> getAllData();
  Future<GWOSEVO> getSingleData();
  Future<GWOSEVO> updateData();
  Future<bool> deleteData();
}
