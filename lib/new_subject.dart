import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:math';

class NewSubject extends StatefulWidget {
  final GoogleSignInAccount account;
  const NewSubject({Key key, this.account}) : super(key: key);

  @override
  _NewSubjectState createState() => _NewSubjectState();
}

class _NewSubjectState extends State<NewSubject> {
  String _name = null;
  String _schedule = null;
  final _random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alta de materias"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Nombre de la materia",
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    _name == null ? "Por definir" : _name,
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () async {
                      final String materia = await _asyncInputDialog(context,
                          "Nombre de la materia", "Lenguajes Formales");

                      if (materia != null && materia != "") {
                        setState(() {
                          _name = materia;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Horarios",
                    style: TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    _schedule == null ? "Por definir" : _schedule,
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                    onTap: () async {
                      final String schedule = await _asyncInputDialog(context,
                          "Fecha y hora", "Martes y Jueves 07:00 a 09:00");

                      if (schedule != null && schedule != "") {
                        setState(() {
                          _schedule = schedule;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: RaisedButton(
              onPressed: (_name == null || _schedule == null)
                  ? null
                  : () {
                    
                    Random rnd;
                    int min = 100000;
                    int max = 999999;
                    rnd = new Random();
                    int r = min + rnd.nextInt(max - min);


                      Firestore.instance
                          .collection('subjects')
                          .document()
                          .setData({
                        'name': _name,
                        'teacher': widget.account.email,
                        "code": r.toString(),
                        "schedule": _schedule
                      });

                      Navigator.of(context).pop();
                    },
              color: Colors.blue,
              child: Text(
                "Crear Materia",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<String> _asyncInputDialog(
    BuildContext context, String name, String hint) async {
  String teamName = '';
  return showDialog<String>(
    context: context,
    barrierDismissible:
        false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Ingresar: " + name),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(labelText: name, hintText: hint),
              onChanged: (value) {
                teamName = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
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
