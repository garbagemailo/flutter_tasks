import 'package:flutter_test/flutter_test.dart';
import 'package:task/pages/home/bloc/home_bloc.dart';

void main() {
  test('initial → loading → loaded, неизменяемая коллекция', () async {
    final bloc = HomeBloc(loadDelay: Duration.zero);
    addTearDown(bloc.close);
    expect(bloc.state, isA<HomeInitial>());
    final result = expectLater(bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeLoaded>()]));
    bloc.add(const LoadFormats());
    await result;
    final loaded = bloc.state as HomeLoaded;
    expect(loaded.formats.length, 5);
    expect(() => loaded.formats.clear(), throwsUnsupportedError);
  });
  test('ошибка → повторная загрузка → loaded', () async {
    final bloc = HomeBloc(loadDelay: Duration.zero);
    addTearDown(bloc.close);
    final failed = expectLater(bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeError>()]));
    bloc.add(const LoadFormats(simulateError: true));
    await failed;
    final retried = expectLater(bloc.stream,
      emitsInOrder([isA<HomeLoading>(), isA<HomeLoaded>()]));
    bloc.add(const LoadFormats());
    await retried;
  });
  test('два события не создают две параллельные загрузки', () async {
    final bloc = HomeBloc(loadDelay: const Duration(milliseconds: 10));
    final states = <HomeState>[];
    final subscription = bloc.stream.listen(states.add);
    final loaded = bloc.stream.firstWhere((s) => s is HomeLoaded);
    bloc.add(const LoadFormats());
    bloc.add(const LoadFormats(simulateError: true));
    await loaded;
    await bloc.close();
    await subscription.cancel();
    expect(states.whereType<HomeLoading>().length, 1);
    expect(states.whereType<HomeError>(), isEmpty);
  });
}
