import 'dart:convert';

class Socio {
  int id;
  String nombres;
  String apellidos;
  String dni;
  String estado;

  Socio({
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.dni,
    required this.estado,
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
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'dni': dni,
      'estado': estado,
    };
  }
}