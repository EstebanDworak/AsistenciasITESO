// import 'package:flutter/material.dart';

// class AvailableCoursesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('RollCall'),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: 5,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               child: Column(
//                 children: <Widget>[
//                   ListTile(
//                     leading: Icon(Icons.book),
//                     title: Text('Título de materia ${index + 1}'),
//                     subtitle: Text('Horario'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:asistencias/available_courses.dart';
import 'package:asistencias/models/Subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asistencias/bloc/home_bloc.dart';

class AvailableCoursesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  AvailableCoursesPage({Key key, @required this.scaffoldkey}) : super(key: key);

  @override
  _AvailableCoursesPageState createState() => _AvailableCoursesPageState();
}

class _AvailableCoursesPageState extends State<AvailableCoursesPage> {
  List<Subject> subjects = new List<Subject>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial && subjects.length == 0) {
            BlocProvider.of<HomeBloc>(context).add(LoadNewSubjectsEvent());
            return loading(context);
          }
          
          if (state is LoadedNewSubectsState) {
            subjects = state.newSubjects;

            BlocProvider.of<HomeBloc>(context).add(LoadedNewSubjectsEvent());
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
              BlocProvider.of<HomeBloc>(context).add(AddSubectEvent(newSubject: subject));

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Text('Materia agregada con éxito.'),
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
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text(subject.name),
                    subtitle: Text(subject.schedule),
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
          itemCount: (subjects.length),
          itemBuilder: (BuildContext context, int index) {
            return card(context, subjects[index]);
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text(subjects[index].name),
                    subtitle: Text(subjects[index].schedule),
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
