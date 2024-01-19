import 'dart:convert';
import 'package:flutter/material.dart';
import'package:http/http.dart' as http;
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
    );
  }
}