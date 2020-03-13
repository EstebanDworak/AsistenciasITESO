import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class Subject extends Equatable {
  final String name;
  final String schedule;
  final int assist;

  const Subject({this.name = "", this.schedule ="", this.assist=0});

  @override
  List<Object> get props => [name, schedule, assist];

  static Subject fromJson(dynamic json) {
    return Subject(
      name: json['name'],
      schedule: json['schedule'],
      assist: json['assist'],
    );
  }

  @override
  String toString() => 'Quote { id: $name $schedule $assist}';
}



class SubjectApiClient {
  final http.Client httpClient;

  SubjectApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Subject>> fetchQuote() async {
    final url = 'https://api.myjson.com/bins/ibo7e';
    final response = await this.httpClient.get(url);
  print('acaca');
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
      List<Subject> quotes = new List<Subject>();

    for (var i = 0; i < json['classes'].length; i++) {
      quotes.add(Subject.fromJson(json['classes'][i]));

    // print(json['classes'][i]);
    }
    
    return quotes;
  }
}