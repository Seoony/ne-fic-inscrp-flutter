import 'dart:convert';

import 'package:ficha_inscripcion/services/api_socio.dart';
import 'package:ficha_inscripcion/services/api_tipo_deporte.dart';
import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/ficha_inscripcion.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';
import 'package:ficha_inscripcion/services/api_ficha_inscripcion.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
//import 'package:snippet_coder_utils/hex_color.dart';

class FichInscripcionAddEdit extends StatefulWidget {
  final FichaInscripcion? fichaInscripcion;
  const FichInscripcionAddEdit({Key? key, this.fichaInscripcion}) : super(key: key);

  @override
  _FichaInscripcionAddEditState createState() => _FichaInscripcionAddEditState();
}

class _FichaInscripcionAddEditState extends State<FichInscripcionAddEdit> {
  FichaInscripcion? fichaInscripcion;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario de Ficha de Inscripcion"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: fichaInscripcionForm(),
          ),
        ),
      ), 
     );
  }

  @override
  void initState() {
    super.initState();
    globalFormKey = GlobalKey<FormState>();
    fichaInscripcion = widget.fichaInscripcion ?? FichaInscripcion();

    Future.delayed(Duration.zero, () {
      if(fichaInscripcion?.id != null) {
        //final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        //fichaInscripcion = arguments['fichaInscripcion'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget fichaInscripcionForm() {
    return FutureBuilder<List<Socio>?>(
      future: APISocio.getSimplifiedSocios(),
      builder: (BuildContext context, AsyncSnapshot<List<Socio>?> socioSnapshot) {
        if (socioSnapshot.hasData){
          return FutureBuilder<List<TipoDeporte>?>(
            future: APITipoDeporte.getSimplifiedTipoDeporte(),
            builder: (BuildContext context, AsyncSnapshot<List<TipoDeporte>?> tipoDeporteSnapshot) {
              if (tipoDeporteSnapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: DropdownButtonFormField<int>(
                          value: fichaInscripcion!.socio?.id,
                          items: socioSnapshot.data!.map((Socio socio) {
                            return DropdownMenuItem<int>(
                              value: socio.id,
                              child: Text(
                                utf8.decode(latin1.encode(socio.nombres ?? ''))),
                            );
                          }).toList(), onChanged: (int? newvalue) {
                            setState(() {
                              fichaInscripcion!.socio = socioSnapshot.data!.firstWhere((Socio socio) => socio.id == newvalue);
                            });
                          },
                          validator: (int? value) {
                            if (value == null) {
                              return 'Selecione el Socio';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Socio",
                            hintText: "Seleccione un Socio",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: DropdownButtonFormField<int>(
                          value: fichaInscripcion!.tipo_deporte?.id,
                          items: tipoDeporteSnapshot.data!.map((TipoDeporte tipoDeporte) {
                            return DropdownMenuItem<int>(
                              value: tipoDeporte.id,
                              child: Text(
                                utf8.decode(latin1.encode(tipoDeporte.nombre ?? ''))),
                            );
                          }).toList(), onChanged: (int? newvalue) {
                            setState(() {
                              fichaInscripcion!.tipo_deporte = tipoDeporteSnapshot.data!.firstWhere((TipoDeporte tipoDeporte) => tipoDeporte.id == newvalue);
                            });
                          },
                          validator: (int? value) {
                            if (value == null) {
                              return 'Selecione el Tipo de Deporte';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Tipo Deporte",
                            hintText: "Seleccione un Tipo de Deporte",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 10,
                        ),
                        child: TextFormField(
                          initialValue: fichaInscripcion?.monto_inscripcion?.toString(),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (String? newvalue) {
                            setState(() {
                              fichaInscripcion?.monto_inscripcion = double.parse(newvalue ?? '0');
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Ingrese el monto';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "Monto Inscripcion",
                            hintText: "Ingrese el monto de la inscripcion",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if(validateAndSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              APIFichaInscripcion.saveFichaInscripcion(
                                fichaInscripcion!,
                                isEditMode,
                                ).then((response) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  if(response){
                                    Navigator.pushNamed(
                                      context,
                                      '/list-fichaInscripcion',                          
                                    );
                                  } else {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      "Negocios Electronicos",
                                      "Error al guardar el fichaInscripcion",
                                      "Ok",
                                      () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  }
                                },
                              );       
                            }
                          },
                          child: const Text('Guardar'),
                        )
                      )
                    ],
                  ),
                );
              }else if (tipoDeporteSnapshot.hasError) {
                return Text('${tipoDeporteSnapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          );
        } else if (socioSnapshot.hasError) {
          return Text('${socioSnapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  /*Widget fichaIncripcionForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "FichaInscripcion Socio",
              "Socio de FichaInscripcion",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Selecione el Socio';
                }
                return null;
              },
              (onSavedVal) =>{
                fichaInscripcion!.socio = onSavedVal,
              },
              initialValue: fichaInscripcion?.socio ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "FichaInscripcion Last Name",
              "Apellidos del FichaInscripcion",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese los apellidos';
                }
                return null;
              },
              (onSavedVal) =>{
                fichaInscripcion!.apellidos = onSavedVal,
              },
              initialValue: fichaInscripcion?.apellidos ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "FichaInscripcion DNI",
              "DNI del FichaInscripcion",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null || onValidateVal.length != 8) {
                  return 'Ingrese el DNI, recuerde que son 8 digitos.';
                }
                return null;
              },
              (onSavedVal) =>{
                fichaInscripcion!.dni = onSavedVal,
              },
              initialValue: fichaInscripcion?.dni ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              children: [
                FormHelper.submitButton(
                  "Guardar",
                  () {
                    if(validateAndSave()) {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      APIfichaIncripcion.savefichaIncripcion(
                        fichaInscripcion!,
                        isEditMode,
                        ).then((response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if(response){
                            Navigator.pushNamed(
                              context,
                              '/list-fichaInscripcion',                          
                            );
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Negocios Electronicos",
                              "Error al guardar el fichaInscripcion",
                              "Ok",
                              () {
                                Navigator.of(context).pop();
                              },
                            );
                          }
                        },
                      );       
                    }
                  },
                  btnColor: HexColor("#00B0F0"),
                  borderColor: Colors.white,
                  txtColor: Colors.white,
                  borderRadius: 10,                
                ),
                ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if(isEditMode){
                          Navigator.of(context).pop();
                        }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 243, 100, 33),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(150, 58),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }*/

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if(form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  isValidURL(String url) {
    final uri = Uri.parse(url);
    return uri.isAbsolute;
  }
}