part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class DoneState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadedConfigsState extends HomeState {
  final List<Subject> subjects;

  LoadedConfigsState({@required this.subjects});
  @override
  List<Object> get props => [subjects];
}

class ErrorState extends HomeState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
