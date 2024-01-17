import 'dart:convert';

List<Socio> socioFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<Socio>((json) => Socio.fromJson(json))
      .toList();
}
class Socio {
  int? id;
  String? nombres;
  String? apellidos;
  String? dni;
  String? estado;

  Socio({
    this.id,
    this.nombres,
    this.apellidos,
    this.dni,
    this.estado,
  });
  Socio copyWith({
    int? id,
    String? nombres,
    String? apellidos,
    String? dni,
    String? estado,
  }) {
    return Socio(
      id: id ?? this.id,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      dni: dni ?? this.dni,
      estado: estado ?? this.estado,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'estado': estado,
    };
  }

  factory Socio.fromJson(Map<String, dynamic> json) {
    return Socio(
      id: json['id'] as int?,
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      dni: json['dni'],
      estado: json['estado'],
    );
  }

}