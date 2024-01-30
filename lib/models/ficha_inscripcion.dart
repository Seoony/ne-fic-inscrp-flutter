// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';

List<FichaInscripcion> fichaInscripcionFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FichaInscripcion>((json) => FichaInscripcion.fromJson(json))
      .toList();
}

class FichaInscripcion {
  int? id;
  Socio? socio;
  TipoDeporte? tipo_deporte;
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
    Socio? socio,
    TipoDeporte? tipo_deporte,
    String? fecha_inscripcion,
    double? monto_inscripcion,
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
      data['socio'] = socio!.toJson();
    }
    if (tipo_deporte != null){
      data['tipoDeporte'] = tipo_deporte!.toJson();
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
      socio: json['socio'] != null ? Socio.fromJson(json['socio']) : null,
      tipo_deporte: json['tipo_deporte'] != null ? TipoDeporte.fromJson(json['tipo_deporte']) : null,
      fecha_inscripcion: json['fecha_inscripcion'],
      monto_inscripcion: double.parse(json['monto_inscripcion']),
      estado: json['estado'],
    );
  }
}