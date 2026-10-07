import 'package:flutter_test/flutter_test.dart';
import 'package:task/data/database/app_database.dart';
import 'package:task/domain/repositories/formats_repository.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';
import 'package:task/di/di.dart';

import 'test_di.dart';

void main() {
  test('DI: БД и Repository единичные, BLoC — factory', () async {
    await setupTestDI();
    addTearDown(() => getIt.reset());
    expect(identical(getIt<AppDatabase>(), getIt<AppDatabase>()), isTrue);
    expect(
      identical(getIt<FormatsRepository>(), getIt<FormatsRepository>()),
      isTrue,
    );
    final first = getIt<HomeBloc>();
    final second = getIt<HomeBloc>();
    expect(identical(first, second), isFalse);
    await first.close();
    await second.close();
  });
}
