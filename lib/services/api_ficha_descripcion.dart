import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:ficha_inscripcion/models/ficha_inscripcion.dart';
import 'package:ficha_inscripcion/config.dart';

class APIFichaInscripcion {
  static var client = http.Client();

  static Future<List<FichaInscripcion>?> getFichaInscripcion() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.API_URL,
      Config.fichaInscripcionApi,
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(fichaInscripcionFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<List<FichaInscripcion>?> getAllFichaInscripcion() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.API_URL,
      "${Config.fichaInscripcionApi}/all/",
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(fichaInscripcionFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<bool> saveSocio(
      FichaInscripcion fichaInscripcion, bool isEditMode
      ) async {
    var fichaInscripcionURL = Config.fichaInscripcionApi;
    if (isEditMode) {
      fichaInscripcionURL += "${fichaInscripcion.id}/update/";
    }else{
      fichaInscripcionURL += "create/";
    }
    var url = Uri.https(
      Config.API_URL,
      fichaInscripcionURL,
    );
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);
    request.fields['socio'] = fichaInscripcion.socio?.id! as String; 
    request.fields['tipoDeporte'] = fichaInscripcion.tipoDeporte?.id! as String;
    request.fields['fechaInscripcion'] = fichaInscripcion.fechaInscripcion!;
    request.fields['monto'] = fichaInscripcion.monto!.toString();
    if(fichaInscripcion.estado == null){
      request.fields['estado'] = "A";
    }else{
      request.fields['estado'] = fichaInscripcion.estado!;
    }

    var response = await request.send();
    if (response.statusCode >= 200 && response.statusCode < 300){
      return true;
    }
    else {
      return false;
    }
  }
  
  static Future<bool> deactivateFichaInscripcion(fichaInscripcionId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.fichaInscripcionApi}/$fichaInscripcionId/deactivate/",
    );
    var response = await client.put(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

  static Future<bool> activateFichaInscripcion(fichaInscripcionId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.fichaInscripcionApi}/$fichaInscripcionId/activate/",
    );
    var response = await client.put(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

  static Future<bool> deleteFichaInscripcion(fichaInscripcionId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.fichaInscripcionApi}/$fichaInscripcionId/delete/",
    );
    var response = await client.put(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

}