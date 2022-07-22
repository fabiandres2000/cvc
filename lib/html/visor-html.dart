
import 'dart:io';
import 'package:cvc/acta-vecindad/actas.dart';
import 'package:cvc/components/bouncy.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class WebViewExample extends StatefulWidget {
  final int idActa;
  final int idProyecto;
  const WebViewExample({Key? key, required this.idActa, required this.idProyecto}) : super(key: key);
  @override
  State<WebViewExample> createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text("Información del acta de vecindad", style: TextStyle(color: Color.fromRGBO(236,172,20, 1), fontSize: 30)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )
        ),
        body: WebView(
        initialUrl: 'https://cvc.lecsidesarrollos.com.co/cvc-web/acta.html?id='+widget.idActa.toString()+'&id_proyecto='+widget.idProyecto.toString(),
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}