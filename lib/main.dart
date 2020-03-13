import 'package:asistencias/app.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';

// void main() => runApp(RollCallApp());

void main() async {
  // inicializar antes de crear app
  WidgetsFlutterBinding.ensureInitialized();
  // acceso al local storage
  // inicializar hive
  // abrir una caja
  runApp(RollCallApp());
}