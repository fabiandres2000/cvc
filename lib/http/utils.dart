import 'constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UtilsHttp {  

  Future<dynamic> departamentos() async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "departamentos");
    final response = await http.get(link);

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> municipios(String id) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "municipios?id="+id);
    final response = await http.get(link);

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> barrios(String id) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "barrios?id="+id);
    final response = await http.get(link);

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> registrarBarrio(String idDep, String idMun, String nombre) async {
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-barrio"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'idDep': idDep,
        'idMun': idMun,
        'nombre': nombre,
      }),
    );

    if (response.statusCode != 200) {
      respuesta = 0;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

}