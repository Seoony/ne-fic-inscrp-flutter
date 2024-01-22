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
  TipoDeporte? tipoDeporte;
  String? fechaInscripcion;
  double? monto;
  String? estado;

  FichaInscripcion({
    this.id,
    this.socio,
    this.tipoDeporte,
    this.fechaInscripcion,
    this.monto,
    this.estado,
  });

  FichaInscripcion copyWith({
    int? id,
    Socio? socio,
    TipoDeporte? tipoDeporte,
    String? fechaInscripcion,
    double? monto,
    String? estado,
  }) {
    return FichaInscripcion(
      id: id ?? this.id,
      socio: socio ?? this.socio,
      tipoDeporte: tipoDeporte ?? this.tipoDeporte,
      fechaInscripcion: fechaInscripcion ?? this.fechaInscripcion,
      monto: monto ?? this.monto,
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
    if (tipoDeporte != null){
      data['tipoDeporte'] = tipoDeporte!.toJson();
    }
    if (fechaInscripcion != null){
      data['fechaInscripcion'] = fechaInscripcion;
    }
    if (monto != null){
      data['monto'] = monto;
    }
    if (estado != null) {
      data['estado'] = "A";
    }
    return data;
  }
  
  static fromJson(json) {
    return FichaInscripcion(
      id: json['id'] as int?,
      socio: json['socio'] != null ? Socio.fromJson(json['socio']) : null,
      tipoDeporte: json['tipoDeporte'] != null ? TipoDeporte.fromJson(json['tipoDeporte']) : null,
      fechaInscripcion: json['fechaInscripcion'],
      monto: json['monto'],
      estado: json['estado'],
    );
  }
}