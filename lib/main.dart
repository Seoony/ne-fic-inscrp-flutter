import 'dart:convert';
import 'package:ficha_inscripcion/pages/socio/socio_add_edit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ficha_inscripcion/menu.dart';
import 'package:ficha_inscripcion/pages/socio/socio_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'Ficha de Inscripcion';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Menu(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/add-socio':
            return MaterialPageRoute(builder: (context) => const SocioAddEdit());
          case '/edit-socio':
            return MaterialPageRoute(builder: (context) => const SocioAddEdit());
          case '/list-socio':
            final getAll = settings.arguments as bool? ?? false;
            return MaterialPageRoute(builder: (context) => SocioList(getAll: getAll));
          case '/home':
            return MaterialPageRoute(builder: (context) => Menu());
          default:
            return MaterialPageRoute(builder: (context) => Menu());
        }
      },
    );
  }
}