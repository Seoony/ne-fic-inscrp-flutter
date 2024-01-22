import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';
import 'package:ficha_inscripcion/services/api_tipo_deporte.dart';

class TipoDeporteItem extends StatelessWidget {
  final TipoDeporte? tipoDeporte;
  final Function? onDelete;

  TipoDeporteItem({
    Key? key,
    this.tipoDeporte,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  List<Widget> buildRow(BuildContext context) {
    TextStyle textStyle;
    if (tipoDeporte!.estado == "I") {
      textStyle = const TextStyle(
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 59, 59, 59),
      );
    } else if (tipoDeporte!.estado == "*") {
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
            "${tipoDeporte!.id}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(latin1.encode("${tipoDeporte!.nombre}")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(
              latin1.encode(
                "${tipoDeporte!.descripcion!.length <= 80 ? tipoDeporte!.descripcion :(tipoDeporte!.descripcion)?.substring(0, 77)} ...")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${tipoDeporte!.estado}",
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
                        title: const Text("Información de TipoDeporte"),
                        content: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("ID: ${tipoDeporte!.id}"),
                                Text("Nombre: ${utf8.decode(latin1.encode("${tipoDeporte!.nombre}"))}"),
                                Text("Descripción: ${utf8.decode(latin1.encode("${tipoDeporte!.descripcion}"))}"),
                                Text("Estado: ${tipoDeporte!.estado}"),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/edit-tipoDeporte',
                                arguments: {
                                  'TipoDeporte': tipoDeporte,
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
                              if (tipoDeporte!.estado == "A") {
                                response = await APITipoDeporte.deactivateTipoDeporte(tipoDeporte!.id!);
                              } else {
                                response = await APITipoDeporte.activateTipoDeporte(tipoDeporte!.id!);
                              }
                              if (response) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/list-tipoDeporte',
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
                            child: Text(tipoDeporte!.estado == "A" ? "Inactivar" : "Activar",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete!(tipoDeporte);
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
                  "${TipoDeporte!.id}",
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
                  "${TipoDeporte!.nombres}",
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
                  "${TipoDeporte!.apellidos}",
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
                  "${TipoDeporte!.dni}",
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
                    '/TipoDeporte-edit',
                    arguments: {
                      'TipoDeporte': TipoDeporte,
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
                  onDelete!(TipoDeporte);
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
