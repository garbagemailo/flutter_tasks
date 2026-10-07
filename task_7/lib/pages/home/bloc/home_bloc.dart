import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/data_format.dart';
import '../../../mock/formats_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.loadDelay = const Duration(milliseconds: 500)})
      : super(const HomeInitial()) {
    on<LoadFormats>(_load);
  }
  final Duration loadDelay;

  Future<void> _load(LoadFormats event, Emitter<HomeState> emit) async {
    // Повторные нажатия не запускают параллельную загрузку.
    if (state is HomeLoading) return;
    emit(const HomeLoading());
    try {
      // Учебная имитация задержки; внешнего источника данных нет.
      await Future<void>.delayed(loadDelay);
      if (emit.isDone) return;
      if (event.simulateError) {
        throw StateError('Учебная ошибка загрузки');
      }
      emit(HomeLoaded(formats));
    } catch (_) {
      if (!emit.isDone) {
        emit(const HomeError('Не удалось загрузить форматы данных. Повторите попытку.'));
      }
    }
  }
}
