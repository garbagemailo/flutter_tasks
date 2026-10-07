import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../data/database/app_database.dart';

Future<void> closeDatabase(AppDatabase database) => database.close();

@module
abstract class DatabaseModule {
  @LazySingleton(dispose: closeDatabase)
  AppDatabase get database => AppDatabase(
    driftDatabase(
      name: 'data_formats',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    ),
  );
}
