import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/http/seguimiento.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class EstadoSeguimientoPage extends StatefulWidget {
  final int idActa;
  const EstadoSeguimientoPage({Key? key, required this.idActa}) : super(key: key);
  @override
  State<EstadoSeguimientoPage> createState() => _EstadoSeguimientoPageState();
}

class _EstadoSeguimientoPageState extends State<EstadoSeguimientoPage> {
  
  bool loading = false;
  SeguimientoHttp seguimientoService = SeguimientoHttp();
  dynamic objetoEstado;

   SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

   SignatureController controller2 = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

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
            child: Text("ESTADO DE SEGUIMIENTO", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: Center(
          child: Column(children: <Widget>[  
            Container(  
              margin: EdgeInsets.all(20),  
              child: Column(
                children: [
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
                          objetoEstado["cocinaAntes"] == 0?
                            Icon(Icons.close, color: Colors.red)
                          : Icon(Icons.check, color: Colors.green)
                        : Center()
                      ]),   
                    ]),  
                  ]),
                  SizedBox(height: 40),
                  objetoEstado != null ?
                    objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 || objetoEstado["pisosAntes"] == 1 ?
                    Column(
                      children: [
                        Center(child: Container(padding: EdgeInsets.only(left: 20) ,child: Text("NOTA: SE DEJA CONSTANCIA QUE LO CONSIGNADO EN LA PRESENTE ACTA CORRESPONDE A LA REALIDAD", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1))))),
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
                                  Text("__________________________________________________________"),
                                  Text("REPRESENTANTE DE LA INTERVENTORIA")
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
                                  Text("__________________________________________________________"),
                                  Text("FIRMA TESTIGO")
                                ],
                              ),
                            ],
                          ),
                        ) 
                      ],
                    ): Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        padding:EdgeInsets.all(20),
                        color: Colors.red[300],
                        height: 200,
                      )
                    )
                  : Center()
                ],
              )   
            )    
          ])
        )
      )
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
  }

  ce () async {
    await Future.delayed(const Duration(milliseconds: 1000), (){ setState(() {
        loading = true;
      }); 
    });
  }
}