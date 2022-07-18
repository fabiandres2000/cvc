import 'constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProyectoHttp { 

  Future<dynamic> registrarProyecto(String nombre, String ubic, String nco, String nci) async {
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-proyecto"),
      headers: <String, String>{
        'Referer': 'https://www.leeringenieria.com',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'nombre': nombre,
        'ubic': ubic,
        'nco': nco,
        'nci': nci,
      }),
    );

    if (response.statusCode != 200) {
      respuesta.mensaje = "no existe esa URL";
      respuesta.success = 0;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> proyectosRegistrados() async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "proyectos");
    final response = await http.get(link);

    if (response.statusCode != 200) {
      respuesta.mensaje = "no existe esa URL";
      respuesta.success = 0;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }
}