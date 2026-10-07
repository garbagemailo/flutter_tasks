import 'package:drift/native.dart';
import 'package:task/data/database/app_database.dart';
import 'package:task/di/di.dart';

Future<void> setupTestDI() async {
  await getIt.reset();
  setupDI();
  await getIt.unregister<AppDatabase>();
  getIt.registerSingleton<AppDatabase>(
    AppDatabase(NativeDatabase.memory()),
    dispose: (db) => db.close(),
  );
}
