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
  Widget build(BuildContext context){
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
      )
    );
  }

  Widget cartItem(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),

        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${socio!.nombres} ${socio!.apellidos}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.edit),
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
                        color: Colors.red,),
                      onTap: () {
                        onDelete!(socio);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ]
    );
  }
}