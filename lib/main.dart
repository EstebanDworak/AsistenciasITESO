// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;
import 'dart:typed_data';
import 'dart:ui';

import 'package:asistencias/models/Subject.dart';
import 'package:asistencias/student_panel.dart';
import 'package:asistencias/teacher_panel.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:gallery_saver/gallery_saver.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
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

  _navigateAndDisplaySelection(BuildContext context, GoogleSignInAccount account) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudentPanel(
                account: account,
              )),
    );

    _handleSignOut();
  }

  _navigateAndDisplaySelection2(
      BuildContext context, GoogleSignInAccount account) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TeacherPanel(
                // cb: _handleSignOut,email: email,
                account: account,
              )),
    );

    _handleSignOut();
  }

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
            _navigateAndDisplaySelection(context, account);
          } else {
            _navigateAndDisplaySelection2(context, account);
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(
              height: 110,
            ),
            Icon(
              Icons.edit,
              color: Colors.teal[200],
              size: 60.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'RollCall',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 40,
                color: Colors.teal[300],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Iniciar sesión con Google'),
              ),
              onPressed: _handleSignIn,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '¿No tienes una cuenta aún?',
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () {
                _handleSignIn();
              },
              child: Text(
                '¡Regístrate aquí!',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
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
