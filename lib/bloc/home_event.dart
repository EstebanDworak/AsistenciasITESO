part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadSubjectsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class LoadedSubjectsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}


class LoadNewSubjectsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class LoadedNewSubjectsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}


class AddSubectEvent extends HomeEvent {
  final Subject newSubject;

  AddSubectEvent({@required this.newSubject});
  @override
  List<Object> get props => [newSubject];
}

// class SaveConfigsEvent extends HomeEvent {
//   final Map<String, dynamic> configs;

//   SaveConfigsEvent({@required this.configs});
//   @override
//   List<Object> get props => [configs];
// }
