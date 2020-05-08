import 'dart:math';

import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SubjectCatalogTeacherList extends StatefulWidget {
  // final Function cb;
  // final String email;
  final GoogleSignInAccount account;

  const SubjectCatalogTeacherList({Key key, @required this.account})
      : super(key: key);

  @override
  _SubjectCatalogTeacherListState createState() =>
      _SubjectCatalogTeacherListState();
}

class _SubjectCatalogTeacherListState extends State<SubjectCatalogTeacherList> {
  List<Subject> _subjects = new List<Subject>();

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('subjects')
        .where("teacher", isEqualTo: widget.account.email)
        .snapshots()
        .listen((data) {
      List<Subject> subjects = new List<Subject>();
      data.documents.forEach((doc) {
        print(doc);

        print(doc["students"].runtimeType);

        Subject subject = new Subject(
            assist: doc["assist"],
            schedule: doc["schedule"],
            code: doc["code"],
            teacher: doc["teacher"],
            students: doc["students"],
            name: doc["name"],
            id: doc.documentID);
        subjects.add(subject);
      });
      setState(() {
        _subjects = subjects;
      });
    });
  }

// user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Imagen guardada correctamente"),
          content: new Icon(
            Icons.check,
            color: Colors.green,
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Asistencias'),
          // automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: (_subjects.length),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // return card(context, _subjects[index]);
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text(_subjects[index].name +
                          " - " +
                          _subjects[index].schedule),
                      // subtitle: Text("Código: " + _subjects[index].code),
                    ),
                    _subjects[index].students.length > 0
                        ? (ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (_subjects[index].students.length),
                            itemBuilder: (BuildContext context, int index2) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                                child: Text(
                                    _subjects[index].students[index2]["name"]+"   -   "+_subjects[index].students[index2]["assist"].toString()+" asistencia(s)"),
                              );
                            }))
                        : (Text(""))
                  ],
                ),
              );
            },
          ),
        ));
  }
}

// _subjects[index].students.forEach((element) {
//                              Text(element["name"]);
//                           })
Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar código de Asistencia'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Código de asistencia', hintText: '123456'),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(teamName);
            },
          ),
        ],
      );
    },
  );
}
