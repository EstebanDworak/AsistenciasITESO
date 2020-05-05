// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert' show json;

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
                builder: (BuildContext context) => StudentPage(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => TeacherPage(cb: _handleSignOut,email: account.email,),
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
  const StudentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Page'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Text("Student Page"),
        ));
  }
}

class TeacherPage extends StatelessWidget {
  final Function cb;
  final String email;
  const TeacherPage({Key key, this.cb,@required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profesor - '+email),
          automaticallyImplyLeading: false,
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(children: <Widget>[Text("Teacher page"), RaisedButton(onPressed: (){
            cb();
            Navigator.of(context).pop();
          }, child: Text("Logout"),)],),
        ));
  }
}
