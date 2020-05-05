import 'package:asistencias/subjects_asistencia.dart';
import 'package:asistencias/subjects_catalog_student.dart';
import 'package:asistencias/subjects_catalog_teacher.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'new_subject.dart';

class StudentPanel extends StatelessWidget {
  final GoogleSignInAccount account;
  const StudentPanel({Key key, @required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Panel de alumno"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "Bienvenido estudiante",
                        style: TextStyle(color: Colors.grey),
                      ),
                      subtitle: Text(
                        account.displayName,
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectCatalogStudent(
                              account: account,
                            )),
                  );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Inscribir cursos",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("Date de alta en nuevos cursos"),
                        trailing: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectAsistencia(
                              account: account,
                            )),
                  );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Tomar asistencia",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("¡Presente!"),
                        trailing: Icon(
                          Icons.list,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
