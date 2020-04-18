import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Subject extends Equatable {
  final String name;
  final String schedule;
  final int assist;

  const Subject({this.name = "", this.schedule = "", this.assist = 0});

  @override
  List<Object> get props => [name, schedule, assist];

  static Subject fromJson(dynamic json) {
    return Subject(
      assist: int.parse(json['fields']['assist']['integerValue']),
      schedule: json['fields']['schedule']['stringValue'],
      name: json['fields']['name']['stringValue'],
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
    final url =
        'https://firestore.googleapis.com/v1/projects/asistenciasiteso/databases/(default)/documents/usersubjects/';
    final response = await this.httpClient.get(url);
    print('acaca');

    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
    List<Subject> quotes = new List<Subject>();

    for (var i = 0; i < json['documents'].length; i++) {
      quotes.add(Subject.fromJson(json['documents'][i]));

      // print(json['classes'][i]);
    }

    return quotes;
  }
}

class NewSubjectApiClient {
  final http.Client httpClient;

  NewSubjectApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Subject>> fetchQuote() async {
    // Firestore.instance
    //     .collection('subjects')
    //     .where("schedule", isEqualTo: "5 a 55")
    //     .snapshots()
    //     .listen((data) {
    //   List<Subject> quotes = new List<Subject>();
    //   data.documents.forEach((doc) {
    //     print(doc["name"]);
    //     Subject subject = new Subject(
    //         assist: doc["assist"],
    //         name: doc["name"],
    //         schedule: doc["schedule"]);
    //     quotes.add(subject);
    //   });

    //   return quotes;
    // });

    final url =
        'https://firestore.googleapis.com/v1/projects/asistenciasiteso/databases/(default)/documents/subjects/';
    final response = await this.httpClient.get(url);
    print('acaca');
    if (response.statusCode != 200) {
      throw new Exception('error getting quotes');
    }

    final json = jsonDecode(response.body);
    List<Subject> quotes = new List<Subject>();

    for (var i = 0; i < json['documents'].length; i++) {
      quotes.add(Subject.fromJson(json['documents'][i]));

      // print(json['classes'][i]);
    }

    return quotes;
  }
}

class PostSubject {
  void post(Subject subject) async {
    Firestore.instance.collection('usersubjects').document().setData({
      'name': subject.name,
      'schedule': subject.schedule,
      'assist': subject.assist
    });
  }
}
