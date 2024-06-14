import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:url_launcher/url_launcher.dart';

import '../data/models/preferencias_de_usuario_model.dart';

NumberFormat numberFormatN0 = NumberFormat("#,##0", "es_AR");
NumberFormat numberFormat = NumberFormat("#,##0.00", "es_AR");
NumberFormat litrosFormat = NumberFormat("#,###", "es_AR");
DateFormat dateFormatDMY = DateFormat('dd/MM/yyyy');
DateFormat dateFormatDM = DateFormat('dd MMM', 'es_AR');

class EstadisticasDeUso {

  static void send(String accion) {

    if (Constants.usaLicenciamiento  && !Constants.urlBase.toLowerCase().contains("peperina"))
      {
        //*-- aviso a sitio de licencia
        try {
          //*-- dio Sitio de Licencias
          Dio dioLicenseControl = Dio(BaseOptions(baseUrl: Constants.urlApiLicenseControl));
          dioLicenseControl.post("LicenseControl/accion", 
                            data: { 
                              "idbasededatos": 10040, 
                              "app": Constants.appLicenseName,
                              "urlApi": "${Constants.urlBase}Login/Login.aspx", 
                              "logo": "${Constants.urlBase}images/NexoByteLogo.JPG", 
                              "userName": '${PreferenciasDeUsuarioStorage.nombre}, ${PreferenciasDeUsuarioStorage.apellido}', 
                              "userEmail": PreferenciasDeUsuarioStorage.email, 
                              "userApeNom": '${PreferenciasDeUsuarioStorage.nombre}, ${PreferenciasDeUsuarioStorage.apellido}',  
                              "accion": accion,
                            },
                            options: Options(contentType: Headers.formUrlEncodedContentType)
                          );
        } catch (e) { }
      }
  }
}

class Utils {

    static String convertirImporteALetras2(double importe)
    {
        String dec;            
           
        var entero = importe.toInt();
        var decimales = ((importe - entero) * 100).toInt();
        if (decimales > 0)
        {
            dec = " PESOS ${decimales.toString()} /100";
        }
        else
        {
            dec = " PESOS ${decimales.toString()} /100";
        }
        var res = numeroALetras(double.parse(entero.toString())) + dec;
        return res;
    }

    static String numeroALetras(double value)
    {
        String num2Text; 
        int value2 = value.truncate();
        if (value2 == 0)       { num2Text = "CERO"; }
        else if (value2 == 1)  { num2Text = "UNO"; }
        else if (value2 == 2)  { num2Text = "DOS"; }
        else if (value2 == 3)  { num2Text = "TRES"; }
        else if (value2 == 4)  { num2Text = "CUATRO"; }
        else if (value2 == 5)  { num2Text = "CINCO"; }
        else if (value2 == 6)  { num2Text = "SEIS"; }
        else if (value2 == 7)  { num2Text = "SIETE"; }
        else if (value2 == 8)  { num2Text = "OCHO"; }
        else if (value2 == 9)  { num2Text = "NUEVE"; }
        else if (value2 == 10) { num2Text = "DIEZ"; }
        else if (value2 == 11) { num2Text = "ONCE"; }
        else if (value2 == 12) { num2Text = "DOCE"; }
        else if (value2 == 13) { num2Text = "TRECE"; }
        else if (value2 == 14) { num2Text = "CATORCE"; }
        else if (value2 == 15) { num2Text = "QUINCE"; }
        else if (value2 < 20)  { num2Text = "DIECI" + numeroALetras(value - 10); }
        else if (value2 == 20) { num2Text = "VEINTE"; }
        else if (value2 < 30)  { num2Text = "VEINTI" + numeroALetras(value - 20); }
        else if (value2 == 30) { num2Text = "TREINTA"; }
        else if (value2 == 40) { num2Text = "CUARENTA"; }
        else if (value2 == 50) { num2Text = "CINCUENTA"; }
        else if (value2 == 60) { num2Text = "SESENTA"; }
        else if (value2 == 70) { num2Text = "SETENTA"; }
        else if (value2 == 80) { num2Text = "OCHENTA"; }
        else if (value2 == 90) { num2Text = "NOVENTA"; }
        else if (value2 < 100) { num2Text = numeroALetras((value/10).truncate() * 10) + " Y " + numeroALetras(value % 10); }
        else if (value == 100)  { num2Text = "CIEN"; }
        else if (value < 200)   { num2Text = "CIENTO " + numeroALetras(value - 100); }
        else if ((value == 200) || (value == 300) || (value == 400) || (value == 600) || (value == 800)) { num2Text = numeroALetras((value / 100).truncateToDouble()) + "CIENTOS"; }
        else if (value == 500)  { num2Text = "QUINIENTOS"; }
        else if (value == 700)  { num2Text = "SETECIENTOS"; }
        else if (value == 900)  { num2Text = "NOVECIENTOS"; }
        else if (value < 1000)  { num2Text = numeroALetras((value / 100).truncate() * 100) + " " + numeroALetras(value % 100); }
        else if (value == 1000) { num2Text = "MIL"; }
        else if (value < 2000)  { num2Text = "MIL " + numeroALetras(value % 1000); }
        else if (value < 1000000)
        {
            num2Text = numeroALetras((value / 1000).truncateToDouble()) + " MIL";
            if ((value % 1000) > 0)
            {
                num2Text = num2Text + " " + numeroALetras(value % 1000);
            }
        }
        else if (value == 1000000)
        {
            num2Text = "UN MILLON";
        }
        else if (value < 2000000)
        {
            num2Text = "UN MILLON " + numeroALetras(value % 1000000);
        }
        else if (value < 1000000000000)
        {
            num2Text = numeroALetras((value / 1000000).truncateToDouble()) + " MILLONES ";
            if ((value - (value / 1000000).truncate() * 1000000) > 0)
            {
                num2Text = num2Text + " " + numeroALetras(value - (value / 1000000).truncate() * 1000000);
            }
        }
        else if (value == 1000000000000) { num2Text = "UN BILLON"; }
        else if (value < 2000000000000)  { num2Text = "UN BILLON " + numeroALetras(value - (value.truncate() / 1000000000000) * 1000000000000); }
        else
        {
            num2Text = numeroALetras((value / 1000000000000).truncateToDouble()) + " BILLONES";
            if ((value - (value / 1000000000000).truncate() * 1000000000000) > 0)
            {
                num2Text = num2Text + " " + numeroALetras(value - (value / 1000000000000).truncate() * 1000000000000);
            }
        }
        return num2Text;
    }

}

class Tambos {
  
  static Widget showHeaderTamboDetail(CtaCteLecheResumenDeLitrosMesItem item) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: showTuberculosisBrucelosis(item),
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: kTCircleAvatarBackgroundColor,
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8), // Border radius
                              child: ClipOval(
                                  child: Image.asset(Constants.kImgTambos)),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.tambo,
                                    style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: kTLabelEspecieResumenHome)),
                                const SizedBox(height: 3.0),
                                Wrap(
                                  children: [
                                    Text(
                                        "${litrosFormat.format(item.totalLeche)}  lts",
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: kTLabelEspecieResumenHome)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                      child: Text("(${item.mes})",
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                              color: kTLabelEspecieResumenHome)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }

  static Widget showHeaderTambo(CtaCteLecheResumenDeLitrosMesItem item, bool showAlertas) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.rDetalleEntregasDeLeche, arguments: item),
            child: Card(
                color: kTBackgroundBtnHome,
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CircleAvatar(backgroundColor:kTCircleAvatarBackgroundColor,
                                        radius: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8), // Border radius
                                          child: ClipOval(
                                              child: Image.asset(
                                                  Constants.kImgTambos)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.tambo, style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kTLabelEspecieResumenHome)),
                                            const SizedBox(height: 3.0),
                                            Wrap(
                                              children: [
                                                Text(
                                                    "${numberFormat.format(item.totalLeche)}  lts",
                                                    style: const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            kTLabelResumenHome)),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                                  child: Text("(${item.mes})",
                                                      style: const TextStyle(
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                          color: kTLabelEspecieResumenHome)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      showAlertas
                          ? crearTablaDeAlertas(item)
                          : const SizedBox(height: 1),
                      const SizedBox(height: 10),
                      showTuberculosisBrucelosis(item),
                      const SizedBox(height: 20),
                      showEstadisticaDeListrosUltimosMeses(item),
                      const SizedBox(height: 10),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            //*------------------------------------------------------ Detalle de entregas
                            ActionChip(
                              label: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Ver detalle de entregas', style: TextStyle(fontSize: 14.0)),
                                ],
                              ),
                              labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                              onPressed: () => Get.toNamed(AppRoutes.rDetalleEntregasDeLeche, arguments: item),
                              backgroundColor: Colors.white70,
                              shape: const StadiumBorder(
                                side: BorderSide(width: 1, color: Colors.grey),
                              ),
                              elevation: 5.0,
                            ),
                            const SizedBox(height: 3.0),
                            //*------------------------------------------------------ Ver Liquidaciones
                            ActionChip(
                              label: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text('Ver  Liquidaciones', style: TextStyle(fontSize: 14.0)),
                                  ],
                              ),
                              labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                              onPressed: () => Get.toNamed(AppRoutes.rLiquidacionesLecheLista, arguments: item),
                              backgroundColor: Colors.white70,
                              shape: const StadiumBorder(
                                side: BorderSide(width: 1, color: Colors.grey),
                              ),
                              elevation: 5.0,
                            ),
                            const SizedBox(height: 3.0),
                            //*------------------------------------------------------ Estadisticas
                            ActionChip(
                              label: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Text('Estadísticas', style: TextStyle(fontSize: 14.0)),
                                  ],
                              ),
                              labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                              onPressed: () => Get.toNamed(AppRoutes.rEstadisticasLeche, arguments: item),
                              backgroundColor: Colors.white70,
                              shape: const StadiumBorder(
                                side: BorderSide(width: 1, color: Colors.grey),
                              ),
                              elevation: 5.0,
                            ),
                            const SizedBox(height: 3.0),
                            //*------------------------------------------------------ Subir documentacion Tambo
                            ActionChip(
                              label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Visibility(
                                      visible: item.alertaCertBru.toUpperCase() == 'R' || item.alertaCertBru.toUpperCase() == 'A' ||
                                               item.alertaCertTub.toUpperCase() == 'R' || item.alertaCertTub.toUpperCase() == 'A',
                                      child: const Expanded(
                                        child: TextScroll(
                                          'Tienes certificados VENCIDOS o PROXIMOS a VENCER.    Súbelos desde AQUI !',
                                          style: TextStyle(color: kTRedColor),
                                          intervalSpaces: 10,
                                          velocity: Velocity(pixelsPerSecond: Offset(60, 0)),
                                          numberOfReps: 100,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: item.alertaCertBru.toUpperCase() == 'V' && item.alertaCertTub.toUpperCase() == 'V',
                                      child: const Text('Subir Certificados', style: TextStyle(fontSize: 14.0)),
                                    )
                                  ],
                              ),
                              labelStyle: const TextStyle(fontSize: 13, color: Colors.black45),
                              onPressed: () => Get.toNamed(AppRoutes.rUploadCertPaso1, arguments: item),
                              backgroundColor: Colors.white70,
                              shape: const StadiumBorder(
                                side: BorderSide(width: 1, color: Colors.grey),
                              ),
                              elevation: 5.0,
                            ),
                            const SizedBox(height: 3.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ])))));
  }

  static Widget showEstadisticaDeListrosUltimosMeses(CtaCteLecheResumenDeLitrosMesItem item) {

    return item.listaDeEstadisticasMensuales.isNotEmpty
      ? showEstadistica(item)
      : const SizedBox(height: 0);
  }

  static Widget showEstadistica(CtaCteLecheResumenDeLitrosMesItem item) {
    
    //-- Incializa el format string
    initializeDateFormatting();
    
    List<EstadisticaMensualTamboItem> listaDeEstadisticas = item.listaDeEstadisticasMensuales;

    double _valorBase = 0;

    return Column(
      children: [
        const Divider(),
        const Text('Resumen  mensual  de  Entregas', style: TextStyle(color: kTLabelResumenHome, fontWeight: FontWeight.bold, fontSize: 15)),
        const Divider(),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listaDeEstadisticas.length,
          itemBuilder: (context, i) { 

            _valorBase = i == 0 ? listaDeEstadisticas[0].totalLitros : listaDeEstadisticas[i-1].totalLitros;    

            //debugPrint(i.toString());

            return GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.rDetalleEntregasDeLeche, arguments: item),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMM("es").format(listaDeEstadisticas[i].dia).toUpperCase(),style: const TextStyle(fontSize: 13.0, color: kTLabelResumenHome)),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${litrosFormat.format(listaDeEstadisticas[i].totalLitros)}  lts",
                            style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, 
                            color: listaDeEstadisticas[i].totalLitros >= _valorBase 
                              ? kTImporteAFavor
                              : kTImporteEnContra)),
                          const SizedBox(width: 15),
                          Text(i == 0
                                ? ''
                                : listaDeEstadisticas[i].totalLitros >= _valorBase
                                    ? " + ${ litrosFormat.format(listaDeEstadisticas[i].totalLitros - _valorBase) } lts"
                                    : " - ${ litrosFormat.format(_valorBase - listaDeEstadisticas[i].totalLitros) } lts",
                              style: TextStyle(fontSize: 13.5, color: listaDeEstadisticas[i].totalLitros >= _valorBase 
                              ? kTImporteAFavor
                              : kTImporteEnContra),    
                          )
                        ],
                      ),
                    ),
                    //const SizedBox(width: 20),
                    //Icon(Icons.visibility_rounded, size: 20, color: kTAllLabelsColor.withOpacity(0.7)),
                  ],
                ),
              ),
            );
            
          
          }
        ),
      ],
    );
  }

  static Widget showTuberculosisBrucelosis(CtaCteLecheResumenDeLitrosMesItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'BRUCELOSIS  ${item.brucelosis}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = getColorBrucelosisOTuberculosis(item.brucelosis)!
                    ..strokeWidth = 15
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: item.brucelosis.contains('LIBRE') ? Colors.white : Colors.black54,
                  )),
              ),
              const Expanded(flex: 1, child: SizedBox(width: 1)),
              Expanded(
                flex: 5,
                child: Text(
                  'TUBER.  ${item.tuberculosis}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = getColorBrucelosisOTuberculosis(item.tuberculosis)!
                    ..strokeWidth = 15
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: item.tuberculosis.contains('LIBRE') ? Colors.white : Colors.black54,
                  )),
              ),
            ]
          ),
          const SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              flex: 5,
              child: Text(
                  'Cert. BRU. ' + getTextoAlertaBrucelosisOTuberculosis(item.alertaCertBru),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = getColorAlertaBrucelosisOTuberculosis(item.alertaCertBru)!
                    ..strokeWidth = 15
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: item.alertaCertBru == 'A' ? Colors.black54 : Colors.white,
                  )),
            ),
            const Expanded(flex: 1, child: SizedBox(width: 1)),
            Expanded(
              flex: 5,
              child: Text(
                  'Cert. TUB. ' + getTextoAlertaBrucelosisOTuberculosis(item.alertaCertTub),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = getColorAlertaBrucelosisOTuberculosis(item.alertaCertTub)!
                    ..strokeWidth = 15
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: item.alertaCertTub == 'A' ? Colors.black54 : Colors.white,
                  ))
            ),
          ]),
        ],
      ),
    );
  }

  static String getTextoAlertaBrucelosisOTuberculosis(String alerta) {
    if (alerta.toUpperCase() == "V") {
      return "Vigente";
    } else if (alerta.toUpperCase() == "R") {
      return "VENCIDO";
    } else if (alerta.toUpperCase() == "A") {
      return "Vence pronto";
    } else {
      return '';
    }
  }

  static Color? getColorAlertaBrucelosisOTuberculosis(String alerta) {
    Color returnValue = Colors.black;
    if (alerta.toUpperCase() == "V") {
      returnValue = kTLibre.withOpacity(0.7);
    } else if (alerta.toUpperCase() == "R") {
      returnValue = kTNo_Libre.withOpacity(0.7);
    } else if (alerta.toUpperCase() == "A") {
      returnValue = kTEn_Saneamiento.withOpacity(0.7);
    }
    return returnValue;
  }

  static Color getColorAlertasByLetra(String alerta) {
    Color returnValue = Colors.black;
    if (alerta.toUpperCase() == "V") {
      returnValue = kTLibre.withOpacity(0.7);
    } else if (alerta.toUpperCase() == "R") {
      returnValue = kTNo_Libre.withOpacity(0.7);
    } else if (alerta.toUpperCase() == "A") {
      returnValue = kTEn_Saneamiento.withOpacity(0.7);
    }
    return returnValue;
  }

  static Color? getColorBrucelosisOTuberculosis(
      String libreNoLibreEnSaneamiento) {
    Color returnValue = Colors.black;
    if (libreNoLibreEnSaneamiento.toUpperCase() == "LIBRE") {
      returnValue = kTLibre;
    } else if (libreNoLibreEnSaneamiento.toUpperCase() == "NO LIBRE") {
      returnValue = kTNo_Libre;
    } else if (libreNoLibreEnSaneamiento.toUpperCase() == "EN SANEAMIENTO") {
      returnValue = kTEn_Saneamiento;
    }
    return returnValue;
  }

  static Widget crearTablaDeAlertas(CtaCteLecheResumenDeLitrosMesItem item) {
    if (item.listaDeAlertasAnalisisOficiales.isNotEmpty) {
      List<TableRow> listaDeTableRowsAlertas = [];
      listaDeTableRowsAlertas.assign(crearAlertaHeader());

      item.listaDeAlertasAnalisisOficiales.map((alerta) {
        listaDeTableRowsAlertas.add(crearAlerta(alerta));
      }).toList();

      return Table(children: listaDeTableRowsAlertas);
    } else {
      return const Text(
          "No hemos encontrado muestras oficiales para mostrarte !",
          style: TextStyle(color: kTLabelEspecieResumenHome, fontSize: 12));
    }
  }

  static Widget crearTablaDeAlertaEsMuestraOficial(EntregaLecheItem item,  [Color color = Colors.white54]) {
    List<TableRow> listaDeTableRowsAlertas = [];
    listaDeTableRowsAlertas.assign(crearAlertaHeader(color));

    listaDeTableRowsAlertas.add(crearAlertaMuestraOficial(item));

    return Table(children: listaDeTableRowsAlertas);
  }

  static Widget crearMuestraOficialConValores(EntregaLecheItem item,
      [Color color = Colors.white54]) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            crearTextTitulos(
                "Valores de la muestra oficial", kTAllLabelsColor, 15),
            const SizedBox(height: 10.0),
            Table(children: [
              TableRow(children: [
                crearTextTitulos("Fecha", kTAllLabelsColor, 13),
                crearTextTitulos(item.fecha.toString(), kTAllLabelsColor, 13),
                const SizedBox(width: 1.0),
              ]),
              TableRow(children: [
                crearTextTitulos("Grasa Butirosa", kTAllLabelsColor, 13),
                crearTextTitulos(
                    item.grasaButirosa.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.grasaButirosaAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("Proteinas", kTAllLabelsColor, 13),
                crearTextTitulos(
                    item.proteinas.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.proteinasAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("UFC", kTAllLabelsColor, 13),
                crearTextTitulos(item.ufc.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.ufcAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("RCS", kTAllLabelsColor, 13),
                crearTextTitulos(item.rcs.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.rcsAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("Inhibidores", kTAllLabelsColor, 13),
                crearTextTitulos(
                    item.inhibidores.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.inhibidoresAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("Crioscopia", kTAllLabelsColor, 13),
                crearTextTitulos(
                    item.crioscopia.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.crioscopiaAlerta),
              ]),
              TableRow(children: [
                crearTextTitulos("Temperatura", kTAllLabelsColor, 13),
                crearTextTitulos(
                    item.temperatura.toString(), kTAllLabelsColor, 13),
                crearAlertaSemaforo(item.temperaturaAlerta),
              ]),
            ]),
          ],
        ));
  }

  static Widget crearTextTitulos(String label,
      [Color color = Colors.white54, double fontSize = 12]) {
    return SizedBox(
      height: 20,
      child: RotatedBox(
          quarterTurns: 180,
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontSize: fontSize))),
    );
  }

  static Widget crearAlertaSemaforo(String label) {
    Widget _child = Container();
    if (label.toUpperCase() == 'R') {
      _child =
          const Icon(Icons.brightness_1_rounded, color: kSemaforoR, size: 13.0);
    } else if (label.toUpperCase() == 'A') {
      _child =
          const Icon(Icons.brightness_1_rounded, color: kSemaforoA, size: 13.0);
    } else if (label.toUpperCase() == 'V') {
      _child =
          const Icon(Icons.brightness_1_rounded, color: kSemaforoV, size: 13.0);
    }
    return _child;
  }

  static TableRow crearAlertaMuestraOficial(EntregaLecheItem alerta) {
    final DateFormat format = DateFormat('dd-MM');
    final String formatted = format.format(alerta.fecha);

    return TableRow(children: [
      Text(formatted,
          style: const TextStyle(fontSize: 10.0, color: kTAllLabelsColor)),
      crearAlertaSemaforo(alerta.grasaButirosaAlerta),
      crearAlertaSemaforo(alerta.proteinasAlerta),
      crearAlertaSemaforo(alerta.ufcAlerta),
      crearAlertaSemaforo(alerta.rcsAlerta),
      crearAlertaSemaforo(alerta.inhibidoresAlerta),
      crearAlertaSemaforo(alerta.crioscopiaAlerta),
      crearAlertaSemaforo(alerta.temperaturaAlerta),
    ]);
  }

  static TableRow crearAlerta(AlertaAnalisisOficialItem alerta) {
    final DateFormat format = DateFormat('dd-MM');
    final String formatted = format.format(alerta.fecha);

    return TableRow(children: [
      Text(formatted,
          style: const TextStyle(fontSize: 10.0, color: kTAllLabelsColor)),
      crearAlertaSemaforo(alerta.grasaButirosaAlerta),
      crearAlertaSemaforo(alerta.proteinasAlerta),
      crearAlertaSemaforo(alerta.ufcAlerta),
      crearAlertaSemaforo(alerta.rcsAlerta),
      crearAlertaSemaforo(alerta.inhibidoresAlerta),
      crearAlertaSemaforo(alerta.crioscopiaAlerta),
      crearAlertaSemaforo(alerta.temperaturaAlerta),
    ]);
  }

  static TableRow crearAlertaHeader([Color color = kTAllLabelsColor]) {
    return TableRow(children: [
      const SizedBox(width: 30),
      crearTextTitulos('GB', color),
      crearTextTitulos('Prot', color),
      crearTextTitulos('UFC', color),
      crearTextTitulos('RCS', color),
      crearTextTitulos('Inh', color),
      crearTextTitulos('Crio', color),
      crearTextTitulos('Tem', color),
    ]);
  }
}

class Utilidades {
  static String getPlatform() {
    String _platform = "";
    if (Platform.isIOS) _platform = "IOS";
    if (Platform.isAndroid) _platform = "ANDROID";
    return _platform;
  }

  static openwhatsapp(context) async {
    var whatsapp = "+549" + Constants.telWhatsapp;
    var whatsappUrlAndroid = "whatsapp://send?phone=" + whatsapp;
    var whatappUrlIOS = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappUrlIOS))) {
          await launchUrl(
            Uri.parse(whatappUrlIOS),
            mode: LaunchMode.externalApplication
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp no instalado")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappUrlAndroid))) {
        await launchUrl(
                Uri.parse(whatsappUrlAndroid), 
                mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp no instalado")));
      }
    }
  }

  static Future<String> loadFromAsset(String assetsKey) async {
    return await rootBundle.loadString(assetsKey);
  }

  static String? isValidEmailRequired(String? value) {
    if (value == null) return null;
    if (value.trim().isEmpty) {
      return '     El Email es obligatorio!';
    } else if (!GetUtils.isEmail(value)) {
      return '     Email mal formado!';
    } else {
      return null;
    }
  }

  static String? isValidEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Email mal formado!';
    } else {
      return null;
    }
  }

  static bool isValidPhone(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static String? obligatorio(String? value) {
    if (value == null) return null;
    if (value.trim().isEmpty) {
      return "Dato obligatorio!";
    } else {
      //- retornando null pasa la validacion
      return null;
    }
  }

  static String? noObligatorio(String value) =>
      null; //- retornando null pasa la validacion

}

class MyDialog {
  static Future<void> myShowDialog({String titulo = '', String mensaje = ''}) {
    return Get.dialog(AlertDialog(
      title: Text(
        titulo,
        style: const TextStyle(color: kErrorBackColor),
      ),
      titleTextStyle: const TextStyle(fontSize: 16.0, color: kTRedColor),
      content: Text(mensaje, style: const TextStyle(fontSize: 14.0)),
      actions: [
        TextButton(
            style: kTButtonStyle,
            child: const Text("Cerrar"),
            onPressed: () {
              Get.back();
            }),
      ],
    ));
  }

  static Future<void> myShowDialogDisabledBack(
      {String titulo = '', String mensaje = ''}) {
    //?----------------------------------------------------------------------------------------
    //?--- Evitamos el back !!
    //?----------------------------------------------------------------------------------------
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () => Future.value(false),
              child: const AlertDialog(
                backgroundColor: kTScaffoldBackColor,
                title: Center(
                    child: Text("Aguarda un instante ...",
                        style: TextStyle(fontSize: 15.0))),
                content: SingleChildScrollView(child: Center(child: kTCpi)),
              ));
        });
  }

  //-- ADD 2.1
  static Future<void> myDialogNewVersion(
      {String titulo = 'NUEVA VERSION DISPONIBLE',
      @required String? url,
      @required String? versionActual,
      @required String? versionNueva}) async {
    //?----------------------------------------------------------------------------------------
    //?--- Evitamos el back !!
    //?----------------------------------------------------------------------------------------
    return showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              backgroundColor: Colors.white.withAlpha(240),
              title: Text(titulo,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400)),
              content: Column(
                children: [
                  Text(
                      'Te recomendamos DESINSTALAR la versión actual e INSTALAR la nueva versión!\nSi no lo haces, podrías experimentar inconvenientes en el funcionamiento de la App.\n\nTu versión actual es $versionActual y la nueva es $versionNueva !',
                      style: const TextStyle(
                          fontSize: 15.0, color: Colors.black87)),
                  const SizedBox(height: 30.0),
                  Text(
                      'IMPORTANTE:\n\nUna vez instalada la nueva versión, deberás ingresar con tu Email y Contraseña. Si no recuerdas en este momento tu contraseña, podemos asignarte una ahora mismo seleccionando (Enviarme 123456)',
                      style: TextStyle(color: Colors.red.shade400))
                ],
              ),
              actions: [
                TextButton(
                    child: const Text('Enviarme 123456',
                        style: TextStyle(color: Colors.black87)),
                    onPressed: () async => await Get.toNamed(
                        AppRoutes.rEnviar123456,
                        arguments: url)),
                TextButton(
                    child: const Text('Actualizar Versión',
                        style: TextStyle(color: Colors.black87)),
                    onPressed: () => openPlayStore(url: url)),
                TextButton(
                    child: const Text('NO Actualizar',
                        style: TextStyle(color: Colors.black87)),
                    onPressed: () => Get.offAllNamed(AppRoutes.rRedirect)),
              ],
            ),
          );
        });
  }

  static openPlayStore({@required String? url}) async {
    //-- 33
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication
      );
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(",")) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

class ValUtils {
  static bool strToBool(String str) {
    return (int.parse(str) > 0) ? true : false;
  }

  static bool intToBool(int val) {
    return (val > 0) ? true : false;
  }

  static String boolToStr(bool val) {
    return (val == true) ? "1" : "0";
  }

  static int boolToInt(bool val) {
    return (val == true) ? 1 : 0;
  }
}

class MyDateUtils {
  static DateTime? convertDMYToYMD(String dmy) {
    try {
      var inputFormat = DateFormat("dd/MM/yyyy");
      var date1 = inputFormat.parse(dmy);

      var outputFormat = DateFormat("yyyy-MM-dd");
      var date2String = outputFormat.format(date1);

      var d = convertToDateYMD(date2String);
      return d;
    } catch (e) {
      return null;
    }
  }

  static DateTime? convertDMYToDMY(String dmy) {
    try {
      var inputFormat = DateFormat("dd/MM/yyyy");
      var d = inputFormat.parse(dmy);
      return d;
    } catch (e) {
      return null;
    }
  }

  static DateTime? convertToDateYMD(String input) {
    try {
      var d = DateFormat("yyyy-MM-dd").parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  static String? convertToDateFull(String input) {
    try {
      var d = DateFormat("yyyy-MM-dd").parseStrict(input);
      var formatter = DateFormat('dd MMM yyyy', 'es');
      return formatter.format(d);
    } catch (e) {
      return null;
    }
  }

  static String? convertToCustomDatePattern(DateTime? input, String pattern) {
    try {
      var formatter = DateFormat(pattern, 'es');
      return input == null ? '' : formatter.format(input);
    } catch (e) {
      return null;
    }
  }

  static String? convertToDateFullDt(DateTime input) {
    try {
      var formatter = DateFormat('dd MMM yyyy', 'es');
      return formatter.format(input);
    } catch (e) {
      return null;
    }
  }

  static String? convertToDateFullDthm(DateTime? input) {
    try {
      var formatter = DateFormat('E dd MMMM yyyy HH:mm', 'es');
      return input == null ? '' : formatter.format(input);
    } catch (e) {
      return null;
    }
  }

  static bool isDate(String dt) {
    try {
      DateFormat("yyyy-MM-dd").parseStrict(dt);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidDate(String dt) {
    if (dt.isEmpty || !dt.contains("-") || dt.length < 10) return false;
    List<String> dtItems = dt.split("-");
    var d = DateTime(
        int.parse(dtItems[0]), int.parse(dtItems[1]), int.parse(dtItems[2]));
    return isDate(dt) && d.isAfter(DateTime.now());
  }

  // String functions
  static String daysAheadAsStr(int daysAhead) {
    var now = DateTime.now();
    DateTime ft = now.add(Duration(days: daysAhead));
    return ftDateAsStr(ft);
  }

  static String ftDateAsStr(DateTime ft) {
    return ft.year.toString() +
        "-" +
        ft.month.toString().padLeft(2, "0") +
        "-" +
        ft.day.toString().padLeft(2, "0");
  }

  static String trimDate(String dt) {
    if (dt.contains(" ")) {
      List<String> p = dt.split(" ");
      return p[0];
    } else {
      return dt;
    }
  }

  //*------------------------------------------------------------------------------------------------------ Selector de fechas
  static Future<DateTime?> selectDate(BuildContext _context, DateTime? _initialDate, DateTime _firstDate, DateTime _lastDate, String _helpText) async {
  
    DateTime _inicial = _initialDate ??= DateTime.now();

    final DateTime? picked = await showDatePicker(
        locale: const Locale('es', ''),
        context: _context,
        initialDate: _inicial,
        firstDate: _firstDate,
        lastDate: _lastDate,
        helpText: _helpText.isEmpty ? 'SELECCIONE LA FECHA' : _helpText,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: kTDatePickerPrimary, // header background color
                onPrimary: kTDatePickerOnPrimary, // header text color
                onSurface: kTDatePickerOnSurface, // body text colory text color
              ),
              dialogTheme: const DialogTheme(
                backgroundColor: kTDatePickerOnPrimary
              ),
              textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: kTDatePickerButtons)),
            ),
            child: child!,
          );
        });

    return picked;
  }

}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

//!-- Add 2.6
extension ListUtils<T> on List<T> {
  num sumBy(num Function(T element) f) {
    num sum = 0;
    for(var item in this) {
      sum += f(item);
    }
    return sum;
  }
}

class RoundedContainer extends StatelessWidget {

  final Color colorBackGround;
  final String texto;
  final double fontSize;

  const RoundedContainer(
    this.colorBackGround, 
    this.texto,
    {
      this.fontSize = 13.0,
      Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
      decoration: BoxDecoration(
        color: colorBackGround,
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 10),
        child: Center(child: Text(texto, textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold))),
      )
  );
  }
}