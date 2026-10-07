import '../models/data_format.dart';

abstract interface class FormatsRepository {
  Future<List<DataFormat>> fetchAll();
  Future<DataFormat?> findById(int id);
  Future<int> create(DataFormat format);
  Future<bool> update(DataFormat format);
  Future<bool> delete(int id);
}
