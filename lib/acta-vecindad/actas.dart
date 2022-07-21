import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/paso-1.dart';
import 'package:cvc/acta-vecindad/paso-2.dart';
import 'package:cvc/acta-vecindad/paso-3.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/acta.dart';
import 'package:cvc/http/constant.dart';
import 'package:cvc/principal/principal.dart';
import 'package:cvc/seguimiento/estado-seguimiento.dart';
import 'package:cvc/seguimiento/seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ActasPage extends StatefulWidget {
  final int idProyecto;
  const ActasPage({Key? key, required this.idProyecto}) : super(key: key);
  @override
  State<ActasPage> createState() => _ActasPageState();
}

class _ActasPageState extends State<ActasPage> {
  List<dynamic> actas = List.empty();
  bool loading = false;

  TextEditingController codigo = new TextEditingController();
  TextEditingController fecha = new TextEditingController();

  ActaHttp actaService = ActaHttp();
 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlurryModalProgressHUD(
      inAsyncCall: loading,
      blurEffectIntensity: 4,
      progressIndicator: Center(child: CircularProgressIndicator()),
      dismissible: false,
      opacity: 0.4,
      color: Colors.black87,
      child: Scaffold(
        extendBodyBehindAppBar : false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Navigator.push(
                context,
                BouncyPageRoute(widget: MainPage())
              )
            },
          ),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("Actas registradas", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 30)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity, 
            height: size.height-50,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  actas.isNotEmpty ? Container(
                    padding: EdgeInsets.only(bottom: 70),
                    color: Colors.transparent,
                    height: size.height - size.height * 0.1,
                    child: ListView.builder(
                      itemCount: actas.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return itemCard(actas[index]);
                      }
                    )
                  ): Container(),
                ]
              )
            )
          )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             _onAlertWithCustomContentPressed(context);
          },
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          child: const Icon(Icons.add, color: Color.fromRGBO(236,172,20, 1)),
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    listarActas();
  }

  _onAlertWithCustomContentPressed(context) async {
    await obtenerCodigo();
    Alert(
      context: context,
      title: "Registro de acta de vecindad",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.qr_code_rounded),
              labelText: 'Codigo',
            ),
            controller: codigo,
          ),
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              labelText: 'Fecha ( 22/01/2022 )',
            ),
            controller: fecha,
          ),
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            registrarActa(context);
          },
          child: Text(
            "Guardar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]
    ).show();
  }
  
  obtenerCodigo() async {
    dynamic respuesta;

    final link = Uri.parse(BaseUrl+"codigo-acta?id="+widget.idProyecto.toString());
    final response = await http.get(link);

    if (response.statusCode != 200) {
      respuesta.mensaje = "no existe esa URL";
      respuesta.success = 0;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json["codigo"];
      armarCodigo(respuesta[0]["consecutivo"]);
    }
  }

  armarCodigo(int consecutivo) async {
    String ct = "";
    if(consecutivo < 10 ){
      ct = "AV-00"+consecutivo.toString();
    }else{
      if(consecutivo < 100 ){
        ct = "AV-0"+consecutivo.toString();
      }else{
        if(consecutivo < 1000 ){
          ct = "AV-"+consecutivo.toString();
        }
      }
    }

    setState(() {
      codigo.text = ct;
    });
  }

  registrarActa(BuildContext context) async {
    var res = await actaService.registrarActa(codigo.text, widget.idProyecto.toString(), fecha.text);
    if(res["guardado"] = true){
     Navigator.push(
        context,
        BouncyPageRoute(widget: PasoUnoPage(idActa: res["acta"]["id"], idProyecto: int.parse(res["acta"]["id_proyecto"])))
      ); 
    }else{
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Ocurrio un error, intente nuevamente."),
        icon: Icons.error,
      ).show(context);
    }
  }

  listarActas() async {
    var res = await actaService.actasRegistradas(widget.idProyecto.toString());
    setState(() {
      actas = res["actas"];
      print(actas);
    });
  }

  Widget itemCard(dynamic item){
    return Container(
      height: 140.0,
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: Stack(
        children: [
          Container(
            height: 124.0,
            width: 660,
            margin: EdgeInsets.only(left: 52.0),
            padding: EdgeInsets.only(left: 80),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient:  LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0.0, 1.0),
                colors:  <Color>[
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ], // red to yellow
                tileMode: TileMode.repeated, 
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(  
                  color: Color.fromARGB(122, 87, 87, 87),
                  blurRadius: 17.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha :${item["fecha"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Estado : ${item["estado"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text('Paso de registro : ${item["paso"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ) ,
                ),
                SizedBox(width: 100),
                Transform(
                  transform: Matrix4.skewX(-0.3),
                  child: GestureDetector(
                    onTap: () {
                      if(item["estado"] != "Cerrado"){
                        completarRegistro(item);
                      }else{
                        showError();
                      }
                    },
                    child: Container(
                      width: 140,
                      color: Colors.amber,
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Icon(item["paso"] < 4 ? Icons.app_registration : item["paso"] >= 4 && item["estado"] == "Cerrado"? Icons.check :Icons.edit, size: 60, color: Color.fromRGBO(44,52,76, 1)),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: item["paso"] < 4 ?  Text("Completar registro", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))): item["paso"] >= 4 && item["estado"] == "Cerrado"? Text("Completado", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))): Text("Editar acta", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))),
                          )
                        ],
                      ),
                    ),
                  ) ,
                ),
                Transform(
                  transform: Matrix4.skewX(-0.3),
                  child: GestureDetector(
                    onTap: (){
                      if(item["estado"] != "Cerrado"){
                        Navigator.push(
                          context,
                          BouncyPageRoute(widget: SeguimientoPage(idActa: item["id"], idProyecto: int.parse(item["id_proyecto"])))
                        );
                      }else{
                        showError();
                      }
                    },
                    child: Container(
                      width: 130,
                      color: Color.fromRGBO(44,52,76, 1),
                      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Icon(Icons.remove_red_eye, size: 60, color:  Colors.amber,),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text("Seguimiento", style: TextStyle(color: Colors.amber)),
                          )
                        ],
                      ) ,
                    ),
                  )
                ),
                Transform(
                  transform: Matrix4.skewX(-0.3),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        BouncyPageRoute(widget: EstadoSeguimientoPage(idActa: item["id"], idProyecto: int.parse(item["id_proyecto"])))
                      );
                    },
                    child: Container(
                      width: 130,
                      color: Colors.amber,
                      padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            child: Icon(Icons.edit_note, size: 60, color: Color.fromRGBO(44,52,76, 1),),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Text("Firmar acta", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))),
                          )
                        ],
                      ) ,
                    )
                  ) 
                )
              ],
            )
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(44,52,76, 1),
              borderRadius: BorderRadius.circular(81),
              border: Border.all(
                color: Color.fromRGBO(44,52,76, 1),
                width: 1,
              ),
            ),
            width: 112,
            height: 72,
            margin:  EdgeInsets.symmetric(vertical: 25.0),
            child: Center(
              child: Text(item["codigo"], style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontWeight: FontWeight.bold, fontSize: 25))
            ),
          )
        ],
      )
    );
  }

  completarRegistro(dynamic item){
    if(item["paso"] == 1 || item["paso"] == 4){
      Navigator.push(
        context,
        BouncyPageRoute(widget: PasoUnoPage(idActa: item["id"], idProyecto: int.parse(item["id_proyecto"])))
      );
    }
    if(item["paso"] == 2){
      Navigator.push(
        context,
        BouncyPageRoute(widget: PasoDosPage(idActa: item["id"], idProyecto: int.parse(item["id_proyecto"])))
      );
    }
    if(item["paso"] == 3){
      Navigator.push(
        context,
        BouncyPageRoute(widget: PasoTresPage(idActa: item["id"], idProyecto: int.parse(item["id_proyecto"])))
      );
    }
  }

  showError() {
    MotionToast(
      primaryColor: Colors.red,
      description: Text("Esta acta ya ha sido firmada"),
      icon: Icons.cancel,
    ).show(context);
  }
}