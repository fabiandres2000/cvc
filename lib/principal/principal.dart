// ignore_for_file: prefer_const_constructors
import 'package:cvc/principal/proyectos.dart';
import 'package:cvc/principal/registroProyecto.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProyectosPage(),
    RegistroProyectoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar : true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(44,52,80, 1),
        title: Container(
          padding: EdgeInsets.only(left: 30),
          child: Text(""),
        ),
      ),
      body: _children[_currentIndex],
      drawer: Drawer(  
        child: ListView(   
          padding: EdgeInsets.zero,  
          children: <Widget>[  
            UserAccountsDrawerHeader (  
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient:  const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 1.0),
                  colors:  <Color>[
                    Color.fromRGBO(4,4,4,1),
                    Color.fromRGBO(4,4,4,1),
                  ],
                  tileMode: TileMode.repeated, 
                )
              ),
              accountName: Text("Usuario: Prueba"),  
              accountEmail: Text("E-mail: 1234@gmail.com"),  
              currentAccountPicture: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/img/logo.png",
                  )
                ],
              ),
              currentAccountPictureSize: Size(220, 90),
            ),  
            ListTile(  
              leading: Icon(Icons.home), 
              title: Text("Proyectos"),  
              onTap: () {  
                Navigator.pop(context);
                onTabTapped(0);
              },  
            ), 
            ListTile(  
              leading: Icon(Icons.app_registration), 
              title: Text("Registrar Proyecto"),  
              onTap: () {  
                Navigator.pop(context);
                onTabTapped(1);
              },  
            ),  
          ],  
        ),  
      ),
    );
  }

   void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}