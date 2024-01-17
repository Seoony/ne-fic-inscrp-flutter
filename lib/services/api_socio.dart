import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:ficha_inscripcion/models/socio.dart';
import 'package:ficha_inscripcion/config.dart';

class APISocio {
  static var client = http.Client();

  static Future<List<Socio>?> getSocios() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      Config.sociosApi,
    );
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return compute(socioFromJson, response.body);
    }
    else {
      return null;
    }
  }

  static Future<bool> saveSocio(
      Socio socio, bool isEditMode
      ) async {
    var socioURL = "${Config.sociosApi}/";
    if (isEditMode) {
      socioURL += "${socio.id}/";
    }
    var url = Uri.http(
      Config.API_URL,
      socioURL,
    );
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);
    request.fields['nombres'] = socio.nombres!;
    request.fields['apellidos'] = socio.apellidos!;
    request.fields['dni'] = socio.dni!;
    request.fields['estado'] = socio.estado!;

    var response = await request.send();
    if (response.statusCode >= 201 && response.statusCode < 300){
      return true;
    }
    else {
      return false;
    }
  }
  static Future<bool> deleteSocio(socioId) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    var url = Uri.http(
      Config.API_URL,
      "${Config.sociosApi}/$socioId/",
    );
    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200){
      return true;
    }
    else {
      return false;
    }
  }

}