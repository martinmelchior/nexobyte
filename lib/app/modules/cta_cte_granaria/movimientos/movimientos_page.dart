import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/utils.dart';
import "package:intl/intl.dart";

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'movimientos_controller.dart';


class MovimientosPage extends GetView<MovimientosController> {

  const MovimientosPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        bottom: PreferredSize(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: ShowHeaderCtaCteGranaria(header: controller.itemCtaCteProductorEspecieCosechaItem),
          height: 169.0),
          preferredSize: const Size.fromHeight(162.0),
        ),
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: const Text("Movimientos", style: TextStyle(fontSize: 18, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: controller.obx(
              (state)=> Stack(children: [
                ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.dataShowed.listaDetalleCtaCteGranariaItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ShowDetalleCtaCteGranaria(
                        detalleCtaCteGranariaItem: controller.dataShowed.listaDetalleCtaCteGranariaItem[index],
                        registro: index);
                  },
                  separatorBuilder: (BuildContext context, int index) => Container()
                ),
                Obx(() => Visibility(
                  visible: controller.loading.value && controller.request.pageNro > 1,
                      child: const Column(
                        children: [
                          Expanded(child: SizedBox()),
                          SizedBox(
                            width: double.infinity,
                            child: Center(child: kTLpi)),
                        ],
                      ),
                    )),
            ]),
            onLoading: const MyProgressIndicactor(mensaje: 'Buscando movimientos de la cuenta !'),
            onEmpty: const MyDataNotFoundMessage(),
            onError: (error) => MyCustomErrorMessage(error: error.toString()),
          ),
      );
  }
}




// * -------------------------------------------------------------------------------------------------- SHOW HEADER CTA CTE GRANARIA
class ShowHeaderCtaCteGranaria extends StatelessWidget {
  
  final CtaCteProductorEspecieCosechaItem header;

  const ShowHeaderCtaCteGranaria(
      {Key? key, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 7.0, left: 7.0, top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          // * ----------------------- PRODUCTOR Y EMPRESA
          Text(header.productor, style: const TextStyle(fontSize: 16.0, color: kTClientesLabelsColor, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2.0),
          Text(header.empresa, style: const TextStyle(fontSize: 12.0, color: kTClientesLabelsColor)),
          const SizedBox(height: 8.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                backgroundColor: kTCircleAvatarBackgroundColor,
                radius: 30,
                backgroundImage: AssetImage('assets/img/${header.especie.trim().toString().toLowerCase().replaceAll(' ', '_')}.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${header.especie.trim()}   ${header.cosecha}', style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kTLabelEspecieResumenHome)),
                    const SizedBox(height: 3.0),
                    Text("${numberFormat.format(header.disponibleKgs)}  Kgs", style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTLabelEspeciePrecio)),
                    const SizedBox(height: 3.0),
                    Text("${numberFormat.format(header.disponibleTn)}  TN", style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTLabelEspeciePrecio)),
                    const SizedBox(height: 3.0),
                  ],
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- SHOW LISTVIEW CTA CTE GRANARIA
// ignore: must_be_immutable
class ShowDetalleCtaCteGranaria extends StatelessWidget {
  
  DetalleCtaCteGranariaItem detalleCtaCteGranariaItem;
  int registro = 0;

  ShowDetalleCtaCteGranaria({
    Key? key,
    required this.detalleCtaCteGranariaItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detalleCtaCteGranariaItem.cartaPorteId < 0
                  ? ShowVenta(detalleCtaCteGranariaItem: detalleCtaCteGranariaItem)
                  : ShowCP(detalleCtaCteGranariaItem: detalleCtaCteGranariaItem),
              ],
            ),
        ),
    );
  }
}

class ShowCP extends StatelessWidget {

  final DetalleCtaCteGranariaItem detalleCtaCteGranariaItem;
  
  final MovimientosController controller = Get.find<MovimientosController>();

  ShowCP({Key? key, required this.detalleCtaCteGranariaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat("dd-MM-yyyy").format(detalleCtaCteGranariaItem.fecha), style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                        const SizedBox(height: 2.0),
                        Text('${detalleCtaCteGranariaItem.comprobanteRespaldo} ${detalleCtaCteGranariaItem.nro}', style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                    //!-- ADD 3.6
                    //*--------------------------------------------------------------------- boton VER PDF del comprobante
                    Visibility(
                      visible:  detalleCtaCteGranariaItem.imagenCPEID != '' && detalleCtaCteGranariaItem.imagenCPEID != null,                            
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        child: GestureDetector(
                          child: Image.asset(Constants.kImgPDF, width: 30, height: 30),
                          onTap: () async {
                            await Get.toNamed(AppRoutes.rVerComprobante, 
                                              arguments: DownloadComprobanteRequest(
                                                  tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
                                                  gEconomicoId: controller.request.gEconomicoId,
                                                  empresaId: controller.request.empresaId,
                                                  guidComprobante: detalleCtaCteGranariaItem.imagenCPEID,
                                                  ctaCteId: null,
                                                  tituloPage: "Carta Porte\n${detalleCtaCteGranariaItem.nro}",
                                                  comprobanteAliasName: "CP ${detalleCtaCteGranariaItem.nro}",
                                                )
                                              );
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                //* ---------------------------------------------------- PROCEDENCIA
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/img/point.png', width: 20.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${detalleCtaCteGranariaItem.provinciaProcedencia.capitalize}  |  ${detalleCtaCteGranariaItem.localidadProcedencia.capitalize}  |  ${detalleCtaCteGranariaItem.campoProcedencia.capitalize}", 
                            style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ],
                ),
              
                //* ---------------------------------------------------- CHOFER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset('assets/img/driver.png', width: 18.0),
                    ),
                    const SizedBox(width: 10.0),
                    Text("${detalleCtaCteGranariaItem.nombreChofer.capitalize}  -  ${detalleCtaCteGranariaItem.patente}", style: const TextStyle(fontSize: 12.0, color: Colors.black54))
                  ],
                ),
                const SizedBox(height: 8.0),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("${numberFormat.format(detalleCtaCteGranariaItem.importe)} KG", 
                                    style: TextStyle(fontSize: 15.0, color: detalleCtaCteGranariaItem.importe < 0 ? kTImporteEnContra : kTImporteAFavor))),
                        Text("${numberFormat.format(detalleCtaCteGranariaItem.saldo)} KG", 
                          style: TextStyle(fontSize: 15.0, color: detalleCtaCteGranariaItem.saldo < 0 ? kTImporteEnContra : kTImporteAFavor)),
                      ],
                    ),
                  ],
                ),
              ],
            );
  }
}

class ShowVenta extends StatelessWidget {

  final DetalleCtaCteGranariaItem detalleCtaCteGranariaItem;
  
  const ShowVenta({Key? key, required this.detalleCtaCteGranariaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(DateFormat("dd-MM-yyyy").format(detalleCtaCteGranariaItem.fecha), style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                const SizedBox(height: 2.0),
                Text('${detalleCtaCteGranariaItem.comprobanteRespaldo} ${detalleCtaCteGranariaItem.nroCert}', style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                const SizedBox(height: 8.0),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("${numberFormat.format(detalleCtaCteGranariaItem.importe)} KG", 
                                    style: TextStyle(fontSize: 15.0, color: detalleCtaCteGranariaItem.importe < 0 ? kTImporteEnContra : kTImporteAFavor))),
                        Text("${numberFormat.format(detalleCtaCteGranariaItem.saldo)} KG", 
                          style: TextStyle(fontSize: 15.0, color: detalleCtaCteGranariaItem.saldo < 0 ? kTImporteEnContra : kTImporteAFavor)),
                      ],
                    ),
                  ],
                ),
              ],
            );
  }
}








