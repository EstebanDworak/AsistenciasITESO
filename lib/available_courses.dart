import 'package:flutter/material.dart';

class AvailableCoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RollCall'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Título de materia ${index + 1}'),
                    subtitle: Text('Horario'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
