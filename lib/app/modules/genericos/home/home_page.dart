import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:nexobyte/app/modules/adelantos/utils/adelanto_constants.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/cereales/cotizacion_cereales_page.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/monedas/cotizacion_monedas_page.dart';
import 'package:nexobyte/app/modules/genericos/drawer/drawer_usuario.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  
  const HomePage({Key? key}) : super(key: key);
  
   //------------------------------------------------------------------------------------------------- _crearBoton
  Widget _crearBoton( String assetImage, String label, double _fontSize, {double iconSize = 65}) {
    return Card(
        color: kTBackgroundBtnHome,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: Get.width * 0.33,
            child: Column(
              children: [
                Image.asset(assetImage, width: iconSize, height: iconSize),
                const SizedBox(height: 10.0),
                Text(label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _fontSize,
                        //fontWeight: FontWeight.bold,
                        color: kTLabelBtnHome)),
              ],
            ),
          ),
        ),
    );
  }
  
  Widget _showMenu() {

    List<Widget> listaW = [];
    if (controller.applicationSettingsController.appShowServicioCtaCte.value) { listaW.add(_btnCtaCte()); }
    //-- ADD 3.2
    if (controller.applicationSettingsController.appShowSolicitudDeAdelantos.value) { listaW.add(_btnAdelantos()); }
    if (controller.applicationSettingsController.appShowServicioCtaCteDolares.value) { listaW.add(_btnCtaCteDolar()); }
    if (controller.applicationSettingsController.appShowServicioOLIngeniero.value) { listaW.add(_btnOLIngenieros()); }
    if (controller.applicationSettingsController.appShowServicioOLContratista.value) { listaW.add(_btnOLAContratistas()); }
    if (controller.applicationSettingsController.appShowServicioCtaCteGranaria.value) { listaW.add(_btnCtaCteGranaria()); }
    //-- ADD 3.4
    if (controller.applicationSettingsController.appShowAnalisisDeMani.value) { listaW.add(_btnAnalisisDeMani()); }
    if (controller.applicationSettingsController.appShowServicioLecheria.value) { listaW.add(_btnLecheria()); }
    if (controller.applicationSettingsController.appShowServicioPosiciones.value) { listaW.add(_btnPosiciones()); }
    if (controller.applicationSettingsController.appShowServicioVendedor.value) { listaW.add(_btnMisClientes()); }
    //-- ADD 3.2
    if (controller.applicationSettingsController.appShowSolicitudDeAdelantos.value) { listaW.add(_btnAgendaCbu()); }
    //-- v4.0 BEGIN
    //*-- Comprobantes PENDIENTES
    if (controller.applicationSettingsController.showReporteDeComprobantesPendientes.value)
    {
      //*--- por ahora solo visible para clientes !
      if (controller.applicationSettingsController.verTodasLasCCEnComprobantesPendientes.value == false && 
          controller.applicationSettingsController.appShowServicioCtaCte.value) 
      { 
        listaW.add(_btnComprobantesPendientes()); 
      }
    }
    //*-- Facturas en RESERVA
    if (controller.applicationSettingsController.showReporteDeFacurasEnReservas.value)
    {
      //*--- por ahora solo visible para clientes !
      if (controller.applicationSettingsController.verTodasLasCCEnComprobantesPendientes.value == false && 
          controller.applicationSettingsController.appShowServicioCtaCte.value) 
      { 
        listaW.add(_btnArticulosPendientes()); 
      }
    }
    //-- v4.0 END

    //-- v4.1
    if (PreferenciasDeUsuarioStorage.enviarUbicacion) { listaW.add(_btnUbicacion()); }

    //-- v4.5 BEGIN
    //*-- Comprobantes PENDIENTES
    if (controller.applicationSettingsController.showRemitosSinFacturarPrecioActualValorizadoDolar.value)
    {
      //*--- por ahora solo visible para clientes !
      if (controller.applicationSettingsController.verTodasLasCCEnComprobantesPendientes.value == false && 
          controller.applicationSettingsController.appShowServicioCtaCte.value) 
      { 
        listaW.add(_btnUsaRemitosSinFacturarPrecioActualValorizadoDolar()); 
      }
    }
    //-- v4.5 END

    listaW.add(_btnFeedback());
    
    if (listaW.isEmpty) listaW.add(const Center(child: Text('Parece que aún no te han habilitado servicios!', style: TextStyle(color: kTAllLabelsColor))));

    Wrap w = Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 15,
      runSpacing: 15,
      children: listaW,
    );

    return w;
  }  

  //-- v4.5 BEGIN
  _btnUsaRemitosSinFacturarPrecioActualValorizadoDolar() {
    return GestureDetector(
      child: _crearBoton(Constants.kRemitosPendientes, "Remitos Pendientes de Facturar", 13, iconSize: 40.0),
      onTap: () => Get.toNamed(AppRoutes.rRemitosSinFacturaFiltroClientes),
    );
  }
  //-- v4.5 END

  //-- v4.0 BEGIN
  _btnComprobantesPendientes() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgCompPendientes, "Comprobantes Pendientes", 13.5),
      onTap: () => Get.toNamed(AppRoutes.rCompPendFiltroClientes),
    );
  }
  _btnArticulosPendientes() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgArtiPendientes, "Artículos Pendientes de Remitar", 13, iconSize: 47.0),
      onTap: () => Get.toNamed(AppRoutes.rFacturaReservaFiltroClientes),
    );
  }
  //-- v4.0 END

  //-- v4.1 
  _btnUbicacion() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgUbicacion, "Mi Ubicación", 13),
      onTap: () async {
        await controller.tomarUbicacionYEnviarla();
        Get.showSnackbar(const GetSnackBar(
                          title: 'Gracias por compartir tu ubicación',
                          message: 'Apenas tengamos cargas cercanas, te avisaremos !',
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 5)));
      },
    );
  }


  _btnMisClientes() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgMisClientesVEN, "Mis Clientes", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rCtacteResumenClienteVEN),
    );
  }
  _btnFeedback() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgFeedback, "Ayuda", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rEnviarFeedback),
    );
  }
  _btnCtaCte() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgCtaCte, "Cta Cte", 14.5),
      //-- ADD 2.2
      onTap: () => Get.toNamed(AppRoutes.rCtacteResumenCliente, arguments: { "enDolares": false }),
    );
  }
  //-- ADD 3.2
  Widget _btnAdelantos() {
      return GestureDetector(
        child: _crearBoton(AdelantoConstants.kImgAdelantos, "Solicitud de\n Adelantos", 13),
        onTap: () => Get.toNamed(AppRoutes.rCtacteResumenCliente, arguments: { "enDolares": false }),
      );
  }
  //-- ADD 2.2
  _btnCtaCteDolar() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgCtaCteDolar, "Cta Cte USD", 14.5),
      //-- ADD 2.2
      onTap: () => Get.toNamed(AppRoutes.rCtacteResumenCliente, arguments: { "enDolares": true }),
    );
  }
  _btnCtaCteGranaria() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgCtaCteGranos, "Granos", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rCtacteGranariaResumenPEC),
    );
  }
  _btnLecheria() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgTambos, "Mis Tambos", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rResumenEntregasDeLeche),
    );
  }
  _btnOLAContratistas() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgOLA, "Gestión Agraria", 13.5),
      onTap: () => Get.toNamed(AppRoutes.rResumenOLContratista),
    );
  }
  _btnOLIngenieros() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgIOL, "Gestión Agraria", 13.5),
      onTap: () => Get.toNamed(AppRoutes.rResumenOLIngenieros),
    );
  }
  _btnPosiciones() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgPOS, "Mis Posiciones", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rPOSUsuarioResumen),
    );
  }
  Widget _btnAgendaCbu() {
    return GestureDetector(
      child: _crearBoton(AdelantoConstants.kImgAgenda1, "Agenda CBU", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rAgendaCbuLista, arguments: { 'tipoDeCuenta': TipoDeCuenta.todas.toValueText }),
    );
  }
  Widget _btnAnalisisDeMani() {
    return GestureDetector(
      child: _crearBoton(Constants.kImgAnalisisMani, "Análisis de Mani", 14.5),
      onTap: () => Get.toNamed(AppRoutes.rResumenAnalisisLista),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kTScaffoldBackColorHome,
      drawer: const DrawerUsuario(),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 20.0,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: kTappLogo,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Padding(padding: EdgeInsets.only(right: 25.0), child: Icon(Icons.notifications)),
            onPressed: () => Get.toNamed(AppRoutes.rNotificaciones),
          )
        ],
      ),
      body: Stack(children: [
        kTBackgroundContainer,
        Visibility(
          visible: Constants.urlBase.contains(Constants.kUrlContaintTesting),
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: const Banner(
              message: ' TESTING ',
              color: Colors.green,
              location: BannerLocation.topEnd,
              textStyle: TextStyle(fontSize: 14),
            ))),
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Obx(() => _showMenu())
                          ),
                          const SizedBox(height: 30.0),
                          //!--------------------------------------- RESUMEN GRANOS
                          // Obx(() => Visibility(
                          //     visible: controller.applicationSettingsController
                          //             .appShowServicioCtaCteGranaria.value &&
                          //         controller
                          //             .saldosEspeciesController
                          //             .saldosPorEspecieResponse
                          //             .value
                          //             .listaDeSaldosPorEspecie
                          //             .isNotEmpty,
                          //     child: const CtaCteGranariaConsolidaEspecieWidget())),
                          // const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ],
                )
              ),
            ),
            //-- ADD 2.4
            Obx(() => Visibility(
              visible: controller.listaCotizacionCereal.isNotEmpty,
              child: CotizacionCerealesWidget(controller.listaCotizacionCereal),
            )),
            Obx(() => Visibility(
              visible: controller.listaCotizacionMoneda.isNotEmpty,
              child: SizedBox(child: CotizacionMonedaWidget(controller.listaCotizacionMoneda), height: 50,),
              )
            ),
          ],
        ),
          
      ]),
    );
  }
}
