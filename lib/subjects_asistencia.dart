import 'dart:math';

import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SubjectAsistencia extends StatefulWidget {
  // final Function cb;
  // final String email;
  final GoogleSignInAccount account;

  const SubjectAsistencia({Key key, @required this.account}) : super(key: key);

  @override
  _SubjectAsistenciaState createState() => _SubjectAsistenciaState();
}

class _SubjectAsistenciaState extends State<SubjectAsistencia> {
  List<Subject> _subjects = new List<Subject>();

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('subjects').snapshots().listen((data) {
      List<Subject> subjects = new List<Subject>();
      data.documents.forEach((doc) {
        print(doc);

        int a = 0;
        if (doc["students"] != null) {
          for (var i = 0; i < doc["students"].length; i++) {
            if (doc["students"][i]["email"] == widget.account.email) {
              a = doc["students"][i]["assist"];
            }
          }
        }

        Subject subject = new Subject(
            assist: a,
            schedule: doc["schedule"],
            code: doc["code"],
            teacher: doc["teacher"],
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
          title: new Text("¡Asistencia tomada correctamente!"),
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

// user defined function
  void _showDialogError() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("¡Código incorrecto!"),
          content: new Icon(
            Icons.cancel,
            color: Colors.red,
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
          title: Text('Materias'),
          // automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: (_subjects.length),
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
                        subtitle: Text("Asistencias: " +
                            _subjects[index].assist.toString()),
                        trailing: GestureDetector(
                          onTap: () async {
                            final String code =
                                await _asyncInputDialog(context);
                            if (code != null && code != "") {
                              if (code == _subjects[index].code) {
                                Firestore.instance
                                    .collection('subjects')
                                    .document(_subjects[index].id)
                                    .get()
                                    .then((DocumentSnapshot ds) {
                                  // use ds as a snapshot
                                  print(ds);

                                  var newStudents = <String, dynamic>{
                                    "list": []
                                  };

                                  if (ds.data["students"] != null) {
                                    for (var i = 0;
                                        i < ds.data["students"].length;
                                        i++) {
                                      if (ds.data["students"][i]["email"] ==
                                          widget.account.email) {
                                        newStudents["list"].add({
                                          "email": ds.data["students"][i]
                                              ["email"],
                                          "assist": ds.data["students"][i]
                                                  ["assist"] +
                                              1
                                        });
                                      }else{

                                      newStudents["list"].add({
                                        "email": ds.data["students"][i]
                                            ["email"],
                                        "assist": ds.data["students"][i]
                                            ["assist"]
                                      });
                                      }
                                    }
                                  }

                                  final DocumentReference postRef =
                                      Firestore.instance.document(
                                          'subjects/' + _subjects[index].id);

                                  Firestore.instance
                                      .runTransaction((Transaction tx) async {
                                    DocumentSnapshot postSnapshot =
                                        await tx.get(postRef);
                                    if (postSnapshot.exists) {
                                      await tx.update(
                                          postRef, <String, dynamic>{
                                        'students': newStudents["list"]
                                      });
                                    }
                                  });

                                  _showDialog();
                                  Navigator.of(context).pop(null);
                                });
                              } else {
                                _showDialogError();
                              }
                            }
                          },
                          child: Icon(Icons.list),
                        )),
                  ],
                ),
              );
            },
          ),
        ));
  }
}

Future<String> _asyncInputDialog(BuildContext context) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Ingresar código de Asistencia'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Código de asistencia', hintText: 'XXXXXX'),
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
