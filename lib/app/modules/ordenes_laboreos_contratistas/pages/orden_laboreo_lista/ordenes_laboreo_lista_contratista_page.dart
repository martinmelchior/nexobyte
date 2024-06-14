import 'package:nexobyte/app/modules/ordenes_laboreos_comun/utils.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';

import 'ordenes_laboreo_lista_contratista_controller.dart';

class OrdenesLaboreoContratistaListaPage extends GetView<OrdenesLaboreoContratistaController> {

  int registro = 0;
  OLItemContratista? dataItem;

  OrdenesLaboreoContratistaListaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  var result =
                      await Get.toNamed(AppRoutes.rFiltrosOLsCon, arguments: {
                    "itemResumenContratista": controller.request.itemResumenContratista,
                    "filtrosOLs": controller.filtrosOL,
                    "recursosEA": controller.recursosEA
                  });

                  if (result != null) {
                    //!------ aca falta ver cuando realmente lo llamos ya que regresa por Back o porque realmente filtró
                    controller.filtrosOL = result as Rx<FiltrosOLsCon>;
                    await controller.obtenerOrdenesLaboreosContratista();
                  }
                },
                child: const Icon(Icons.filter_alt)),
          )
        ],
      ),
      body: controller.obx(
        (state) =>  Column(
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
              )), //Chi,
              Expanded(
                child: SingleChildScrollView(
                  child: Stack(children: [
                    ListView.separated(
                        controller: controller.scrollController,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(),
                        itemCount: state!.listaOLsUsuario.length,
                        itemBuilder: (BuildContext context, int index) {
                          dataItem = state.listaOLsUsuario[index];
                          registro++;
                          return ShowOLItem(
                              ordenLaboreo: dataItem!, registro: registro);
                        }),
                    Obx(() => Visibility(
                        visible: controller.loading.value &&
                            controller.request.pageNro > 1,
                        child: const Column(
                          children: [
                            Expanded(child: SizedBox()),
                            SizedBox(
                                width: double.infinity,
                                child: Center(child: kTLpi)),
                          ],
                        ))),
                  ]),
                ),
              ),
            ],
          ),
        onLoading: const MyProgressIndicactor(
            mensaje: 'Buscando órdenes de laboreos !'),
        onEmpty: const MyDataNotFoundMessage(),
        onError: (error) => MyCustomErrorMessage(
            error: error.toString(), colorText: kTLightPrimaryColor),
      ),
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowOLItem extends StatelessWidget {
  OLItemContratista ordenLaboreo;
  int registro;

  ShowOLItem({
    Key? key,
    required this.ordenLaboreo,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.rOlDetalleContratista, arguments: ordenLaboreo),
          child: Card(
            color: Colors.white.withOpacity(0.95),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  showNroYEstadoOL(ordenLaboreo.olId, ordenLaboreo.estado, ordenLaboreo.gEconomicoId, ordenLaboreo.empresaId),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        flex: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShowCabeceraOL(
                                cereal: ordenLaboreo.cereal,
                                ea: ordenLaboreo.ea,
                                fecVto: ordenLaboreo.fecVto,
                                ing: ordenLaboreo.ing,
                                laboreo: ordenLaboreo.laboreo,
                                fecEmi: ordenLaboreo.fecEmi,          //!-- Add 2.8
                            ),
                            const SizedBox(height: 15.0),
                            showDepositosOL(ordenLaboreo.uao, ordenLaboreo.uad),
                            showObservacionOL(ordenLaboreo.obs),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_forward_ios,
                                  size: 20.0, color: kTLightPrimaryColor),
                            ]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
