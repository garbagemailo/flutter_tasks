import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/data_format.dart';
import '../../domain/repositories/formats_repository.dart';
import '../database/app_database.dart';

@LazySingleton(as: FormatsRepository)
class DriftFormatsRepository implements FormatsRepository {
  DriftFormatsRepository(this._db);
  final AppDatabase _db;

  DataFormat _map(FormatRow row) => DataFormat(
    id: row.id,
    name: row.name,
    file: row.file,
    description: row.description,
    fullDescription: row.fullDescription,
    imagePath: row.imagePath,
  );

  @override
  Future<List<DataFormat>> fetchAll() async {
    final rows = await (_db.select(
      _db.formats,
    )..orderBy([(t) => OrderingTerm.asc(t.id)])).get();
    return rows.map(_map).toList(growable: false);
  }

  @override
  Future<DataFormat?> findById(int id) async {
    final row = await (_db.select(
      _db.formats,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _map(row);
  }

  FormatsCompanion _values(DataFormat f) => FormatsCompanion.insert(
    name: f.name,
    file: f.file,
    description: f.description,
    fullDescription: f.fullDescription,
    imagePath: f.imagePath,
  );

  @override
  Future<int> create(DataFormat format) =>
      _db.into(_db.formats).insert(_values(format));

  @override
  Future<bool> update(DataFormat format) async =>
      await (_db.update(
        _db.formats,
      )..where((t) => t.id.equals(format.id))).write(_values(format)) >
      0;

  @override
  Future<bool> delete(int id) async =>
      await (_db.delete(_db.formats)..where((t) => t.id.equals(id))).go() > 0;
}
