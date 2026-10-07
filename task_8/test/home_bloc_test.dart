import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:task/domain/models/data_format.dart';
import 'package:task/domain/repositories/formats_repository.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';

class ControlledRepository implements FormatsRepository {
  Completer<List<DataFormat>> pending = Completer<List<DataFormat>>();
  int calls = 0;
  @override
  Future<List<DataFormat>> fetchAll() {
    calls++;
    return pending.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('loading → error → retry → loaded без зависимости от Drift', () async {
    final repo = ControlledRepository();
    final bloc = HomeBloc(repo);
    addTearDown(bloc.close);
    expect(bloc.state, isA<HomeInitial>());
    final failed = expectLater(
      bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeError>()]),
    );
    bloc.add(const LoadFormats());
    await Future<void>.delayed(Duration.zero);
    repo.pending.completeError(StateError('database unavailable'));
    await failed;
    repo.pending = Completer<List<DataFormat>>();
    final loaded = expectLater(
      bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeLoaded>()]),
    );
    bloc.add(const LoadFormats());
    await Future<void>.delayed(Duration.zero);
    repo.pending.complete([]);
    await loaded;
    expect(
      () => (bloc.state as HomeLoaded).formats.clear(),
      throwsUnsupportedError,
    );
  });
  test('повторное событие не запускает второй запрос', () async {
    final repo = ControlledRepository();
    final bloc = HomeBloc(repo);
    addTearDown(bloc.close);
    bloc.add(const LoadFormats());
    bloc.add(const LoadFormats());
    await Future<void>.delayed(Duration.zero);
    expect(repo.calls, 1);
    final loaded = bloc.stream.firstWhere((s) => s is HomeLoaded);
    repo.pending.complete([]);
    await loaded;
  });
}
