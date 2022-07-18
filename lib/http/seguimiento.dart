import 'constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SeguimientoHttp { 

  Future<dynamic> registrarSeguimiento(List<String> bases64, int idActa, String parteCasa, String tipoSeguimiento, String observaciones) async {
    var jsonen = convert.jsonEncode(bases64);
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-seguimiento"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'id_acta': idActa.toString(),
        'parteCasa': parteCasa,
        'tipoSeguimiento': tipoSeguimiento,
        'observaciones': observaciones,
        'json': jsonen.toString()
      }),
    );

    if (response.statusCode != 200) {
      respuesta = null;
      print(response.body);
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> detalleSeguimiento(String idActa, String parteCasa, String tipoSeguimiento) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "datos-seguimiento?id_acta="+idActa+"&parteCasa="+parteCasa+"&tipoSeguimiento="+tipoSeguimiento);
    final response = await http.get(link);

    if (response.statusCode != 200) {
      respuesta = null;
      print(response.body);
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> estadoSeguimiento(String idActa) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "estado-seguimiento?id_acta="+idActa);
    final response = await http.get(link);

    if (response.statusCode != 200) {
      respuesta = null;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }
}