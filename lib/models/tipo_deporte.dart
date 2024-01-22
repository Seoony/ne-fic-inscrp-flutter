import 'dart:convert';

List<TipoDeporte> tipoDeporteFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<TipoDeporte>((json) => TipoDeporte.fromJson(json))
      .toList();
}

class TipoDeporte {
  int? id;
  String? nombre;
  String? descripcion;
  String? estado;

  TipoDeporte({
    this.id,
    this.nombre,
    this.descripcion,
    this.estado,
  });
  TipoDeporte copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? estado,
  }) {
    return TipoDeporte(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (nombre != null){
      data['nombre'] = nombre;
    }
    if (descripcion != null){
      data['descripcion'] = descripcion;
    }
    if (estado != null) {
      data['estado'] = "A";
    }
    return data;
  }

  factory TipoDeporte.fromJson(Map<String, dynamic> json) {
    return TipoDeporte(
      id: json['id'] as int?,
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
      estado: json['estado'] as String?,
    );
  }
}