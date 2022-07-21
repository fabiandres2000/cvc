import 'constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ActaHttp { 

  Future<dynamic> registrarActa(String codigo, String idProyecto, String fecha) async {
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-acta"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'codigo': codigo,
        'id_proyecto': idProyecto,
        'fecha': fecha,
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

  Future<dynamic> actasRegistradas(String idProyecto) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "actas?id="+idProyecto);
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

  Future<dynamic> registrosFotograficos(String idActa) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "registros-fotograficos?id="+idActa);
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

  Future<dynamic> registrarPaso1(List<String> bases64, int idActa) async {
    var jsonen = convert.jsonEncode(bases64);
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-paso-1?id="+idActa.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'json': jsonen.toString()
      }),
    );

    if (response.statusCode != 200) {
       print(response.body);
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> registrarPaso2(String nombreReponsable, String nombrePropietario,String cedula,String telefono,String direccion,String numeroPisos,String sector,String observaciones,String departamento,String municipio,String barrio,String tipoTenencia,String acueducto,String alcantarillado,String energia,String telefonos,String gas,String televisionCable,String otrosServicios,String tipoPredio,String estadoPredio,String conLicencia,String pendienteTerreno,String usoActual,String garaje, String usoGaraje, String idActa) async {
    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-paso-2?id="+idActa),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'nombreReponsable': nombreReponsable,
        'nombrePropietario': nombrePropietario,
        'cedula': cedula,
        'telefono': telefono,
        'direccion': direccion,
        'numeroPisos': numeroPisos,
        'sector': sector,
        'observaciones': observaciones,
        'departamento': departamento,
        'municipio': municipio,
        'barrio': barrio,
        'tipoTenencia': tipoTenencia,
        'acueducto': acueducto,
        'alcantarillado': alcantarillado,
        'energia': energia,
        'telefonos': telefonos,
        'gas': gas,
        'televisionCable': televisionCable,
        'otrosServicios': otrosServicios,
        'tipoPredio': tipoPredio,
        'estadoPredio': estadoPredio,
        'conLicencia': conLicencia,
        'pendienteTerreno': pendienteTerreno,
        'usoActual': usoActual,
        'garaje': garaje,
        'usoGaraje': usoGaraje,
      }),
    );

    if (response.statusCode != 200) {
       print(response.body);
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> datosPredio(String idActa) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "datos-predio?id="+idActa);
    final response = await http.get(link);

    if (response.statusCode != 200) {
      respuesta = null;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
    }
    return respuesta;
  }

  Future<dynamic> registrarPaso3(int idActa, List<dynamic> estadoCimentacion, String observacionesCimentacion, List<dynamic> estadoMuros, String observacionesMuros, List<dynamic> estadoCerramiento, String observacionesCerramiento, List<dynamic> estadoCubierta, String observacionesCubierta, List<dynamic> estadoEstructura, String observacionesEstructura, List<dynamic> estadoFachada, String observacionesFachada, List<dynamic> estadoAndenes, String observacionesAndenes, String otros) async {
    
    var jsonEstadoCimentacion = convert.jsonEncode(estadoCimentacion);
    var jsonEstadoMuros = convert.jsonEncode(estadoMuros);
    var jsonEstadoCerramientos = convert.jsonEncode(estadoCerramiento);
    var jsonEstadoCubierta = convert.jsonEncode(estadoCubierta);
    var jsonEstadoEstructura = convert.jsonEncode(estadoEstructura);
    var jsonEstadoFachada = convert.jsonEncode(estadoFachada);
    var jsonEstadoAndenes = convert.jsonEncode(estadoAndenes);



    dynamic respuesta;
    final response = await http.post(
      Uri.parse(BaseUrl + "registro-paso-3?id="+idActa.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, dynamic>{
        'estado_cimentacion': jsonEstadoCimentacion.toString(),
        'estado_muros': jsonEstadoMuros.toString(),
        'estado_cerramientos': jsonEstadoCerramientos.toString(),
        'estado_cubierta': jsonEstadoCubierta.toString(),
        'estado_estructura': jsonEstadoEstructura.toString(),
        'estado_fachada': jsonEstadoFachada.toString(),
        'estado_andenes': jsonEstadoAndenes.toString(),
        'observacionesCimentacion': observacionesCimentacion,
        'observacionesMuros': observacionesMuros,
        'observacionesCerramiento': observacionesCerramiento,
        'observacionesCubierta': observacionesCubierta,
        'observacionesEstructura': observacionesEstructura,
        'observacionesFachada': observacionesFachada,
        'observacionesAndenes': observacionesAndenes,
        'otros': otros,
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

  Future<dynamic> datosPaso3(String idActa) async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "estados-predio?id="+idActa);
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