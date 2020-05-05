import 'dart:math';

import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gallery_saver/gallery_saver.dart';

class SubjectCatalogTeacher extends StatefulWidget {
  // final Function cb;
  // final String email;
  final GoogleSignInAccount account;

  const SubjectCatalogTeacher({Key key, @required this.account})
      : super(key: key);

  @override
  _SubjectCatalogTeacherState createState() => _SubjectCatalogTeacherState();
}

class _SubjectCatalogTeacherState extends State<SubjectCatalogTeacher> {
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
        Subject subject = new Subject(
            assist: doc["assist"],
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
          title: Text('Editar Materias'),
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
                        subtitle: Text("Código: " + _subjects[index].code),
                        trailing: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                // final String currentTeam =
                                //     await _asyncInputDialog(context);
                                String currentTeam = "";

                                Random rnd = new Random();
                                int min = 100000, max = 999999;
                                currentTeam =
                                    (min + rnd.nextInt(max - min)).toString();

                                if (currentTeam != null && currentTeam != "") {
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
                                        'code': currentTeam,
                                        'students':[{"email":"ecdcatemaco@gmail.com", "assist": 0}]
                                      });
                                    }
                                  });
                                
                                }
                              },
                              child: Icon(Icons.refresh),
                            ),
                            GestureDetector(
                              onTap: () async {
                                GallerySaver.saveImage(
                                        "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" +
                                            _subjects[index].code +
                                            ".jpg")
                                    .then((bool success) {
                                  _showDialog();
                                });
                              },
                              child: Icon(Icons.image),
                            )
                          ],
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
