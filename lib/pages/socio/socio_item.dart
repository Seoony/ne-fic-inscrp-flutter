import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/services/api_socio.dart';

class SocioItem extends StatelessWidget {
  final Socio? socio;
  final Function? onDelete;

  SocioItem({
    Key? key,
    this.socio,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  List<Widget> buildRow(BuildContext context) {
    TextStyle textStyle;
    if (socio!.estado == "I") {
      textStyle = const TextStyle(
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 59, 59, 59),
      );
    } else if (socio!.estado == "*") {
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
            "${socio!.id}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(latin1.encode("${socio!.nombres}")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            utf8.decode(latin1.encode("${socio!.apellidos}")),
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.dni}",
            style: textStyle,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.estado}",
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
                        title: const Text("Información de Socio"),
                        content: SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("ID: ${socio!.id}"),
                                Text("Nombres:${utf8.decode(latin1.encode("${socio!.nombres}"))}"),
                                Text("Apellidos: ${utf8.decode(latin1.encode("${socio!.apellidos}"))}"),
                                Text("DNI: ${socio!.dni}"),
                                Text("Estado: ${socio!.estado}"),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/edit-socio',
                                arguments: {
                                  'socio': socio,
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
                              if (socio!.estado == "A") {
                                response = await APISocio.deactivateSocio(socio!.id!);
                              } else {
                                response = await APISocio.activateSocio(socio!.id!);
                              }
                              if (response) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/list-socio',
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
                            child: Text(socio!.estado == "A" ? "Inactivar" : "Activar",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              onDelete!(socio);
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
                  "${socio!.id}",
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
                  "${socio!.nombres}",
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
                  "${socio!.apellidos}",
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
                  "${socio!.dni}",
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
                    '/socio-edit',
                    arguments: {
                      'socio': socio,
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
                  onDelete!(socio);
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
