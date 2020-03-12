part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadConfigsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

class LoadedConfigsEvent extends HomeEvent {
  @override
  List<Object> get props => null;
}

// class SaveConfigsEvent extends HomeEvent {
//   final Map<String, dynamic> configs;

//   SaveConfigsEvent({@required this.configs});
//   @override
//   List<Object> get props => [configs];
// }
