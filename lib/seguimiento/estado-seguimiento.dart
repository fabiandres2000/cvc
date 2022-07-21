import 'dart:convert';
import 'dart:typed_data';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/http/seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:signature/signature.dart';

import '../components/bouncy.dart';

class EstadoSeguimientoPage extends StatefulWidget {
  final int idActa;
   final int idProyecto;
  const EstadoSeguimientoPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<EstadoSeguimientoPage> createState() => _EstadoSeguimientoPageState();
}

class _EstadoSeguimientoPageState extends State<EstadoSeguimientoPage> {
  
  bool loading = false;
  int hayFirma = 0;

  BoxDecoration decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 5,
        offset:
            Offset(0, 3), // changes position of shadow
      ),
    ],
  );

  SeguimientoHttp seguimientoService = SeguimientoHttp();
  dynamic objetoEstado;

  List<dynamic> firmasGuardadas = List.empty();


  Uint8List? exportedImage;
  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  TextEditingController nombreUS = TextEditingController();

  Uint8List? exportedImage2;
  SignatureController controller2 = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  TextEditingController nombreUS2 = TextEditingController();

  Uint8List? exportedImage3;
  SignatureController controller3 = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  TextEditingController nombreUS3 = TextEditingController();

  Uint8List? exportedImage4;
  SignatureController controller4 = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );
  TextEditingController nombreUS4 = TextEditingController();

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
        backgroundColor: Colors.white,
        extendBodyBehindAppBar : false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("ESTADO DE SEGUIMIENTO", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[  
              Container(  
                margin: EdgeInsets.all(20),  
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Table(  
                    defaultColumnWidth: FixedColumnWidth(180.0),  
                    border: TableBorder.all(  
                        color: Colors.black,  
                        style: BorderStyle.solid,  
                        width: 2),  
                    children: [  
                      TableRow( children: [  
                        Column(children:[Text('LUGAR', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))]),  
                        Column(children:[Text('ANTES', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))]),  
                        Column(children:[Text('DESPUES', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold))]),  
                      ]),
                      TableRow( children: [  
                        Column(children:[Text('PISOS', style: TextStyle(fontSize: 20.0))]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["pisosAntes"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["pisosDespues"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),
                      ]),  
                      TableRow( children: [  
                        Column(children:[Text('PAREDES', style: TextStyle(fontSize: 20.0))]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["paredesAntes"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["paredesDespues"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                      ]),  
                      TableRow( children: [  
                        Column(children:[Text('TECHO', style: TextStyle(fontSize: 20.0))]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["techoAntes"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["techoDespues"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),   
                      ]),
                      TableRow( children: [  
                        Column(children:[Text('BAÑO', style: TextStyle(fontSize: 20.0))]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["banioAntes"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["banioDespues"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                      ]),
                      TableRow( children: [  
                        Column(children:[Text('COCINA', style: TextStyle(fontSize: 20.0))]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["cocinaAntes"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),  
                        Column(children:[
                          objetoEstado != null ?
                            objetoEstado["cocinaDespues"] == 0?
                              Icon(Icons.close, color: Colors.red)
                            : Icon(Icons.check, color: Colors.green)
                          : Center()
                        ]),   
                      ]),  
                    ]),
                    SizedBox(height: 40),
                    objetoEstado != null ?
                      hayFirma == 0 ?
                        objetoEstado["pisosAntes"]  == 1 &&  objetoEstado["paredesAntes"]  == 1 &&  objetoEstado["techoAntes"]  == 1 &&  objetoEstado["banioAntes"]  == 1 &&  objetoEstado["cocinaAntes"]  == 1?
                          columnFirmas()
                        : Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            padding:EdgeInsets.all(20),
                            color: Colors.red[300],
                            height: 200,
                            width: size.width - 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error, size: 70, color: Colors.grey[200]),
                                SizedBox(height: 20),
                                Text('Por favor cargue todas las imagenes de "ANTES", para poder firmar el acta.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                              ],
                            ),
                          )
                        )
                      : hayFirma == 1 ? objetoEstado["pisosDespues"]  == 1 &&  objetoEstado["paredesDespues"]  == 1 &&  objetoEstado["techoDespues"]  == 1 &&  objetoEstado["banioDespues"]  == 1 &&  objetoEstado["cocinaDespues"]  == 1?
                          columnFirmas()
                        : Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            padding:EdgeInsets.all(20),
                            color: Colors.red[300],
                            height: 200,
                            width: size.width - 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error, size: 70, color: Colors.grey[200]),
                                SizedBox(height: 20),
                                Text('Por favor cargue todas las imagenes de "DESPUES", para poder firmar el acta.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))
                              ],
                            ),
                          )
                        )
                      : Center(
                          child: Container(
                            margin: EdgeInsets.all(20),
                            padding:EdgeInsets.all(20),
                            color: Colors.green[300],
                            height: 200,
                            width: size.width - 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.check, size: 70, color: Colors.grey[200]),
                                SizedBox(height: 20),
                                Text('Ya esta acta ha sido firmada.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                              ],
                            ),
                          )
                        )
                    : Center()
                  ],
                )   
              )    
            ])
          ),
        ) 
      )
    );
  }

  Widget columnFirmas() {
    return Column(
      children: [
        hayFirma == 0 ? Center(child: Container(padding: EdgeInsets.only(left: 20) ,child: Text("REGISTRO FOTOGRAFICO Y/0 FILMICO EN MEDIO MAGNÉTICO, ANTES DE INTERVENIR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1))))):
        Center(child: Container(padding: EdgeInsets.only(left: 20) ,child: Text("REGISTRO FOTOGRAFICO Y/0 FILMICO EN MEDIO MAGNÉTICO, DESPUES DE INTERVENIR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1))))),   
        Center(child: Container(padding: EdgeInsets.only(left: 20) ,child: Text("NOTA: SE DEJA CONSTANCIA QUE LO CONSIGNADO EN LA PRESENTE ACTA CORRESPONDE A LA REALIDAD", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1))))),
        SizedBox(height: 20),
        Center(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Signature(
                    controller: controller,
                    width: 350,
                    height: 200,
                    backgroundColor: Colors.grey[200]!,
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 350,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombreUS,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'RESPONSABLE UNIDAD SOCIAL'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("__________________________________________________________"),
                  Text("FIRMA DEL RESPONSABLE UNIDAD SOCIAL")
                ],
              ),
              SizedBox(width: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Signature(
                    controller: controller2,
                    width: 360,
                    height: 200,
                    backgroundColor: Colors.grey[200]!,
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 350,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombreUS2,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'REPRESENTANTE DEL CONTRATISTA'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("__________________________________________________________"),
                  Text("FIRMA DEL REPRESENTANTE DEL CONTRATISTA")
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Signature(
                    controller: controller3,
                    width: 350,
                    height: 200,
                    backgroundColor: Colors.grey[200]!,
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 350,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombreUS3,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'REPRESENTANTE DE LA INTERVENTORIA'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("__________________________________________________________"),
                  Text("FIRMA DEL REPRESENTANTE DE LA INTERVENTORIA")
                ],
              ),
              SizedBox(width: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Signature(
                    controller: controller4,
                    width: 360,
                    height: 200,
                    backgroundColor: Colors.grey[200]!,
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 350,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombreUS4,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'TESTIGO'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text("__________________________________________________________"),
                  Text("FIRMA DEL TESTIGO")
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform(
              transform: Matrix4.skewX(-0.3),
              child: GestureDetector(
                onTap: () {
                  
                },
                child: Container(
                  width: 140,
                  color: Colors.amber,
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        child: Icon(Icons.cancel, size: 30, color: Color.fromRGBO(44,52,76, 1)),
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text("cancelar", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))),
                      )
                    ],
                  ),
                ),
              ) ,
            ),
            SizedBox(width: 10),
            Transform(
              transform: Matrix4.skewX(-0.3),
              child: GestureDetector(
                onTap: () {
                  guardarFirmas();
                },
                child: Container(
                  width: 130,
                  color: Color.fromRGBO(44,52,76, 1),
                  padding: EdgeInsets.only(top: 5, left: 10, right: 10,  bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        child: Icon(Icons.check, size: 30, color:  Colors.amber,),
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text("Firmar", style: TextStyle(color: Colors.amber)),
                      )
                    ],
                  ) ,
                ),
              ),
            )],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    estadoSeguimiento();
  }

  estadoSeguimiento() async {
    await ce();
    var res = await seguimientoService.estadoSeguimiento(widget.idActa.toString());
    setState(() {
      objetoEstado = res;
      loading = false;
    }); 
    hayFirmas();
  }

  hayFirmas() async {
    var res = await seguimientoService.hayFirmas(widget.idActa.toString());
    setState(() {
      hayFirma = res["firma"];
    }); 
  }

  ce () async {
    await Future.delayed(const Duration(milliseconds: 1000), (){ setState(() {
        loading = true;
      }); 
    });
  }

  guardarFirmas() async {
    setState(() {
      loading = true;
    });
    exportedImage = await controller.toPngBytes();
    exportedImage2 = await controller2.toPngBytes();
    exportedImage3 = await controller3.toPngBytes();
    exportedImage4 = await controller4.toPngBytes();

    String firmaRUS = base64Encode(exportedImage!);
    String firmaCO = base64Encode(exportedImage2!);
    String firmaRI = base64Encode(exportedImage3!);
    String firmaTE = base64Encode(exportedImage4!);

    var tipo = hayFirma == 0 ? "ANTES" : "DESPUES";

    var res = await seguimientoService.registrarFirmas(widget.idActa , firmaRUS, firmaCO, firmaRI, firmaTE, nombreUS.text, nombreUS2.text, nombreUS3.text, nombreUS4.text, tipo);

    setState(() {
    loading = false;
    });
    if(res != null){
      if(res["guardado"] == false){
        MotionToast(
          primaryColor: Colors.red,
          description: Text("Ocurrio un error, intente nuevamente."),
          icon: Icons.cancel,
        ).show(context);
      }else{
        Navigator.push(
          context,
          BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
        );
      }
    }else{
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Ocurrio un error, intente nuevamente."),
        icon: Icons.cancel,
      ).show(context);
    }
  }
}