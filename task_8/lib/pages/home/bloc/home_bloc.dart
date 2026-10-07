import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/models/data_format.dart';
import '../../../domain/repositories/formats_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<LoadFormats>(_load);
  }
  final FormatsRepository _repository;

  Future<void> _load(LoadFormats event, Emitter<HomeState> emit) async {
    if (state is HomeLoading) return;
    emit(const HomeLoading());
    try {
      final formats = await _repository.fetchAll();
      if (!emit.isDone) emit(HomeLoaded(formats));
    } catch (_) {
      if (!emit.isDone) {
        emit(
          const HomeError(
            'Не удалось прочитать базу форматов. Повторите попытку.',
          ),
        );
      }
    }
  }
}
