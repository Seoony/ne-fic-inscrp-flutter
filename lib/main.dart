import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/socio.dart';
import 'dart:convert';
import 'package:ficha_inscripcion/config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Listado de Socios'),
        ),
        body: FutureBuilder<List<Socio>>(
          future: fetchSocios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Socio> socios = snapshot.data!;

              return ListView.builder(
                itemCount: socios.length,
                itemBuilder: (context, index) {
                  Socio socio = socios[index];
                  return ListTile(
                    title: Text(socio.nombres??""),
                    subtitle: Text(socio.apellidos??""),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
  Future<List<Socio>> fetchSocios() async {
    // Lógica para obtener la lista de socios desde el backend (Django)
    // Puedes usar http, dio u otro paquete para realizar la solicitud HTTP.

    // Ejemplo con http:
    final response = await http.get(Uri.parse(Config.API_URL+Config.sociosApi));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((model) => Socio.fromJson(model)).toList();
    } else {
      throw Exception('Error al cargar la lista de socios');
    }
  }
}