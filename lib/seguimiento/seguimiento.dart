import 'dart:io';
import 'dart:convert';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class SeguimientoPage extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const SeguimientoPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<SeguimientoPage> createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  
  bool loading = false;
  final ImagePicker imagePicker = ImagePicker();
  List<String> bases64 = [];
  SeguimientoHttp seguimientoService = SeguimientoHttp();

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

  List<dynamic> partesCasa = ["0","PISOS","PAREDES","TECHO","BAÑO","COCINA"]; 
  List<dynamic> tiposSeguimiento = ["0","ANTES","DESPUES"]; 
  String parteCasa = "0";
  String tipoSeguimiento = "0";
  TextEditingController observaciones = TextEditingController();

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
            onPressed: () {
              Navigator.push(
                context,
                BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
              );
            },
          ),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("REGISTRO FOTOGRAFICO Y/0 FILMICO EN MEDIO MAGNÉTICO", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.50) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: parteCasa,
                            items: partesCasa.isNotEmpty
                                ? partesCasa
                                    .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == "0" ? "Seleccione la parte de la casa": value),
                                    );
                                  }).toList()
                                : [
                                    DropdownMenuItem(
                                      child: Text("SELECCIONE UN DEPARTAMENTO"),
                                      value: "0",
                                    ),
                                  ],
                            onChanged: (value) {
                              setState(() {
                                parteCasa = value!;
                                datosSeguimiento();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.50) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: tipoSeguimiento,
                            items: tiposSeguimiento.isNotEmpty
                                ? tiposSeguimiento
                                    .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == "0" ? "Seleccione el tipo de seguimiento": value),
                                    );
                                  }).toList()
                                : [
                                    DropdownMenuItem(
                                      child: Text("SELECCIONE UN DEPARTAMENTO"),
                                      value: "0",
                                    ),
                                  ],
                            onChanged: (value) {
                              setState(() {
                                tipoSeguimiento = value!;
                                datosSeguimiento();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
               SizedBox(height: 10),
              Center(
                child: Text("OBSERVACIONES: ESCRIBIR LO REFERENTE AL SEGUIMIENTO Y/O CIERRE", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1))), 
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                child:  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container (
                    padding: EdgeInsets.all(10),
                    height: 250,
                    decoration: decoration,
                    child: TextField(
                      maxLines: 8,
                      controller: observaciones,
                      decoration: InputDecoration.collapsed(hintText: "Texto..."),
                    ),
                  )
                ),
              ),
              Container(
                width: size.width,
                height: 650,
                padding:  EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: (){
                    _showSelectionDialog(context);
                  },
                  child: bases64.isEmpty ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/img/add_picture.jpg'),
                      Text("Seleccione 2 imagenes", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ) : Column(
                    children: [
                      SizedBox(height: 20,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            itemCount: bases64.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 15, left: 7, right: 7),
                                    child: Image.memory(base64Decode(bases64[index]), fit: BoxFit.cover)
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 13,
                                    child: GestureDetector(
                                      onTap: (){
                                        eliminarFoto(index);
                                      },
                                      child: Container(
                                        child: Icon(Icons.delete, color: Colors.white),
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 4, color: Colors.white),
                                          color: Colors.red,
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                    ) 
                                  )
                                ],
                              );
                            }
                          ),
                        )
                      )
                    ]
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
                            BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
                          );
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
                                child: Text("Cancelar", style: TextStyle(color: Color.fromRGBO(44,52,76, 1))),
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
                          guardarSeguimiento();
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
            ]
          )
        )
      )
    );
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione de donde tomar la imagen"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.image_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Galeria"),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    selectImages();
                  },
                ),
                Divider(),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Camara"),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _openCamera();
                  },
                )
              ],
            ),
          )
        );
      }
    );
  }

   void selectImages() async {
    List<XFile> imageFileList = [];
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }

    for (var element in imageFileList) {
      final bytes = File(element.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      bases64.add(img64);
    }
    
    setState(() {
      
    });
  }

  _openCamera() async {
    final XFile? picture = await imagePicker.pickImage(source: ImageSource.camera);
    final bytes = File(picture!.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    bases64.add(img64);
    setState(() {});
  }

   eliminarFoto(int index) {
    setState(() {
      loading = true;
    });
    bases64.removeAt(index);
    setState(() {
      loading = false;
    });
  }

  guardarSeguimiento() async {
    if (bases64.length != 2) {
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Debe seleccionar 2 imagenes"),
        icon: Icons.cancel,
      ).show(context);
    }else{
      if(tipoSeguimiento != "0" && parteCasa != "0"){
        setState(() {
          loading = true;
        });
        var res = await seguimientoService.registrarSeguimiento(bases64, widget.idActa, parteCasa, tipoSeguimiento, observaciones.text);
        setState(() {
          loading = false;
        });
        if(res == null){
          MotionToast(
            primaryColor: Colors.red,
            description: Text("Ocurrio un error, intente nuevamente."),
            icon: Icons.cancel,
          ).show(context);
        }else{
          MotionToast(
            primaryColor: Colors.green,
            description: Text("Seguimiento registrado correctamente."),
            icon: Icons.check,
          ).show(context);
          limpiarCampos();
        }
      }else{
        MotionToast(
          primaryColor: Colors.red,
          description: Text("Todos los campos son obligatorios"),
          icon: Icons.cancel,
        ).show(context);
      }
    }
  }

  limpiarCampos() {
    setState(() {
      bases64 = [];
      parteCasa = "0";
      tipoSeguimiento = "0";
      observaciones.text = "";
    });
  }

  datosSeguimiento() async {
    setState(() {
      loading = true;
    });
    if(tipoSeguimiento != "0" && parteCasa != "0"){
      var res = await seguimientoService.detalleSeguimiento(widget.idActa.toString(), parteCasa, tipoSeguimiento);
      res = res["seguimiento"];
      if(res != null){
        mapearDatos(res);
      }else{
        bases64 = [];
        observaciones.text = "";
        setState(() {
          loading = false;
        });
      }   
    }else{
      setState(() {
        loading = false;
      });
    }
  }

  mapearDatos(dynamic res) {
    bases64 = [];
    setState(() {
      observaciones.text = res["observaciones"];
      for (var element in res["detalles"]) {
        bases64.add(element["imagen"]);
      }
      loading = false;
    });
  }
}