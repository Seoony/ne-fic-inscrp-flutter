import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';
import 'package:ficha_inscripcion/services/api_tipo_deporte.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class TipoDeporteAddEdit extends StatefulWidget {
  final TipoDeporte? tipoDeporte;
  const TipoDeporteAddEdit({Key? key, this.tipoDeporte}) : super(key: key);

  @override
  _TipoDeporteAddEditState createState() => _TipoDeporteAddEditState();
}

class _TipoDeporteAddEditState extends State<TipoDeporteAddEdit> {
  TipoDeporte? tipoDeporte;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario de Tipo de Deportes"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: tipoDeporteForm(),
          ),
        ),
      ), 
     );
  }

  @override
  void initState() {
    super.initState();
    tipoDeporte = widget.tipoDeporte ?? TipoDeporte();

    Future.delayed(Duration.zero, () {
      if(ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        tipoDeporte = arguments['tipoDeporte'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget tipoDeporteForm() {
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
              "TipoDeporte Name",
              "Nombre del TipoDeporte",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese el nombre';
                }
                return null;
              },
              (onSavedVal) =>{
                tipoDeporte!.nombre = onSavedVal,
              },
              initialValue: tipoDeporte?.nombre ?? "",
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
              "TipoDeporte Description",
              "Descripción del Deporte",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese la descripción';
                }
                return null;
              },
              (onSavedVal) =>{
                tipoDeporte!.descripcion = onSavedVal,
              },
              initialValue: tipoDeporte?.descripcion ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              isMultiline: true,
              maxLength: 600,
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "TipoDeporte DNI",
              "DNI del TipoDeporte",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null || onValidateVal.length != 8) {
                  return 'Ingrese el DNI, recuerde que son 8 digitos.';
                }
                return null;
              },
              (onSavedVal) =>{
                tipoDeporte!.dni = onSavedVal,
              },
              initialValue: tipoDeporte?.dni ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
            ),
          ),*/
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
                      APITipoDeporte.saveTipoDeporte(
                        tipoDeporte!,
                        isEditMode,
                        ).then((response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if(response){
                            Navigator.pushNamed(
                              context,
                              '/list-tipoDeporte',                          
                            );
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Negocios Electronicos",
                              "Error al guardar el tipoDeporte",
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
  }

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