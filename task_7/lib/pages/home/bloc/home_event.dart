part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class LoadFormats extends HomeEvent {
  const LoadFormats({this.simulateError = false});
  final bool simulateError;
}
