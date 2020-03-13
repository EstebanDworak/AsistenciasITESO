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

class LoadedSubectsState extends HomeState {
  final List<Subject> subjects;

  LoadedSubectsState({@required this.subjects});
  @override
  List<Object> get props => [subjects];
}


class LoadedNewSubectsState extends HomeState {
  final List<Subject> newSubjects;

  LoadedNewSubectsState({@required this.newSubjects});
  @override
  List<Object> get props => [newSubjects];
}


class ErrorState extends HomeState {
  final String error;

  ErrorState({@required this.error});
  @override
  List<Object> get props => [error];
}
