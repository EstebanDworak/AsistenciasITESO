// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;

import 'package:asistencias/models/Subject.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

void main() {
  runApp(
    MaterialApp(
      title: 'Google Sign In',
      home: SignInDemo(),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount _currentUser;
  String _contactText;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      if (account != null) {
        Firestore.instance
            .collection('admins')
            .where("email", isEqualTo: account.email)
            .snapshots()
            .listen((data) {
          print(data.documents.length);

          

          if (data.documents.length == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => StudentPage(
                  cb: _handleSignOut,
                ),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TeacherPage(
                  cb: _handleSignOut,
                  email: account.email,
                ),
              ),
            );
          }
        });
      }

      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {}
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.disconnect();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Text("You are not currently signed in."),
        RaisedButton(
          child: const Text('SIGN IN'),
          onPressed: _handleSignIn,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}

class StudentPage extends StatelessWidget {
  final Function cb;
  const StudentPage({Key key, this.cb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Page'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              Text("Teacher page"),
              RaisedButton(
                onPressed: () {
                  cb();
                  Navigator.of(context).pop();
                },
                child: Text("Logout"),
              )
            ],
          ),
        ));
  }
}

class TeacherPage extends StatefulWidget {
  final Function cb;
  final String email;
  const TeacherPage({Key key, this.cb, @required this.email}) : super(key: key);

  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  List<Subject> _subjects = new List<Subject>();

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('subjects')
        .where("teacher", isEqualTo: widget.email)
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
            name: doc["name"], id: doc.documentID);
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
          title: Text('Profesor - ' + widget.email),
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
                print("Current team name is $currentTeam");

                final DocumentReference postRef = Firestore.instance.document('subjects/'+_subjects[index].id);
                Firestore.instance.runTransaction((Transaction tx) async {
                  DocumentSnapshot postSnapshot = await tx.get(postRef);
                  if (postSnapshot.exists) {
                    await tx.update(postRef, <String, dynamic>{'code': currentTeam});
                  }
                });


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
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter current team'),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Team Name', hintText: 'eg. Juventus F.C.'),
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