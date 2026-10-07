import 'package:drift/drift.dart';

import 'initial_formats.dart';

part 'app_database.g.dart';

@DataClassName('FormatRow')
class Formats extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get file => text().unique()();
  TextColumn get description => text()();
  TextColumn get fullDescription => text()();
  TextColumn get imagePath => text()();
}

@DriftDatabase(tables: [Formats])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await batch((batch) {
        batch.insertAll(
          formats,
          initialFormats
              .map(
                (f) => FormatsCompanion.insert(
                  id: Value(f.id),
                  name: f.name,
                  file: f.file,
                  description: f.description,
                  fullDescription: f.fullDescription,
                  imagePath: f.imagePath,
                ),
              )
              .toList(),
        );
      });
    },
  );
}
