import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task/data/database/app_database.dart';
import 'package:task/data/repositories/drift_formats_repository.dart';
import 'package:task/domain/models/data_format.dart';

DataFormat record({int id = 0, String name = 'NDJSON'}) => DataFormat(
  id: id,
  name: name,
  file: 'ndjson',
  description: 'JSON по строкам',
  fullDescription: 'Каждая строка содержит JSON.',
  imagePath: 'assets/images/json.png',
);
void main() {
  test('начальное заполнение и CRUD', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final repo = DriftFormatsRepository(db);
    final seeded = await repo.fetchAll();
    expect(seeded.map((e) => e.name), ['JSON', 'XML', 'CSV', 'YAML', 'TOML']);
    expect(seeded.first.imagePath, 'assets/images/json.png');
    final id = await repo.create(record());
    expect((await repo.findById(id))!.name, 'NDJSON');
    expect(await repo.update(record(id: id, name: 'JSON Lines')), isTrue);
    expect((await repo.findById(id))!.name, 'JSON Lines');
    expect(await repo.delete(id), isTrue);
    expect(await repo.findById(id), isNull);
    expect(await repo.delete(id), isFalse);
    expect(await repo.update(record(id: id)), isFalse);
  });
  test('файл сохраняет изменения, seed не повторяется при открытии', () async {
    final directory = await Directory.systemTemp.createTemp('formats_test_');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/formats.sqlite');
    var db = AppDatabase(NativeDatabase(file));
    var repo = DriftFormatsRepository(db);
    expect((await repo.fetchAll()).length, 5);
    await repo.delete(1);
    final id = await repo.create(record());
    await db.close();
    db = AppDatabase(NativeDatabase(file));
    addTearDown(db.close);
    repo = DriftFormatsRepository(db);
    expect((await repo.fetchAll()).length, 5);
    expect(await repo.findById(1), isNull);
    expect((await repo.findById(id))!.name, 'NDJSON');
  });
}
