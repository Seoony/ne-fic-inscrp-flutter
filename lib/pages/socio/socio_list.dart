
import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/services/api_socio.dart';
import 'package:ficha_inscripcion/pages/socio/socio_item.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class SocioList extends StatefulWidget {
  const SocioList({Key? key}) : super(key: key);

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
        child: loadSocios(),
      ),
    );    
  }

  Widget loadSocios() {
    return FutureBuilder(
      future: APISocio.getSocios(),
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
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-socio');
                  
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context, '/home'
                    );
                  
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  
                  child: const Text(
                    'Menu',
                    style: TextStyle(color: Colors.black, fontSize: 18,),
                  ),
                  ),
                ],
              ),
              ListView.builder(
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
              ),
            ],
          ),  
        ],
      ),
    );
  } 
}