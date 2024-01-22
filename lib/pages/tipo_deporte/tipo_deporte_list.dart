
import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';
import 'package:ficha_inscripcion/services/api_tipo_deporte.dart';
import 'package:ficha_inscripcion/pages/tipo_deporte/tipo_deporte_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class TipoDeporteList extends StatefulWidget {
  final bool getAll;
  final Key? key;

  const TipoDeporteList({this.key, this.getAll = false}) : super(key: key);

  @override
  _TipoDeporteListState createState() => _TipoDeporteListState();
}

class _TipoDeporteListState extends State<TipoDeporteList> {
  //List<TipoDeporte>.empty(growable: true);
  bool isApiCallProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Listado de Tipos de Deportes'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadTipoDeporte(widget.getAll),
      ),
    );    
  }

  Widget loadTipoDeporte(bool getAll) {
    return FutureBuilder(
      future: getAll ? APITipoDeporte.getAllTipoDeportes() : APITipoDeporte.getTipoDeporte(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<TipoDeporte>?> tipoDeporte,
      ) {
        if(tipoDeporte.hasData){
          return tipoDeporteList(tipoDeporte.data);

        }else{
          return const Center(child: CircularProgressIndicator());
        }}
      );
      
      
  }
  Widget tipoDeporteList(tipoDeporte) {
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
                          vertical: 10, horizontal: 10,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 18,
                      )
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/add-tipoDeporte');
                      
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Agregar TipoDeporte',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    widget.getAll ? Container() :  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/list-tipoDeporte', arguments: !widget.getAll);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 95, 163, 218),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10,),
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
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2.5),
                  2: FlexColumnWidth(6),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
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
                            'Nombre',
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
                            'Descripción',
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
                  ...tipoDeporte.map<TableRow>((tipoDeporte) {
                  return TableRow(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    children: TipoDeporteItem(
                        tipoDeporte: tipoDeporte,
                        onDelete: (TipoDeporte tipoDeporte) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          APITipoDeporte.deleteTipoDeporte(tipoDeporte.id!).then(
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
                itemCount: tipoDeporte.length,
                itemBuilder: (context, index) {
                  return SocioItem(
                    tipoDeporte: tipoDeporte[index],
                    onDelete: (TipoDeporte tipoDeporte) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      APITipoDeporte.deleteSocio(tipoDeporte.id!).then(
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