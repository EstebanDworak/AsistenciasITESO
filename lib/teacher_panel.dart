import 'package:asistencias/subjects_catalog_teacher.dart';
import 'package:asistencias/subjects_catalog_teacher_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'new_subject.dart';

class TeacherPanel extends StatelessWidget {
  final GoogleSignInAccount account;
  const TeacherPanel({Key key, @required this.account}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Panel de profesor"),
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
                        "Bienvenido profesor",
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
                        builder: (context) => NewSubject(
                              account: account,
                            )),
                  );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Alta de materias",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("Agrega nuevas materias"),
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
                        builder: (context) => SubjectCatalogTeacher(
                              account: account,
                            )),
                  );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Editar Materias",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("Editar códigos de asistencias"),
                        trailing: Icon(
                          Icons.edit,
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
                        builder: (context) => SubjectCatalogTeacherList(
                              account: account,
                            )),
                  );
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          "Asistencias",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text("Asistencias por clase"),
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
