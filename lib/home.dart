import 'package:asistencias/available_courses.dart';
import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asistencias/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  HomePage({Key key, @required this.scaffoldkey}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Subject> subjects = new List<Subject>();

  @override
  Widget build(BuildContext context) {
    subjects.add(new Subject());

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print(state);
          if (state is HomeInitial) {
            print('no');
            BlocProvider.of<HomeBloc>(context).add(LoadConfigsEvent());
            return loading(context);
          }
          if (state is LoadedConfigsState) {
            subjects = state.subjects;
            print("hola");
            // _switchValue = state.configs["switch"];
            // _checkValue = state.configs["check"];
            // _sliderValue = state.configs["slider"];
            BlocProvider.of<HomeBloc>(context).add(LoadedConfigsEvent());
          }
          return buildScafold(context);
        },
      ),
    );
  }

  Scaffold loading(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RollCall'),
      ),
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  GestureDetector card(BuildContext context, Subject subject) {
    return GestureDetector(
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
              title: Text(subject.name),
              subtitle: Text(subject.schedule),
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
    );
  }

  Scaffold buildScafold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RollCall'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index) {
            return card(context, subjects[index]);
          },
        ),
      ),
      // body: SafeArea(
      //   child: ListView(
      //     children: <Widget>[
      //       Text(subjects[0].toString()),
      //       card(context, subjects[0]),
            
      //       GestureDetector(
      //         onTap: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return SimpleDialog(
      //                 children: <Widget>[
      //                   Center(
      //                     child: Column(
      //                       children: <Widget>[
      //                         IconButton(
      //                           icon: Icon(
      //                             Icons.done,
      //                             size: 30,
      //                           ),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                           color: Colors.green,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //         child: Card(
      //           color: Colors.green[100],
      //           child: Column(
      //             children: <Widget>[
      //               ListTile(
      //                 leading: Icon(Icons.book),
      //                 title: Text('Programación de dispositivos móviles'),
      //                 subtitle: Text('Martes y viernes de 7:00 a 9:00'),
      //               ),
      //               IconButton(
      //                 icon: Icon(Icons.calendar_today),
      //                 onPressed: () {
      //                   showDialog(
      //                     context: context,
      //                     builder: (BuildContext context) {
      //                       return SimpleDialog(
      //                         title: Text('Asistencia'),
      //                         children: <Widget>[
      //                           Text(
      //                             'Hasta ahora, tienes 0 faltas',
      //                             textAlign: TextAlign.center,
      //                           ),
      //                           SizedBox(
      //                             height: 20,
      //                           ),
      //                           FlatButton(
      //                             onPressed: () {
      //                               Navigator.of(context).pop();
      //                             },
      //                             child: Text('Regresar'),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return SimpleDialog(
      //                 children: <Widget>[
      //                   Center(
      //                     child: Column(
      //                       children: <Widget>[
      //                         IconButton(
      //                           icon: Icon(
      //                             Icons.done,
      //                             size: 30,
      //                           ),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                           color: Colors.green,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //         child: Card(
      //           color: Colors.orange[100],
      //           child: Column(
      //             children: <Widget>[
      //               ListTile(
      //                 leading: Icon(Icons.book),
      //                 title: Text('Diseño de software'),
      //                 subtitle: Text('Lunes y jueves de 7:00 a 9:00'),
      //               ),
      //               IconButton(
      //                 icon: Icon(Icons.calendar_today),
      //                 onPressed: () {
      //                   showDialog(
      //                     context: context,
      //                     builder: (BuildContext context) {
      //                       return SimpleDialog(
      //                         title: Text('Asistencia'),
      //                         children: <Widget>[
      //                           Text(
      //                             'Hasta ahora, tienes 2 faltas',
      //                             textAlign: TextAlign.center,
      //                           ),
      //                           SizedBox(
      //                             height: 20,
      //                           ),
      //                           FlatButton(
      //                             onPressed: () {
      //                               Navigator.of(context).pop();
      //                             },
      //                             child: Text('Regresar'),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return SimpleDialog(
      //                 children: <Widget>[
      //                   Center(
      //                     child: Column(
      //                       children: <Widget>[
      //                         IconButton(
      //                           icon: Icon(
      //                             Icons.done,
      //                             size: 30,
      //                           ),
      //                           onPressed: () {
      //                             Navigator.of(context).pop();
      //                           },
      //                           color: Colors.green,
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               );
      //             },
      //           );
      //         },
      //         child: Card(
      //           color: Colors.green[100],
      //           child: Column(
      //             children: <Widget>[
      //               ListTile(
      //                 leading: Icon(Icons.book),
      //                 title: Text('Desarrollo de aplicaciones y servicios web'),
      //                 subtitle: Text('Lunes y miércoles de 9:00 a 11:00'),
      //               ),
      //               IconButton(
      //                 icon: Icon(Icons.calendar_today),
      //                 onPressed: () {
      //                   showDialog(
      //                     context: context,
      //                     builder: (BuildContext context) {
      //                       return SimpleDialog(
      //                         title: Text('Asistencia'),
      //                         children: <Widget>[
      //                           Text(
      //                             'Hasta ahora, tienes 0 faltas',
      //                             textAlign: TextAlign.center,
      //                           ),
      //                           SizedBox(
      //                             height: 20,
      //                           ),
      //                           FlatButton(
      //                             onPressed: () {
      //                               Navigator.of(context).pop();
      //                             },
      //                             child: Text('Regresar'),
      //                           ),
      //                         ],
      //                       );
      //                     },
      //                   );
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 40,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           IconButton(
      //             icon: Icon(Icons.add_circle),
      //             onPressed: () {
      //               Navigator.of(context).push(
      //                 MaterialPageRoute(
      //                   builder: (BuildContext context) =>
      //                       AvailableCoursesPage(),
      //                 ),
      //               );
      //             },
      //             color: Colors.blue,
      //           ),
      //           Text('Alta y baja de materias'),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    
    );
  }
}
