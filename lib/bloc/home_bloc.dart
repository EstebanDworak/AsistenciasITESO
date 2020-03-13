import 'dart:async';
import 'dart:io';

import 'package:asistencias/models/Subject.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

part 'home_event.dart';
part 'home_state.dart';






class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Box _configBox;


  @override
  HomeState get initialState => HomeInitial();
  HomeBloc() {
    // referencia a la box
    // _configBox = Hive.box("configs");
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadSubjectsEvent) {
      try {

        final List<Subject> subjects = await new SubjectApiClient(httpClient: new http.Client()).fetchQuote();

        yield LoadedSubectsState(subjects: subjects);

      } catch (ex) {
        // no hay datos
        print(ex.toString());
        yield ErrorState(error: "Error al cargar materias");
      }
    }
    if (event is LoadNewSubjectsEvent) {
      try {

        final List<Subject> subjects = await new NewSubjectApiClient(httpClient: new http.Client()).fetchQuote();

        yield LoadedNewSubectsState(newSubjects: subjects);

      } catch (ex) {
        // no hay datos
        print(ex.toString());
        yield ErrorState(error: "Error al cargar materias");
      }
    }
    if (event is LoadedNewSubjectsEvent) {
      yield DoneState();
    }
    if (event is LoadedSubjectsEvent) {
      yield DoneState();
    }
    if (event is AddSubectEvent) {

    // http.Client httpClient =  new http.Client();
    // await  httpClient.post('postURL_TODO');

// TODO POST
print('TODO POST');

      yield DoneState();
    }

  }
}
