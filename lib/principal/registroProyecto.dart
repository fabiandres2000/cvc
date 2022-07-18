// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last
import 'package:cvc/http/proyecto.dart';
import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:motion_toast/motion_toast.dart';

class RegistroProyectoPage extends StatefulWidget {
  const RegistroProyectoPage({Key? key}) : super(key: key);
  @override
  State<RegistroProyectoPage> createState() => _RegistroProyectoPageState();
}

class _RegistroProyectoPageState extends State<RegistroProyectoPage> {
  
  bool loading = false;
  ProyectoHttp proyectoService = ProyectoHttp();

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

  TextEditingController ubic =  TextEditingController();
  TextEditingController nombre =  TextEditingController();
  TextEditingController contrato =  TextEditingController();
  TextEditingController interventoria =  TextEditingController();

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Container(
                    height: size.height / 5,
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Image.asset("assets/img/cvc.png"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    heightFactor: 3,
                    child: Text(
                      "Registro de proyecto",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 42),
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 50,
                          decoration: decoration,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: nombre,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: 'Nombre del proyecto'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 50,
                          decoration: decoration,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: ubic,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: 'Ubicación del proyecto'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 50,
                          decoration: decoration,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: contrato,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: 'Contrato de obra Nº'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 50,
                          decoration: decoration,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: interventoria,
                                decoration: InputDecoration(
                                    border: InputBorder.none, hintText: 'Contrato de interventoria Nº'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,),
                        child: Container(
                          width: double.infinity,
                          child: MaterialButton(
                            color:  Color.fromRGBO(44,52,76, 1) ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              //side: BorderSide(color: Colors.red)
                            ),
                            onPressed: () {
                              registrarProyecto(context);
                            },
                            child: Text(
                              "Guardar",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(236,172,20, 1)
                              ),
                            ),
                            height: 50,
                          ),
                        ),
                      ),
                    ]
                  )
                ]
              )
            )
          )
        )
      )
    );
  }

  registrarProyecto(BuildContext context) async {
    setState(() {
      loading = true;
    });
    var res = await proyectoService.registrarProyecto(nombre.text, ubic.text, contrato.text, interventoria.text);
    var guardado = res["guardado"];
    _mensaje(context, guardado);
  }

  _mensaje(BuildContext context, bool res){
    setState(() {
      loading = false;
    });

    MotionToast(
      primaryColor: res? Colors.green: Colors.red,
      description: res? Text("Proyecto registrado correctamente."): Text("Ocurrio un error, intente nuevamente."),
      icon: res ? Icons.check: Icons.error,
    ).show(context);

  }
}