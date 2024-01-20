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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    if (nombres != null){
      data['nombres'] = nombres;
    }
    if (apellidos != null){
      data['apellidos'] = apellidos;
    }
    if (dni != null){
      data['dni'] = dni;
    }
    data['dni'] = dni;
    if (estado != null) {
      data['estado'] = "A";
    }
    return data;
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