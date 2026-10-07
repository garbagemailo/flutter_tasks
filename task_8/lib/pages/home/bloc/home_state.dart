part of 'home_bloc.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  HomeLoaded(List<DataFormat> items)
    : formats = List<DataFormat>.unmodifiable(items);
  final List<DataFormat> formats;
}

final class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
}
