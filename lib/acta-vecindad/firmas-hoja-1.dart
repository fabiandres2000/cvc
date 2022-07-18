import 'dart:typed_data';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/acta-vecindad/paso-3.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/acta.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:signature/signature.dart';
import 'dart:convert';


class FirmasPaginaUnoPage extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const FirmasPaginaUnoPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<FirmasPaginaUnoPage> createState() => _FirmasPaginaUnoPageState();
}

class _FirmasPaginaUnoPageState extends State<FirmasPaginaUnoPage> {
  
  bool loading = false;
  bool bandera = false;
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
  ActaHttp actaService = ActaHttp();
  
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
            child: Text("FIRMAS", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(20), 
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(padding: EdgeInsets.only(left: 20) ,child: Text("NOTA: SE DEJA CONSTANCIA QUE LO CONSIGNADO EN LA PRESENTE ACTA CORRESPONDE A LA REALIDAD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
              SizedBox(height: 20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bandera == false ?Signature(
                      controller: controller,
                      width: 350,
                      height: 200,
                      backgroundColor: Colors.grey[200]!,
                    ): Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Image.memory(base64Decode(firmasGuardadas[0]["firmaRUS"]), fit: BoxFit.contain),
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
                              enabled: bandera == true ? false: true,
                              keyboardType: TextInputType.text,
                              controller: nombreUS,
                              decoration: InputDecoration(border: InputBorder.none, hintText: 'RESPONSABLE UNIDAD SOCIAL'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("__________________________________________________________"),
                    Text("FIRMA RESPONSABLE UNIDAD SOCIAL")
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bandera == false ?Signature(
                      controller: controller2,
                      width: 350,
                      height: 200,
                      backgroundColor: Colors.grey[200]!,
                    ): Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Image.memory(base64Decode(firmasGuardadas[0]["firmaCO"]), fit: BoxFit.contain),
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
                              enabled: bandera == true ? false: true,
                              keyboardType: TextInputType.text,
                              controller: nombreUS2,
                              decoration: InputDecoration(border: InputBorder.none, hintText: 'REPRESENTANTE DEL CONTRATISTA'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("__________________________________________________________"),
                    Text("FIRMA REPRESENTANTE DEL CONTRATISTA")
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bandera == false ?Signature(
                      controller: controller3,
                      width: 350,
                      height: 200,
                      backgroundColor: Colors.grey[200]!,
                    ): Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Image.memory(base64Decode(firmasGuardadas[0]["firmaRI"]), fit: BoxFit.contain),
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
                              enabled: bandera == true ? false: true,
                              keyboardType: TextInputType.text,
                              controller: nombreUS3,
                              decoration: InputDecoration(border: InputBorder.none, hintText: 'REPRESENTANTE DE LA INTERVENTORIA'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("__________________________________________________________"),
                    Text("REPRESENTANTE DE LA INTERVENTORIA")
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   bandera == false ?Signature(
                      controller: controller4,
                      width: 350,
                      height: 200,
                      backgroundColor: Colors.grey[200]!,
                    ): Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      height: 200,
                      child: Image.memory(base64Decode(firmasGuardadas[0]["firmaTE"]), fit: BoxFit.contain),
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
                              enabled: bandera == true ? false: true,
                              keyboardType: TextInputType.text,
                              controller: nombreUS4,
                              decoration: InputDecoration(border: InputBorder.none, hintText: 'TESTIGO'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text("__________________________________________________________"),
                    Text("FIRMA TESTIGO")
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
                        Navigator.push(
                          context,
                          BouncyPageRoute(widget: PasoTresPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
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
                        guardarFirmas();
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
            ])
          )
        )
      )
    );
  }

  guardarFirmas() async {
    if(bandera == false){
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

      var res = await actaService.registrarFirmas(widget.idActa , firmaRUS, firmaCO, firmaRI, firmaTE, nombreUS.text, nombreUS2.text, nombreUS3.text, nombreUS4.text);

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
    }else{
      Navigator.push(
        context,
        BouncyPageRoute(widget: ActasPage(idProyecto: widget.idProyecto))
      );
    }
  }

  @override
  void initState() {
    super.initState();
    firmas();
  }

  firmas() async {
    await ce();
    var res = await actaService.firmas(widget.idActa.toString());
    if(res["firmas"].length != 0){
      setState(() {
        bandera = true;
        firmasGuardadas = res["firmas"];
        nombreUS.text = res["firmas"][0]["nombreRUS"];
        nombreUS2.text = res["firmas"][0]["nombreCO"];
        nombreUS3.text = res["firmas"][0]["nombreRI"];
        nombreUS4.text = res["firmas"][0]["nombreTE"];
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
}