abstract class IRepository<GWOSEVO> {
  static const String apiBaseURL = 'https://mcini.tv/api/v1';

  Future<List<GWOSEVO>> getAllData();
  Future<GWOSEVO> getSingleData();
  Future<GWOSEVO> updateData();
  Future<bool> deleteData();
}
