import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/acta-vecindad/paso-1.dart';
import 'package:cvc/acta-vecindad/paso-3.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:cvc/http/acta.dart';
import 'package:cvc/http/utils.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:iconsax/iconsax.dart';

class PasoDosPage extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const PasoDosPage({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<PasoDosPage> createState() => _PasoDosPageState();
}

class _PasoDosPageState extends State<PasoDosPage> {
  
  bool loading = false;
  ActaHttp actaService = ActaHttp();
  UtilsHttp utilsHttp = UtilsHttp();
  List<dynamic> departamentos = List.empty();
  List<dynamic> municipios = List.empty();
  List<dynamic> barrios = List.empty();
  final List<String> tipoTenenciaData =  ["PROPIETARIO", "ARRENDATARIO", "POSEEDOR", "OTRO CUAL?"];
  final List<String> sino =  ["SI", "NO"];
  final List<String> tiposPredio =  ["RURAL", "URBANO"];
  final List<String> estadosPredio =  ["SIN EDIFICAR", "OBRA GRIS", "TERMINADA"];
  final List<String> pendientesTerreno =  ["ONDULADO", "ESCARPADO", "PLANO"];
  final List<String> usosActual1 =  ["RESIDENCIAL", "COMERCIAL", "INDUSTRIAL", "INSTITUCIONAL O DEL ESTADO"];
  final List<String> usosActual2 =  ["AGROPECUARIO", "RECREACIONAL", "BALDIO", "SALUBRIDAD"];
  final List<String> usosActual3 =  ["CULTURAL (EDUCACION, CULTO RELIGIOSO)", "MIXTO", "MINERO", "OTRO"];

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

  TextEditingController nombreReponsable =  TextEditingController();
  TextEditingController nombrePropietario =  TextEditingController();
  TextEditingController cedula =  TextEditingController();
  TextEditingController telefono =  TextEditingController();
  TextEditingController direccion =  TextEditingController();
  TextEditingController numeroPisos =  TextEditingController();
  TextEditingController sector =  TextEditingController();
  TextEditingController observaciones =  TextEditingController();
  String departamento = "0";
  String municipio = "0";
  String barrio = "0";
  String tipoTenencia = '';
  String acueducto = '';
  String alcantarillado = '';
  String energia = '';
  String telefonos = '';
  String gas = '';
  String televisionCable = '';
  TextEditingController otrosServicios =  TextEditingController();
  String tipoPredio = '';
  String estadoPredio = '';
  String conLicencia = '';
  String pendienteTerreno = '';
  String usoActual = '';
  String garaje= '';
  String usoGaraje = '';
  
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
            child: Text("2.DATOS DEL PREDIO", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 20)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: Container(
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombreReponsable,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'NOMBRE DEL JEFE DEL HOGAR O RESPONSABLE DEL PREDIO'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(padding: EdgeInsets.only(left: 40) ,child: Text("¿TIPO DE TENENCIA?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Column(
                  children: <Widget>[
                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: tipoTenencia,
                      horizontalAlignment: MainAxisAlignment.spaceAround,
                      onChanged: (value) => setState(() {
                        tipoTenencia = value!;
                      }),
                      items: tipoTenenciaData,
                      textStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[600]
                      ),
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,  
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: nombrePropietario,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'NOMBRE DEL PROPIETARIO'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.635) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: cedula,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'CEDULA DE CIUDADANIA'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 0, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.635) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: telefono,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'TELEFONO'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 0, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.635) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: numeroPisos,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'No DE PISOS'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 40, right: 35, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: direccion,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'DIRECCION'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                            value: departamento,
                            items: departamentos.isNotEmpty
                                ? departamentos
                                    .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['codigo'].toString(),
                                      child: Text(value['descripcion']),
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
                                departamento = value!;
                                listarMunicipios();
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
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: municipio,
                            items: municipios.isNotEmpty
                                ? municipios
                                    .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['codmun'].toString(),
                                      child: Text(value['descripcion']),
                                    );
                                  }).toList()
                                : [
                                    DropdownMenuItem(
                                      child: Text("SELECCIONE UN MUNICIPIO"),
                                      value: "0",
                                    ),
                                  ],
                            onChanged: (value) {
                              setState(() {
                                municipio = value!;
                                listarBarrios();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 20),
                      child: Container(
                        height: 50,
                        width: size.width - (size.width * 0.60) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: sector,
                            decoration: InputDecoration(border: InputBorder.none, hintText: 'SECTOR'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 40, right: 0, bottom: 20),
                      child:  Container(
                        height: 50,
                        width: size.width - (size.width * 0.458) - 75,
                        decoration: decoration,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            isExpanded: true,
                            underline: SizedBox(),
                            value: barrio,
                            items: barrios.isNotEmpty
                                ? barrios
                                    .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['id'].toString(),
                                      child: Text(value['nombre']),
                                    );
                                  }).toList()
                                : [
                                    DropdownMenuItem(
                                      child: Text("SELECCIONE UN BARRIO"),
                                      value: "0",
                                    ),
                                  ],
                            onChanged: (value) {
                              setState(() {
                                barrio = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _onAlertWithCustomContentPressed(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, left: 0, right: 35, bottom: 20),
                        child: Container(
                          height: 50,
                          width: size.width - (size.width * 0.825) - 75,
                          decoration: decoration,
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Icon(
                              Icons.add
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 10),
                Container(padding: EdgeInsets.only(left: 40) ,child: Text("SERVICIOS PUBLICOS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child:Row(
                    children: <Widget>[
                      Container(
                        width: size.width - (size.width*0.6),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                              Text("ACUEDUCTO ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: acueducto,
                                horizontalAlignment: MainAxisAlignment.spaceAround,
                                onChanged: (value) => setState(() {
                                  acueducto = value!;
                                }),
                                items: sino,
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[600]
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,  
                                ),
                              ),
                            ]),
                            SizedBox(width: 20),
                          ],
                        )
                      ),
                      Column(
                        children: [
                          Row(
                            children: <Widget>[
                            Text("ALCANTARILLADOS ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: alcantarillado,
                              horizontalAlignment: MainAxisAlignment.spaceAround,
                              onChanged: (value) => setState(() {
                                alcantarillado = value!;
                              }),
                              items: sino,
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[600]
                              ),
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,  
                              ),
                            ),
                          ]),
                          SizedBox(width: 20),
                        ],
                      ) 
                    ]
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child:Row(
                    children: <Widget>[
                      Container(
                        width: size.width - (size.width*0.6),
                        child:  Column(
                          children: [
                            Row(
                              children: <Widget>[
                              Text("ENERGIA ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: energia,
                                horizontalAlignment: MainAxisAlignment.spaceAround,
                                onChanged: (value) => setState(() {
                                  energia = value!;
                                }),
                                items: sino,
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[600]
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,  
                                ),
                              ),
                            ]),
                            SizedBox(width: 20),
                          ],
                        )
                      ),
                      Column(
                        children: [
                          Row(
                            children: <Widget>[
                            Text("TELEFONOS ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: telefonos,
                              horizontalAlignment: MainAxisAlignment.spaceAround,
                              onChanged: (value) => setState(() {
                                telefonos = value!;
                              }),
                              items: sino,
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[600]
                              ),
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,  
                              ),
                            ),
                          ]),
                          SizedBox(width: 20),
                        ],
                      ) 
                    ]
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child:Row(
                    children: <Widget>[
                      Container(
                        width: size.width - (size.width*0.6),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                              Text("GAS ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: gas,
                                horizontalAlignment: MainAxisAlignment.spaceAround,
                                onChanged: (value) => setState(() {
                                  gas = value!;
                                }),
                                items: sino,
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[600]
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,  
                                ),
                              ),
                            ]),
                            SizedBox(width: 20),
                          ],
                        )
                      ),
                      Column(
                        children: [
                          Row(
                            children: <Widget>[
                            Text("TELEVISION CABLE ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: televisionCable,
                              horizontalAlignment: MainAxisAlignment.spaceAround,
                              onChanged: (value) => setState(() {
                                televisionCable = value!;
                              }),
                              items: sino,
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[600]
                              ),
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,  
                              ),
                            ),
                          ]),
                          SizedBox(width: 20),
                        ],
                      ) 
                    ]
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child:Row(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                              Text("OTROS ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                              SizedBox(width: 20),
                              Container(
                                height: 50,
                                width: size.width - 150,
                                decoration: decoration,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: otrosServicios,
                                    decoration: InputDecoration(border: InputBorder.none, hintText: 'SERVICIOS PRIVADOS'),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(width: 20),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 25, bottom: 10),
                  child: Container (
                    padding: EdgeInsets.only(left: 10, top: 10),
                    height: 200,
                    decoration: decoration,
                    child: TextField(
                      maxLines: 8,
                      controller: observaciones,
                      decoration: InputDecoration.collapsed(hintText: "Observaciones"),
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 20) ,child: Text("TIPO DE PREDIO", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: tipoPredio,
                        horizontalAlignment: MainAxisAlignment.start,
                        onChanged: (value) => setState(() {
                          tipoPredio = value!;
                        }),
                        items: tiposPredio,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 20) ,child: Text("ESTADO DEL PREDIO", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: estadoPredio,
                        horizontalAlignment: MainAxisAlignment.start,
                        onChanged: (value) => setState(() {
                          estadoPredio = value!;
                        }),
                        items: estadosPredio,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 20) ,child: Text("CON LICENCIA DE CONSTRUCCION", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: conLicencia,
                        horizontalAlignment: MainAxisAlignment.start,
                        onChanged: (value) => setState(() {
                          conLicencia = value!;
                        }),
                        items: sino,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Container(padding: EdgeInsets.only(right: 20) ,child: Text("PENDIENTE DEL TERRENO", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: pendienteTerreno,
                        horizontalAlignment: MainAxisAlignment.start,
                        onChanged: (value) => setState(() {
                          pendienteTerreno = value!;
                        }),
                        items: pendientesTerreno,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 10),
                Container(padding: EdgeInsets.only(left: 40) ,child: Text("USO ACTUAL", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: usoActual,
                        horizontalAlignment: MainAxisAlignment.spaceBetween,
                        onChanged: (value) => setState(() {
                          usoActual = value!;
                        }),
                        items: usosActual1,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: usoActual,
                        horizontalAlignment: MainAxisAlignment.spaceBetween,
                        onChanged: (value) => setState(() {
                          usoActual = value!;
                        }),
                        items: usosActual2,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 15, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: usoActual,
                        horizontalAlignment: MainAxisAlignment.spaceBetween,
                        onChanged: (value) => setState(() {
                          usoActual = value!;
                        }),
                        items: usosActual3,
                        textStyle: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600]
                        ),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,  
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 10),
                Container(padding: EdgeInsets.only(left: 40) ,child: Text("ACCESOS VEHICULARES", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(44,52,76, 1)))),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40, right: 15, bottom: 10),
                  child:Row(
                    children: <Widget>[
                      Container(
                        width: size.width - (size.width*0.6),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                              Text("GARAJE ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: garaje,
                                horizontalAlignment: MainAxisAlignment.spaceAround,
                                onChanged: (value) => setState(() {
                                  garaje = value!;
                                }),
                                items: sino,
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[600]
                                ),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,  
                                ),
                              ),
                            ]),
                            SizedBox(width: 20),
                          ],
                        )
                      ),
                      Column(
                        children: [
                          Row(
                            children: <Widget>[
                            Text("USO DEL GARAJE ",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                            RadioGroup<String>.builder(
                              direction: Axis.horizontal,
                              groupValue: usoGaraje,
                              horizontalAlignment: MainAxisAlignment.spaceAround,
                              onChanged: (value) => setState(() {
                                usoGaraje = value!;
                              }),
                              items: sino,
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[600]
                              ),
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,  
                              ),
                            ),
                          ]),
                          SizedBox(width: 20),
                        ],
                      ) 
                    ]
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
                          Navigator.push(
                            context,
                            BouncyPageRoute(widget: PasoUnoPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
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
                          guardarDatos(nombreReponsable.text, nombrePropietario.text, cedula.text, telefono.text, direccion.text, numeroPisos.text, sector.text, observaciones.text, departamento, municipio, barrio, tipoTenencia, acueducto, alcantarillado, energia, telefonos, gas, televisionCable, otrosServicios.text, tipoPredio, estadoPredio, conLicencia, pendienteTerreno, usoActual, garaje, usoGaraje);
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

  @override
  void initState() {
    super.initState();
    listarDepartamentos();
  }

  listarDepartamentos() async {
    await ce();
    var response = await utilsHttp.departamentos();
    setState(() {
      departamentos = response["departamentos"];
    });
    verDatosPredio();
  }

  listarMunicipios() async {
    var response = await utilsHttp.municipios(departamento);
    setState(() {
      municipio = "0";
      municipios = response["municipios"];
    });
  }

  listarBarrios() async {
    var response = await utilsHttp.barrios(municipio);
    setState(() {
      barrio = "0";
      barrios = response["barrios"];
    });
  }

  verDatosPredio() async {
    var response = await actaService.datosPredio(widget.idActa.toString());
    var datos = response["datos"];
    if(datos.length != 0){
      var data = datos[0];
      setState(() {
        nombreReponsable.text = data["nombreReponsable"];
        nombrePropietario.text = data["nombrePropietario"];
        cedula.text = data["cedula"];
        telefono.text = data["telefono"];
        direccion.text = data["direccion"];
        numeroPisos.text = data["numeroPisos"];
        sector.text = data["sector"];
        acueducto = data["acueducto"];
        alcantarillado = data["alcantarillado"];
        energia = data["energia"];
        telefonos = data["telefonos"];
        gas = data["gas"];
        televisionCable = data["televisionCable"];
        otrosServicios.text = data["otrosServicios"];
        observaciones.text = data["observaciones"];
        tipoPredio = data["tipoPredio"];
        estadoPredio = data["estadoPredio"];
        conLicencia = data["conLicencia"];
        pendienteTerreno = data["pendienteTerreno"];
        usoActual = data["usoActual"];
        garaje = data["garaje"];
        usoGaraje = data["usoGaraje"];
        departamento = data["departamento"];
        tipoTenencia = data["tipoTenencia"];
      });
      await listarMunicipios();
      setState(() {
        municipio = data["municipio"];
      });
      await listarBarrios();
      setState(() {
        barrio = data["barrio"];
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
  _onAlertWithCustomContentPressed(context) async {
    TextEditingController nombreBarrio =  TextEditingController();
    Alert(
      context: context,
      title: "Registro de barrio",
      content: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.qr_code_rounded),
                labelText: 'Nombre del barrio',
              ),
              controller: nombreBarrio,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      buttons: [
        DialogButton(
          color: Color.fromRGBO(44,52,76, 1),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            guardarBarrio(nombreBarrio.text);
          },
          child: Text(
            "Guardar",
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
        )
      ]
    ).show();
  }

  guardarBarrio(String nombre) async {
    if(municipio == "0" || departamento=="0"){
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Debe seleccionar un departamento y un municipio"),
        icon: Icons.cancel,
      ).show(context);
    }else{
      setState(() {
        loading = true;
      });
      var resp = await utilsHttp.registrarBarrio(departamento, municipio, nombre);
      print(resp);
      setState(() {
        loading = false;
        if(resp["guardado"] == true){
          MotionToast(
            primaryColor: Colors.green,
            description: Text("Barrio registrado correctamente."),
            icon: Icons.check,
          ).show(context);
          listarBarrios();
        }else{
          MotionToast(
            primaryColor: Colors.red,
            description: Text("Ocurrio un error, intente nuevamente."),
            icon: Icons.cancel,
          ).show(context);
        }
      });
    }
  }

  guardarDatos(String nombreReponsable, String nombrePropietario,String cedula,String telefono,String direccion,String numeroPisos,String sector,String observaciones,String departamento,String municipio,String barrio,String tipoTenencia,String acueducto,String alcantarillado,String energia,String telefonos,String gas,String televisionCable,String otrosServicios,String tipoPredio,String estadoPredio,String conLicencia,String pendienteTerreno,String usoActual,String garaje, String usoGaraje) async {
    setState(() {
      loading = true;
    });
    var resp = await actaService.registrarPaso2(nombreReponsable, nombrePropietario, cedula, telefono, direccion, numeroPisos, sector, observaciones, departamento, municipio, barrio, tipoTenencia, acueducto, alcantarillado, energia, telefonos, gas, televisionCable, otrosServicios, tipoPredio, estadoPredio, conLicencia, pendienteTerreno, usoActual, garaje, usoGaraje, widget.idActa.toString());
   
    setState(() {
    loading = false;
    });

    if(resp == null){
      MotionToast(
        primaryColor: Colors.red,
        description: Text("Ocurrio un error, intente nuevamente."),
        icon: Icons.cancel,
      ).show(context);
    }else{
      Navigator.push(
        context,
        BouncyPageRoute(widget: PasoTresPage(idActa: widget.idActa, idProyecto: widget.idProyecto))
      );
    }
   
  }
}