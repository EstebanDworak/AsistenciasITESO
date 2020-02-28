import 'package:asistencias/available_courses.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RollCall'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.done,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Colors.green[100],
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Programación de dispositivos móviles'),
                      subtitle: Text('Martes y viernes de 7:00 a 9:00'),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('Asistencia'),
                              children: <Widget>[
                                Text(
                                  'Hasta ahora, tienes 0 faltas',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Regresar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.done,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Colors.orange[100],
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Diseño de software'),
                      subtitle: Text('Lunes y jueves de 7:00 a 9:00'),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('Asistencia'),
                              children: <Widget>[
                                Text(
                                  'Hasta ahora, tienes 2 faltas',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Regresar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.done,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Colors.green[100],
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Desarrollo de aplicaciones y servicios web'),
                      subtitle: Text('Lunes y miércoles de 9:00 a 11:00'),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Text('Asistencia'),
                              children: <Widget>[
                                Text(
                                  'Hasta ahora, tienes 0 faltas',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Regresar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AvailableCoursesPage(),
                      ),
                    );
                  },
                  color: Colors.blue,
                ),
                Text('Alta y baja de materias'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
