
import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/services/api_socio.dart';
import 'package:ficha_inscripcion/pages/socio/socio_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class SocioList extends StatefulWidget {
  final bool getAll;
  final Key? key;

  const SocioList({this.key, this.getAll = false}) : super(key: key);

  @override
  _SocioListState createState() => _SocioListState();
}

class _SocioListState extends State<SocioList> {
  //List<Socio>.empty(growable: true);
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Listado de Socios'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadSocios(widget.getAll),
      ),
    );    
  }

  Widget loadSocios(bool getAll) {
    return FutureBuilder(
      future: getAll ? APISocio.getAllSocios() : APISocio.getSocios(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Socio>?> socios,
      ) {
        if(socios.hasData){
          return sociosList(socios.data);

        }else{
          return const Center(child: CircularProgressIndicator());
        }}
      );
      
      
  }
  Widget sociosList(socios) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'INICIO',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-socio');
                      
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Agregar Socio',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    widget.getAll ? Container() :  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/list-socio', arguments: !widget.getAll);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 95, 163, 218),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        widget.getAll ? 'Ocultar Eliminados' : 'Mostrar TODOS',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(5),
                  2: FlexColumnWidth(5),
                  3: FlexColumnWidth(4),
                  4: FlexColumnWidth(2),
                  5: FlexColumnWidth(1.5),
                },
                children: [
                  const TableRow(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 94, 170),
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Id',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Nombres',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Apellidos',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'DNI',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'ER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ...socios.map<TableRow>((socio) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: SocioItem(
                        socio: socio,
                        onDelete: (Socio socio) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          APISocio.deleteSocio(socio.id!).then(
                            (response) {
                              setState(() {
                                isApiCallProcess = false;
                              });
                            }  
                          );
                        },
                      ).buildRow(context),
                  );
                }).toList(),
                ],
              )
              /*ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: socios.length,
                itemBuilder: (context, index) {
                  return SocioItem(
                    socio: socios[index],
                    onDelete: (Socio socio) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      APISocio.deleteSocio(socio.id!).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        }  
                      );
                    },
                  );
                },
              ),*/
            ],
          ),  
        ],
      ),
    );
  } 
}