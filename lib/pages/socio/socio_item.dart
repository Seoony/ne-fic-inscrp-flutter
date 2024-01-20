import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';

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
    return [
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.id}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.nombres}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.apellidos}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.dni}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            "${socio!.estado}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
                                Text("Nombres: ${socio!.nombres}"),
                                Text("Apellidos: ${socio!.apellidos}"),
                                Text("DNI: ${socio!.dni}"),
                                Text("Estado: ${socio!.estado}"),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Editar"),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                '/edit-socio',
                                arguments: {
                                  'socio': socio,
                                },
                              );
                            },
                          ),
                          TextButton(
                            child: Text(socio!.estado == "A" ? "Inactivar" : "Activar"),
                            onPressed: () {},
                          ),
                          TextButton(
                            child: const Text("Eliminar"),
                            onPressed: () {
                              onDelete!(socio);
                            },
                          ),
                          TextButton(
                            child: const Text("Cerrar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
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
