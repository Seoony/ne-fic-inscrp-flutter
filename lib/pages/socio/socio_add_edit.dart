import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/services/api_socio.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class SocioAddEdit extends StatefulWidget {
  final Socio? socio;
  const SocioAddEdit({Key? key, this.socio}) : super(key: key);

  @override
  _SocioAddEditState createState() => _SocioAddEditState();
}

class _SocioAddEditState extends State<SocioAddEdit> {
  Socio? socio;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Formulario de Socios"),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: socioForm(),
          ),
        ),
      ), 
     );
  }

  @override
  void initState() {
    super.initState();
    globalFormKey = GlobalKey<FormState>();
    socio = widget.socio ?? Socio();
    Future.delayed(Duration.zero, () {
      if(socio?.id != null) {
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget socioForm() {
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
              "Socio Name",
              "Nombre del Socio",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese los nombres';
                }
                return null;
              },
              (onSavedVal) =>{
                socio!.nombres = onSavedVal,
              },
              initialValue: socio?.nombres ?? "",
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
              "Socio Last Name",
              "Apellidos del Socio",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese los apellidos';
                }
                return null;
              },
              (onSavedVal) =>{
                socio!.apellidos = onSavedVal,
              },
              initialValue: socio?.apellidos ?? "",
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
              "Socio DNI",
              "DNI del Socio",
              (onValidateVal) {
                if (onValidateVal!.isEmpty || onValidateVal == null || onValidateVal.length != 8) {
                  return 'Ingrese el DNI, recuerde que son 8 digitos.';
                }
                return null;
              },
              (onSavedVal) =>{
                socio!.dni = onSavedVal,
              },
              initialValue: socio?.dni ?? "",
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
                      APISocio.saveSocio(
                        socio!,
                        isEditMode,
                        ).then((response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if(response){
                            Navigator.pushNamed(
                              context,
                              '/list-socio',                          
                            );
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Negocios Electronicos",
                              "Error al guardar el socio",
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