import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/ficha_inscripcion.dart';
import 'package:ficha_inscripcion/services/api_ficha_inscripcion.dart';

class FichaInscripcionItem extends StatelessWidget {
  final FichaInscripcion? fichaInscripcion;
  final Function? onDelete;

  FichaInscripcionItem({
    Key? key,
    this.fichaInscripcion,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  List<Widget> buildRow(BuildContext context) {
    TextStyle textStyle;
    if (fichaInscripcion!.estado == "I") {
      textStyle = const TextStyle(
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 59, 59, 59),
      );
    } else if (fichaInscripcion!.estado == "*") {
      textStyle = const TextStyle(
        decoration: TextDecoration.lineThrough,
        color: Colors.grey,
      );
    } else {
      textStyle = const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
    }
    return [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${fichaInscripcion!.id}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(latin1.encode("${fichaInscripcion!.socio}")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(latin1.encode("${fichaInscripcion!.tipo_deporte}")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${fichaInscripcion!.fecha_inscripcion}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${fichaInscripcion!.monto_inscripcion}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${fichaInscripcion!.estado}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
                child: const Icon(
                  Icons.visibility,
                  color: Colors.blue,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Información de FichaInscripcion"),
                        content: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("ID: ${fichaInscripcion!.id}"),
                                Text("Socio: ${utf8.decode(latin1.encode("${fichaInscripcion!.socio}"))}"),
                                Text("TipoDeporte: ${utf8.decode(latin1.encode("${fichaInscripcion!.tipo_deporte}"))}"),
                                Text("Fecha: ${fichaInscripcion!.fecha_inscripcion}"),
                                Text("Monto: ${fichaInscripcion!.monto_inscripcion}"),
                                Text("Estado: ${fichaInscripcion!.estado}"),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/edit-fichaInscripcion',
                                arguments: {
                                  'fichaInscripcion': fichaInscripcion,
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade200),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )
                              )
                            ),
                            child: const Text("Editar",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              bool response;
                              if (fichaInscripcion!.estado == "A") {
                                response = await APIFichaInscripcion.deactivateFichaInscripcion(fichaInscripcion!.id!);
                              } else {
                                response = await APIFichaInscripcion.activateFichaInscripcion(fichaInscripcion!.id!);
                              }
                              if (response) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/list-fichaInscripcion',
                                  (route) => false,
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow.shade600),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )
                              )
                            ),
                            child: Text(fichaInscripcion!.estado == "A" ? "Inactivar" : "Activar",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete!(fichaInscripcion);
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade300),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )
                              )
                            ),
                            child: const Text(
                              "Eliminar",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade300),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )
                              )
                            ),
                            child: const Text(
                              "Cerrar",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  );
                },
              )
            
        ),
    ];
  }
    

  /*Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: cartItem(context),
        ));
  }*/

  /*Widget cartItem(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 20,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 10,
                alignment: Alignment.center,
                child: Text(
                  "${fichaInscripcion!.id}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 2,
              ),
              Container(
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  "${fichaInscripcion!.nombres}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 2,
              ),
              Container(
                width: 100,
                alignment: Alignment.center,
                child: Text(
                  "${fichaInscripcion!.apellidos}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 2,
              ),
              Container(
                width: 68,
                alignment: Alignment.center,
                child: Text(
                  "${fichaInscripcion!.dni}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
                width: 2,
              ),
              GestureDetector(
                child: const Icon(Icons.edit),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/fichaInscripcion-edit',
                    arguments: {
                      'fichaInscripcion': fichaInscripcion,
                    },
                  );
                },
              ),
              GestureDetector(
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  onDelete!(fichaInscripcion);
                },
              ),
              /*Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [],
                      ),
                    )
                  ],
                ),
              )*/
            ]),
      ),
    );
  }*/
}
