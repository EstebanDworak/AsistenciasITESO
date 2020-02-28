import 'package:asistencias/home.dart';
import 'package:asistencias/registration.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            TextField(
              decoration: InputDecoration(labelText: 'Nombre de usuario'),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Text('Cancelar'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(),
                      ),
                    );
                  },
                  child: Text('Siguiente'),
                ),
              ],
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
                Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => RegistrationPage(),
                      ),
                    );
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
