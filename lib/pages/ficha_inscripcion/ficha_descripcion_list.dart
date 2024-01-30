import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/ficha_inscripcion.dart';
import 'package:ficha_inscripcion/services/api_ficha_inscripcion.dart';
import 'package:ficha_inscripcion/pages/ficha_inscripcion/ficha_inscripcion_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class FichaInscripcionList extends StatefulWidget {
  final bool getAll;
  final Key? key;

  const FichaInscripcionList({this.key, this.getAll = false}) : super(key: key);

  @override
  _FichaInscripcionListState createState() => _FichaInscripcionListState();
}

class _FichaInscripcionListState extends State<FichaInscripcionList> {
  //List<Socio>.empty(growable: true);
  bool isApiCallProcess = false;

  TextEditingController searchController = TextEditingController();
  List<FichaInscripcion> fichaInscripcion = [];
  List<FichaInscripcion> fichaInscripcionFiltered = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Listado de Ficha de Inscripción'),
        elevation: 0,
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        
                        hintText: 'Buscar',
                        fillColor: Colors.white,
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadFichaInscripcion(widget.getAll),
      ),
    );    
  }

  Widget loadFichaInscripcion(bool getAll) {
    return FutureBuilder(
      future: getAll ? APIFichaInscripcion.getAllFichaInscripcion() : APIFichaInscripcion.getFichaInscripcion(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<FichaInscripcion>?> fichaInscripcion,
      ) {
        if(fichaInscripcion.hasData){
          List<FichaInscripcion>? fichaInscripcionFiltered = fichaInscripcion.data;
          if (searchController.text.isNotEmpty) {
            fichaInscripcionFiltered = fichaInscripcionFiltered!.where((element) {
              return element.socio!.nombres!.toLowerCase().contains(searchController.text.toLowerCase()) ||
              element.socio!.apellidos!.toLowerCase().contains(searchController.text.toLowerCase()) ||
              element.tipo_deporte!.nombre!.toLowerCase().contains(searchController.text.toLowerCase()) ||
              element.fecha_inscripcion!.toLowerCase().contains(searchController.text.toLowerCase()) ||
              element.monto_inscripcion!.toString().toLowerCase().contains(searchController.text.toLowerCase()) ||
              element.estado!.toLowerCase().contains(searchController.text.toLowerCase());
            }).toList();
          }
          return fichaInscripcionList(fichaInscripcionFiltered);

        }else{
          return const Center(child: CircularProgressIndicator());
        }}
      );
      
      
  }
  Widget fichaInscripcionList(fichaInscripcion) {
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
                          vertical: 10, horizontal: 5,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-fichaInscripcion');
                      
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        '+ Ficha Inscripción',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    widget.getAll ? Container() :  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/list-fichaInscripcion', arguments: !widget.getAll);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 95, 163, 218),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5,),
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
                  1: FlexColumnWidth(6),
                  2: FlexColumnWidth(4),
                  3: FlexColumnWidth(4),
                  4: FlexColumnWidth(2.5),
                  5: FlexColumnWidth(1.5),
                  6: FlexColumnWidth(1.5),
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
                            'Socio',
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
                            'Tipo de Deporte',
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
                            'Fecha',
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
                            'Monto',
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
                  ...fichaInscripcion.map<TableRow>((fichaInscripcion) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: FichaInscripcionItem(
                        fichaInscripcion: fichaInscripcion,
                        onDelete: (FichaInscripcion fichaInscripcion) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          APIFichaInscripcion.deleteFichaInscripcion(fichaInscripcion.id!).then(
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
                itemCount: fichaInscripcion.length,
                itemBuilder: (context, index) {
                  return SocioItem(
                    fichaInscripcion: fichaInscripcion[index],
                    onDelete: (Socio fichaInscripcion) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      APIFichaInscripcion.deleteSocio(fichaInscripcion.id!).then(
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