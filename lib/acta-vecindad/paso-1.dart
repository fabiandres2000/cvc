import 'dart:io';
import 'dart:convert';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/acta-vecindad/paso-2.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/acta.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class PasoUnoPage extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const PasoUnoPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<PasoUnoPage> createState() => _PasoUnoPageState();
}

class _PasoUnoPageState extends State<PasoUnoPage> {
  
  bool loading = false;
  
  final ImagePicker imagePicker = ImagePicker();

  List<String> bases64 = [];

  ActaHttp actaService = ActaHttp();

  @override
  Widget build(BuildContext context) {
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
          leading: bases64.length != 0 ? Container() : IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("1.REGISTRO FOTOGRAFICO DE FACHADA", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: Center(
          child: GestureDetector(
            onTap: (){
              _showSelectionDialog(context);
            },
            child: bases64.isEmpty ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/img/add_picture.jpg'),
                Text("Seleccione mínimo 6 imagenes", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
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
                        crossAxisCount: 2
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
                          cancelar();
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
                          siguiente();
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
              ],
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             _showSelectionDialog(context);
          },
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          child: const Icon(Icons.add_a_photo, color: Color.fromRGBO(236,172,20, 1)),
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
      });
  }

 
  @override
  void initState() {
    super.initState();
    listarRegistros();
  }

  listarRegistros() async {
    await ce();
    var result = await actaService.registrosFotograficos(widget.idActa.toString());
    result = result["registros"];
    if(result.length > 0){
      setState(() {
        for (var element in result) {
          bases64.add(element["base64"]);
        }
        loading = false;
      });
    }else{
      setState(() {
        loading = false;
      });
    }
  }

  ce () async {
    await Future.delayed(const Duration(milliseconds: 1000), (){ setState(() {
        loading = true;
      }); 
    });
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

  cancelar() {
    Navigator.push(
      context,
      BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
    );
  }

  siguiente() async {
    if(bases64.length < 6){
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Mínimo debe adjuntar 6 imagenes."),
        icon: Icons.cancel,
      ).show(context);
    }else{
      setState(() {
        loading = true;
      });
      await actaService.registrarPaso1(bases64, widget.idActa);
      setState(() {
        loading = false;
      });
      Navigator.push(
        context,
        BouncyPageRoute(widget: PasoDosPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
      );
    }
    
    
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
}