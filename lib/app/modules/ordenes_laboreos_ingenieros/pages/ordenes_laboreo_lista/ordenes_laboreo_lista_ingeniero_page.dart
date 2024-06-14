import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/utils.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'ordenes_laboreo_lista_ingeniero_controller.dart';

class OrdenesLaboreoListaIngenieroPage extends GetView<OrdenesLaboreoListaIngenieroController> {
  
  int registro = 0;

  OLIngenieroItem? dataItem;

  OrdenesLaboreoListaIngenieroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.add),
          backgroundColor: kTBackgroundColorBtnIngresarLogin,
          foregroundColor: Colors.white,
          onPressed: () async {
            Get.toNamed(AppRoutes.rOlPaso1, arguments: { 
              "requestEARerources": EAResourcesRequest(
                gEconomicoId: controller.request.itemResumenIngeniero!.gEconomicoId,
                empresaId: controller.request.itemResumenIngeniero!.empresaId,
                tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco,
              ), 
              "ordenLaboreoId": -1,
              "itemResumen": controller.request.itemResumenIngeniero
            });
          },
        ),
      backgroundColor: Colors.white.withOpacity(0.95),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: const Text("Ordenes de Laboreos",
            style: TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                    onTap: () async {

                      var result = await Get.toNamed(AppRoutes.rFiltrosOLsIng, 
                        arguments: { 
                          "itemResumenIngeniero": controller.request.itemResumenIngeniero,
                          "filtrosOLs": controller.filtrosOL,
                          "recursosEA": controller.recursosEA
                        });

                      if (result != null)
                      {
                        //!------ aca falta ver cuando realmente lo llamos ya que regresa por Back o porque realmente filtró
                        controller.filtrosOL = result as Rx<FiltrosOLsIng>;                        
                        await controller.obtenerOrdenesLaboreosIngeniero();
                      }
                    

                    },
                    child: const Icon(Icons.filter_alt)),
          )
        ],
      ),
      body: controller.obx(
        (state) => 
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Obx(() => Visibility(
                visible:  controller.filtering.value,
                child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () => controller.limpiarFiltros(),
                        child: const Chip(
                          elevation: 10,
                          padding: EdgeInsets.all(8),
                          backgroundColor: kTLightPrimaryColor1,
                          shadowColor: Colors.black,
                          label: Text('Limpiar filtros !',
                              style: TextStyle(
                                  fontSize: 14, color: kTAllLabelsColor)), //Text
                        ),
                      ),
                    ),
              )), //
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      ListView.separated(
                          controller: controller.scrollController,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) => Container(),
                          itemCount: state!.listaOLsUsuario.length,
                          itemBuilder: (BuildContext context, int index) {
                            dataItem = state.listaOLsUsuario[index];
                            registro++;
                            return ShowOLItem(ordenLaboreo: dataItem!, registro: registro);
                          }),
                        Obx(() => Visibility(
                          visible: controller.loading.value && controller.request.pageNro > 1,
                            child: const Column(
                              children: [
                                Expanded(child: SizedBox()),
                                SizedBox(
                                  width: double.infinity,
                                  child: Center(child: kTLpi)),
                              ],
                            ))),
                    ]
                  ),
                ),
              ),
            ],
          ),
        onLoading: const MyProgressIndicactor(mensaje: 'Buscando órdenes de laboreos !'),
        onEmpty: const MyDataNotFoundMessage(),
        onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowOLItem extends StatelessWidget {
  
  OLIngenieroItem ordenLaboreo;
  int registro;

  ShowOLItem({
    Key? key,
    required this.ordenLaboreo,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    OrdenesLaboreoListaIngenieroController cntr = Get.find<OrdenesLaboreoListaIngenieroController>();

    EAResourcesRequest requestResources = EAResourcesRequest(
      gEconomicoId: ordenLaboreo.gEconomicoId, 
      empresaId: ordenLaboreo.empresaId, 
      tokenDeRefresco: PreferenciasDeUsuarioStorage.tokenDeRefresco);

    //!-- Add Remitar OL
    bool allowRemitar = false; //-- ordenLaboreo.estado.toUpperCase().contains('PENDIENTE');
    bool allowCerrar = ordenLaboreo.estado.toUpperCase().contains('REMITADO');

    bool allowEdit = true;
    if (ordenLaboreo.estado.toUpperCase().contains('FACTURADA') || 
        ordenLaboreo.estado.toUpperCase().contains('CERRADA') || 
        ordenLaboreo.estado.toUpperCase().contains('CREADA') || 
        ordenLaboreo.estado.toUpperCase().contains('REALIZADA') || 
        ordenLaboreo.estado.toUpperCase().contains('ANULADA') )
    {
      allowEdit = false;
    }

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 13.0, fontFamily: "OpenSans"),
      foregroundColor: kTLightPrimaryColor2,
      //backgroundColor: kTLightPrimaryColor2,
      shadowColor: Colors.black,
      //elevation: 8,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
      // ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        //!-- Add 2.6
        onTap: () => Get.toNamed(AppRoutes.rOlDetalleIngeniero, arguments: Get.toNamed(
                            AppRoutes.rOlDetalleIngeniero, 
                              arguments: { 
                                'ordenLaboreo': ordenLaboreo, 
                                'accion': 'ver' 
                              })),
        child: Card(
          color: Colors.white.withOpacity(0.95),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  
                  const SizedBox(height: 5.0),
                  showNroYEstadoOL(ordenLaboreo.olId, ordenLaboreo.estado, ordenLaboreo.gEconomicoId, ordenLaboreo.empresaId),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            ShowCabeceraOLIngeniero(
                              cereal: ordenLaboreo.cereal,
                              ea: ordenLaboreo.ea,
                              fecVto: ordenLaboreo.fecVto,
                              ing: ordenLaboreo.ing,
                              laboreo: ordenLaboreo.laboreo,
                              contratista: ordenLaboreo.con,
                              fecEmi: ordenLaboreo.fecEmi,          //!-- Add 2.8
                            ),
                            const SizedBox(height: 15.0),
                            showDepositosOL(ordenLaboreo.uao, ordenLaboreo.uad),
                            showObservacionOL(ordenLaboreo.obs),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: const [
                      //         Icon(Icons.arrow_forward_ios, size: 20.0,
                      //             color: kTLightPrimaryColor),
                      //       ]),
                      // )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //!-- Add Remitar OL
                      Visibility(
                        visible: allowRemitar,
                        child: TextButton(
                          style: flatButtonStyle,
                          //!-- Add 2.6
                          onPressed: () => Get.toNamed(AppRoutes.rOlDetalleIngeniero, arguments: { 'ordenLaboreo': ordenLaboreo, 'accion': 'REMITAR', 'recursosEA': cntr.recursosEA }),
                          child: const Text('Remitar OL'),
                        ),
                      ),
                      //!-- Add Cerrar OL
                      Visibility(
                        visible: allowCerrar,
                        child: TextButton(
                          style: flatButtonStyle,
                          onPressed: () => Get.toNamed(AppRoutes.rOlPaso1, arguments: { 
                                                                "requestEARerources": requestResources, 
                                                                "ordenLaboreoId":     ordenLaboreo.olId,
                                                                "accion":             'CERRAR'
                                                              }),
                          child: const Text('Cerrar OL'),
                        ),
                      ),
                      Visibility(
                        visible: allowEdit,
                        child: TextButton(
                          style: flatButtonStyle,
                          onPressed: () => Get.toNamed(
                            //!-- Add 2.6
                            AppRoutes.rOlDetalleIngeniero, 
                              arguments: { 
                                'ordenLaboreo': ordenLaboreo, 
                                'accion': 'ver' 
                              }),
                          child: const Text('Ver OL'),
                        ),
                      ),
                      Visibility(
                        visible: allowEdit,
                        child: TextButton(
                          style: flatButtonStyle,
                          onPressed: () => Get.toNamed(AppRoutes.rOlPaso1, arguments: { 
                                                                "requestEARerources": requestResources, 
                                                                "ordenLaboreoId":     ordenLaboreo.olId,
                                                                "accion":             'EDITAR',
                                                              }),
                          child: const Text('Editar OL'),
                        ),
                      ),
                    ],
                  ),

                  // Visibility(
                  //   visible: allowEdit,
                  //   child: GestureDetector(
                  //     onTap: () => Get.toNamed(AppRoutes.rOlPaso1, arguments: { 
                  //                                             "requestEARerources": requestResources, 
                  //                                             "ordenLaboreoId": ordenLaboreo.olId }),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: const [
                  //         Text('Editar OL  ', style: TextStyle(color: kTLightPrimaryColor2)),
                  //         Icon(Icons.edit, color: kTLightPrimaryColor2),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          )),
    );
  }
}
