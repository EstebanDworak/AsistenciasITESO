import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Materias'),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: (_subjects.length),
            itemBuilder: (BuildContext context, int index) {
              // return card(context, _subjects[index]);
              return GestureDetector(
                onTap: () async {
                  final String currentTeam = await _asyncInputDialog(context);

                  if (currentTeam != null && currentTeam != "") {
                    final DocumentReference postRef = Firestore.instance
                        .document('subjects/' + _subjects[index].id);
                    Firestore.instance.runTransaction((Transaction tx) async {
                      DocumentSnapshot postSnapshot = await tx.get(postRef);
                      if (postSnapshot.exists) {
                        await tx.update(
                            postRef, <String, dynamic>{'code': currentTeam});
                      }
                    });
                  }
                },
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.book),
                        title: Text(_subjects[index].name +
                            " - " +
                            _subjects[index].schedule),
                        subtitle: Text("Código: " + _subjects[index].code),
                        trailing: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              );

              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text(_subjects[index].name +
                          " - " +
                          _subjects[index].schedule),
                      subtitle: Text("Código: " + _subjects[index].code),
                    ),
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
            child: Text('Cancelar', style: TextStyle(color:Colors.red),),
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
