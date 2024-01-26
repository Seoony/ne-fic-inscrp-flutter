import 'package:ficha_inscripcion/pages/ficha_inscripcion/ficha_descripcion_list.dart';
import 'package:ficha_inscripcion/pages/ficha_inscripcion/ficha_inscripcion_add_edit.dart';
import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/menu.dart';

import 'package:ficha_inscripcion/pages/socio/socio_add_edit.dart';
import 'package:ficha_inscripcion/pages/socio/socio_list.dart';

import 'package:ficha_inscripcion/pages/tipo_deporte/tipo_deporte_list.dart';
import 'package:ficha_inscripcion/pages/tipo_deporte/tipo_deporte_add_edit.dart';

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
          case '/home':
            return MaterialPageRoute(builder: (context) => Menu());

          case '/add-socio':
            return MaterialPageRoute(builder: (context) => const SocioAddEdit());
          case '/edit-socio':
            final args = settings.arguments as Map<String, dynamic>;
            final socio = args['socio'];
            return MaterialPageRoute(builder: (context) => SocioAddEdit(socio: socio));
          case '/list-socio':
            final getAll = settings.arguments as bool? ?? false;
            return MaterialPageRoute(builder: (context) => SocioList(getAll: getAll));

          case '/add-tipoDeporte':
            return MaterialPageRoute(builder: (context) => const TipoDeporteAddEdit());
          case '/edit-tipoDeporte':
            final args = settings.arguments as Map<String, dynamic>;
            final tipoDeporte = args['tipoDeporte'];
            return MaterialPageRoute(builder: (context) => TipoDeporteAddEdit(tipoDeporte: tipoDeporte));
          case '/list-tipoDeporte':
            final getAll = settings.arguments as bool? ?? false;
            return MaterialPageRoute(builder: (context) => TipoDeporteList(getAll: getAll));

          case '/add-fichaInscripcion':
            return MaterialPageRoute(builder: (context) => const FichInscripcionAddEdit());
          case '/edit-fichaInscripcion':
            final args = settings.arguments as Map<String, dynamic>;
            final fichaInscripcion = args['fichaInscripcion'];
            return MaterialPageRoute(builder: (context) => FichInscripcionAddEdit(fichaInscripcion: fichaInscripcion));
          case '/list-fichaInscripcion':
            final getAll = settings.arguments as bool? ?? false;
            return MaterialPageRoute(builder: (context) => FichaInscripcionList(getAll: getAll));
          
          default:
            return MaterialPageRoute(builder: (context) => Menu());
        }
      },
    );
  }
}