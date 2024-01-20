import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/services/api_socio.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:ficha_inscripcion/config.dart';

class SocioAddEdit extends StatefulWidget {
  const SocioAddEdit({Key? key}) : super(key: key);

  @override
  _SocioAddEditState createState() => _SocioAddEditState();
}

class _SocioAddEditState extends State<SocioAddEdit> {
  Socio? socio;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
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
    socio = Socio();

    Future.delayed(Duration.zero, () {
      if(ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        socio = arguments['socio'];
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
                if (onValidateVal!.isEmpty || onValidateVal == null) {
                  return 'Ingrese el DNI';
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
            child: FormHelper.submitButton(
              "Guardar",
              () {
                if(validateAndSave()) {
                  print(socio!.toJson());
                  setState(() {
                    isApiCallProcess = true;
                  });
                  APISocio.saveSocio(
                    socio!,
                    isEditMode,
                    ).then((response) {
                      setState(() {
                        isApiCallProcess = false;
                        print(response);
                      });
                      if(response){
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/list-socio',
                          (route) => false,
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