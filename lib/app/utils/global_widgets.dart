import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

Widget tituloSinAppBar(String titulo, Color colorTexto) {
    return Center(
      child: Text(titulo,
        textAlign: TextAlign.center,
        style: TextStyle( 
          color: colorTexto, 
          fontSize: 25, 
          fontWeight: FontWeight.bold,
        )
      ),
    );
}

class MyProgressIndicactor extends StatelessWidget {

  final String mensaje;
  final double alto;
  final double ancho;
  final double opacidad;

  const MyProgressIndicactor({
    this.mensaje = 'Espere un momento ...', 
    this.alto = 0.25, 
    this.ancho = 0.8, 
    this.opacidad = 0.2,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.black87.withOpacity(opacidad),
            ),
            height: Get.height * alto,
            width: Get.width * ancho,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(mensaje, style: const TextStyle(color: kTLabelColorProgressIndicator), textAlign: TextAlign.center),
                const SizedBox(height: 20.0),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: kTCpi,
                ),
              ],
            ),
          ),
        );
  }
}

class MyDataNotFoundMessage extends StatelessWidget {

  final String mensaje;
  final Color colorText;

  const MyDataNotFoundMessage({
    this.mensaje = 'No hemos encontrado información para mostrarte !', 
    this.colorText = kTAllLabelsColor,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(mensaje, style: TextStyle(color: colorText), textAlign: TextAlign.center,));
  }
}

class MyCustomErrorMessage extends StatelessWidget {

  final String error;
  final Color colorText;

  const MyCustomErrorMessage({
    this.error = 'Opssss, parece que ocurrió un error !', 
    this.colorText = kTAllLabelsColor,
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(error, style: TextStyle(color: colorText)));
  }
}