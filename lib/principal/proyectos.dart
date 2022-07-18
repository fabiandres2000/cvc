// ignore_for_file: prefer_const_constructors
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/proyecto.dart';
import 'package:flutter/material.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({Key? key}) : super(key: key);
  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  List proyectos = List.empty();
  bool loading = false;
  ProyectoHttp proyectoService = ProyectoHttp();

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
          leading: Container(),
          elevation: 1,
          backgroundColor: Color.fromRGBO(44,52,76, 1),
          title: Center(
            child: Text("Proyectos registrados", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 30)),
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
                    proyectos.isNotEmpty ? Container(
                      padding: EdgeInsets.only(bottom: 70),
                      color: Colors.transparent,
                      height: size.height - size.height * 0.1,
                      child: ListView.builder(
                        itemCount: proyectos.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return itemCard(proyectos[index], (index+1).toString());
                        }
                      )
                    ): Container(),
                  ]
                )
              )
            )
          )
      )
    );
  }

  Widget itemCard(dynamic item, String index){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          BouncyPageRoute(widget: ActasPage(idProyecto: item["id"]))
        ); 
      },
      child: Container(
        height: 170.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Container(
              height: 174.0,
              width: 680,
              margin: EdgeInsets.only(left: 52.0),
              padding: EdgeInsets.only(top: 25, left: 80),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item["nombre"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Ubic : ${item["ubic"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Contrato de obra N° : ${item["numero_contrato_obra"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Contrato de interventoria N° : ${item["numero_contrato_interventoria"]}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
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
              height: 132,
              margin:  EdgeInsets.symmetric(vertical: 30.0),
              child: Center(
                child: Text(index, style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontWeight: FontWeight.bold, fontSize: 30))
              ),
            )
          ],
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    consultarProyectos();
  }

  consultarProyectos() async {
    await ce();
    var response = await proyectoService.proyectosRegistrados();
    proyectos = List.empty();
    setState(() {
      proyectos = response["proyectos"];
      loading = false;
    });
  }

  ce() async {
    await Future.delayed(const Duration(milliseconds: 1000), (){ setState(() {
        loading = true;
      }); 
    });
  }
}