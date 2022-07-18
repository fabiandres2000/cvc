import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/acta-vecindad/firmas-hoja-1.dart';
import 'package:cvc/acta-vecindad/paso-2.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/acta.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/motion_toast.dart';


class PasoTresPage extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const PasoTresPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<PasoTresPage> createState() => _PasoTresPageState();
}

class _PasoTresPageState extends State<PasoTresPage> {
  
  bool loading = false;
  ActaHttp actaService = ActaHttp();

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


  List<Map> estadoCimentacion = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesCimentacion = TextEditingController();

  List<Map> estadoMuros = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesMuros = TextEditingController();

  List<Map> estadoCerramiento = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesCerramiento = TextEditingController();

  List<Map> estadoCubierta = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesCubierta = TextEditingController();

  List<Map> estadoEstructura = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesEstructura = TextEditingController();

  List<Map> estadoFachada = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesFachada = TextEditingController();

  List<Map> estadoAndenes = [
    {"name": "GRIETAS Y FISURAS", "isChecked": false},
    {"name": "HUMEDADES", "isChecked": false},
    {"name": "HUNDIMIENTOS","isChecked": false,},
    {"name": "DESPLAZAMIENTOS", "isChecked": false},
    {"name": "OTROS", "isChecked": false}
  ];
  TextEditingController observacionesAndenes = TextEditingController();

  TextEditingController otros = TextEditingController();

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
            onPressed: () => {
              Navigator.push(
                context,
                BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
              )
            },
          ),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("3.ESTADO DEL PREDIO ANTES DE INTERVENIR", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body:  SingleChildScrollView(
            child:Padding(
              padding: const EdgeInsets.all(20), 
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("CIMENTACION", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoCimentacion.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesCimentacion,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ),       
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("MUROS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoMuros.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesMuros,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ), 
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("CERRAMIENTOS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoCerramiento.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesCerramiento,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ), 
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("CUBIERTAS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoCubierta.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesCubierta,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ), 
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("ESTRUCTURAS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoEstructura.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesEstructura,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ), 
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("FACHADA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoFachada.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesFachada,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ), 
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("ANDENES", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Row(
                  children: [
                    Container(
                      width: size.width - (size.width * 0.7),
                      child: Column(
                        children: estadoAndenes.map((hobby) {
                        return CheckboxListTile(
                            value: hobby["isChecked"],
                            title: Text(hobby["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                hobby["isChecked"] = newValue;
                              });
                            });
                      }).toList()),
                    ),
                    Container(
                      width: size.width - (size.width * 0.35),
                      child:  Padding(
                        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                        child: Container (
                          padding: EdgeInsets.all(10),
                          height: 250,
                          decoration: decoration,
                          child: TextField(
                            maxLines: 8,
                            controller: observacionesAndenes,
                            decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                          ),
                        )
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("OTROS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))), 
                Container(padding: EdgeInsets.only(left: 20) ,child: Text("(VERIFICAR MANEJO DE AGUAS LLUVIAS Y RESIDUALES, CARPINTERIA METALICA Y DE MADERA)", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),    
                SizedBox(height: 10),
                Container(
                  width: size.width - (size.width * 0.05),
                  child:  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                    child: Container (
                      padding: EdgeInsets.all(10),
                      height: 250,
                      decoration: decoration,
                      child: TextField(
                        maxLines: 8,
                        controller: otros,
                        decoration: InputDecoration.collapsed(hintText: "Texto..."),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 20),   
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Transform(
                      transform: Matrix4.skewX(-0.3),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            BouncyPageRoute(widget: PasoDosPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
                          );
                        },
                        child: Container(
                          width: 140,
                          color: Colors.amber,
                            padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                          child: Column(
                            children: [
                              Container(
                                child: Icon(Iconsax.arrow_left, size: 30, color: Color.fromRGBO(44,52,76, 1)),
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: Text("Anterior", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))),
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
                          guardarPaso3();
                        },
                        child: Container(
                          width: 130,
                          color: Color.fromRGBO(44,52,76, 1),
                          padding: EdgeInsets.only(top: 5, left: 10, right: 10,  bottom: 5),
                          child: Column(
                            children: [
                              Container(
                                child: Icon(Iconsax.arrow_right_1, size: 30, color:  Colors.amber,),
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: Text("Siguiente", style: TextStyle(color: Colors.amber)),
                              )
                            ],
                          ) ,
                        ),
                      ),
                    )],
                  ),
                ),
                SizedBox(height: 20),
              ]
            )
          )
        )
      )
    );
  }

  guardarPaso3() async {
    setState(() {
      loading = true;
    });
    var res = await actaService.registrarPaso3(widget.idActa, estadoCimentacion, observacionesCimentacion.text, estadoMuros, observacionesMuros.text, estadoCerramiento, observacionesCerramiento.text, estadoCubierta, observacionesCubierta.text, estadoEstructura, observacionesEstructura.text, estadoFachada, observacionesFachada.text, estadoAndenes, observacionesAndenes.text, otros.text);
    if(res == null){
      setState(() {
        loading = false;
      });
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Ocurrio un error, intente nuevamente."),
        icon: Icons.cancel,
      ).show(context);
    }else{
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        BouncyPageRoute(widget: FirmasPaginaUnoPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    datosPaso3();
  }

  datosPaso3() async {
    await ce();
    var resp = await actaService.datosPaso3(widget.idActa.toString());
    if(resp["estado_cimentacion"].length != 0){
      await mapearDatos(resp);
      setState(() {
        print(resp);
      });
    }else{
      setState(() {
        loading = false;
      });
    }
    
  }

  mapearDatos(dynamic resp) async {
    estadoCimentacion = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_cimentacion"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_cimentacion"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_cimentacion"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_cimentacion"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_cimentacion"][0]["otros"] == 1? true : false}
    ];

    estadoMuros = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_muros"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_muros"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_muros"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_muros"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_muros"][0]["otros"] == 1? true : false}
    ];

    estadoCerramiento = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_cerramientos"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_cerramientos"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_cerramientos"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_cerramientos"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_cerramientos"][0]["otros"] == 1? true : false}
    ];

    estadoCubierta = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_cubiertas"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_cubiertas"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_cubiertas"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_cubiertas"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_cubiertas"][0]["otros"] == 1? true : false}
    ];

    estadoEstructura = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_estructuras"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_estructuras"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_estructuras"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_estructuras"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_estructuras"][0]["otros"] == 1? true : false}
    ];

    estadoFachada = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_fachadas"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_fachadas"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_fachadas"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_fachadas"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_fachadas"][0]["otros"] == 1? true : false}
    ];

    estadoAndenes = [
      {"name": "GRIETAS Y FISURAS", "isChecked": resp["estado_andenes"][0]["grietas"] == 1? true : false},
      {"name": "HUMEDADES", "isChecked": resp["estado_andenes"][0]["humedades"] == 1? true : false},
      {"name": "HUNDIMIENTOS","isChecked": resp["estado_andenes"][0]["hundimientos"] == 1? true : false},
      {"name": "DESPLAZAMIENTOS", "isChecked": resp["estado_andenes"][0]["desplazamientos"] == 1? true : false},
      {"name": "OTROS", "isChecked": resp["estado_andenes"][0]["otros"] == 1? true : false}
    ];

    otros.text = resp["estado_otros"][0]["observaciones"];
    observacionesAndenes.text = resp["estado_andenes"][0]["observaciones"];
    observacionesCerramiento.text = resp["estado_cerramientos"][0]["observaciones"];
    observacionesCimentacion.text = resp["estado_cimentacion"][0]["observaciones"];
    observacionesCubierta.text = resp["estado_cubiertas"][0]["observaciones"];
    observacionesEstructura.text = resp["estado_estructuras"][0]["observaciones"];
    observacionesFachada.text = resp["estado_fachadas"][0]["observaciones"];
    observacionesMuros.text = resp["estado_muros"][0]["observaciones"];

    loading = false;
  }

  ce () async {
    await Future.delayed(const Duration(milliseconds: 1000), (){ setState(() {
        loading = true;
      }); 
    });
  }
}