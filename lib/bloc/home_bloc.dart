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
    if (event is LoadConfigsEvent) {
      try {

        final List<Subject> subjects = await new SubjectApiClient(httpClient: new http.Client()).fetchQuote();

        yield LoadedConfigsState(subjects: subjects);

      } catch (ex) {
        // no hay datos
        print(ex.toString());
        yield ErrorState(error: "No hay datos guardados...");
      }
    }
    if (event is LoadedConfigsEvent) {
      yield DoneState();
    }
    // if (event is SaveConfigsEvent) {
    //   try {
    //     // verificar si existen datos
    //     if (_configBox.values.first == null) throw Exception();
    //     // cargar datos
    //     _configBox.put("drop", event.configs["drop"]);
    //     _configBox.put("switch", event.configs["switch"]);
    //     _configBox.put("checkbox", event.configs["checkbox"]);
    //     _configBox.put("slider", event.configs["slider"]);

    //     yield DoneState();
    //   } catch (ex) {
    //     // error al guardar
    //     print(ex.toString());
    //     yield ErrorState(error: "Error al guardar");
    //   }
    // }
  }
}
