// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

//import 'package:ficha_inscripcion/models/socio.dart';
//import 'package:ficha_inscripcion/models/tipo_deporte.dart';

List<FichaInscripcion> fichaInscripcionFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FichaInscripcion>((json) => FichaInscripcion.fromJson(json))
      .toList();
}

class FichaInscripcion {
  int? id;
  int? socio;
  int? tipo_deporte;
  String? fecha_inscripcion;
  double? monto_inscripcion;
  String? estado;

  FichaInscripcion({
    this.id,
    this.socio,
    this.tipo_deporte,
    this.fecha_inscripcion,
    this.monto_inscripcion,
    this.estado,
  });

  FichaInscripcion copyWith({
    int? id,
    int? socio,
    int? tipoDeporte,
    String? fechaInscripcion,
    double? monto,
    String? estado,
  }) {
    return FichaInscripcion(
      id: id ?? this.id,
      socio: socio ?? this.socio,
      tipo_deporte: tipo_deporte ?? this.tipo_deporte,
      fecha_inscripcion: fecha_inscripcion ?? this.fecha_inscripcion,
      monto_inscripcion: monto_inscripcion ?? this.monto_inscripcion,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (socio != null){
      data['socio'] = socio;
    }
    if (tipo_deporte != null){
      data['tipoDeporte'] = tipo_deporte;
    }
    if (fecha_inscripcion != null){
      data['fechaInscripcion'] = fecha_inscripcion;
    }
    if (monto_inscripcion != null){
      data['monto'] = monto_inscripcion;
    }
    if (estado != null) {
      data['estado'] = "A";
    }
    return data;
  }
  
  factory FichaInscripcion.fromJson(Map<String, dynamic> json) {
    return FichaInscripcion(
      id: json['id'] as int?,
      socio: json['socio'] as int?,
      tipo_deporte: json['tipo_deporte'] as int?,
      fecha_inscripcion: json['fecha_inscripcion'],
      monto_inscripcion: double.parse(json['monto_inscripcion']),
      estado: json['estado'],
    );
  }
}