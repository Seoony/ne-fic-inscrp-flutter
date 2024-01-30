import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:ficha_inscripcion/models/tipo_deporte.dart';
import 'package:ficha_inscripcion/config.dart';

class APITipoDeporte {
  static var client = http.Client();

  static Future<List<TipoDeporte>?> getTipoDeporte() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.API_URL,
      Config.tipoDeportesApi,
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(tipoDeporteFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<List<TipoDeporte>?> getSimplifiedTipoDeporte() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.API_URL,
      Config.simplifiedTipoDeportesApi,
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(tipoDeporteFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<List<TipoDeporte>?> getAllTipoDeportes() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.API_URL,
      "${Config.tipoDeportesApi}/all/",
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(tipoDeporteFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<bool> saveTipoDeporte(
      TipoDeporte tipoDeporte, bool isEditMode
      ) async {
    var tipoDeporteURL = Config.tipoDeportesApi;
    if (isEditMode) {
      tipoDeporteURL += "${tipoDeporte.id}/update/";
    }else{
      tipoDeporteURL += "create/";
    }
    var url = Uri.https(
      Config.API_URL,
      tipoDeporteURL,
    );
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);
    request.fields['nombre'] = tipoDeporte.nombre!;
    request.fields['descripcion'] = tipoDeporte.descripcion!;
    if(tipoDeporte.estado == null){
      request.fields['estado'] = "A";
    }else{
      request.fields['estado'] = tipoDeporte.estado!;
    }

    var response = await request.send();
    if (response.statusCode >= 200 && response.statusCode < 300){
      return true;
    }
    else {
      return false;
    }
  }
  
  static Future<bool> deactivateTipoDeporte(tipoDeporteId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.tipoDeportesApi}/$tipoDeporteId/deactivate/",
    );
    var response = await client.put(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

  static Future<bool> activateTipoDeporte(tipoDeporteId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.tipoDeportesApi}/$tipoDeporteId/activate/",
    );
    var response = await client.put(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

  static Future<bool> deleteTipoDeporte(tipoDeporteId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.tipoDeportesApi}/$tipoDeporteId/delete/",
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