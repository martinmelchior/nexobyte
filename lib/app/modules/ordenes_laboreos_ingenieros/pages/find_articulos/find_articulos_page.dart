
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/widgets/show_lote_has_trabajadas.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/global_widgets.dart';
import 'find_articulos_controller.dart';
import '../../model/articulos_model.dart';

class FindArticulosPage extends GetView<FindArticulosController> {
  
  int registro = 0;

  Articulo? dataItem;
 
  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));


  FindArticulosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.90),
      appBar: AppBar(
        flexibleSpace: kTflexibleSpace,
        elevation: 10.0,
        backgroundColor: kTLightPrimaryColor,
        iconTheme: const IconThemeData(
          color: kTIconColor, //change your color here
        ),
        title: controller.addInsumoAUnLote
                ? const Text("Agregando Insumo a", style: TextStyle(fontSize: 17.0, fontFamily: 'Sora', color: kTAllLabelsColor))
                : const Text("Agregando Insumos\na TODOS los lotes", style: TextStyle(fontSize: 16.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
        centerTitle: true,
      ),
      body: Column(
          children: [
            Visibility(
              visible: controller.addInsumoAUnLote,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                      child: ShowLoteHasTrabajadas(controller.lote.value),
                    )),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  enabledBorder: _enabledBorder,
                  focusedBorder: _focusedBorder,
                  labelText: 'Insumo a buscar ...',
                  labelStyle: _labelStyle,
                  helperText: 'Puede buscar por nombre o parte del nombre.',
                  suffixIcon: IconButton(
                    color: kTLightPrimaryColor1,
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: () {
                      if (controller.txtSearchController.text.isNotEmpty && !controller.loading.value)
                      {
                        controller.txtSearchController.text = '';
                        controller.obtenerArticulosOL();
                      }
                    }),
                ),
                keyboardType: TextInputType.text,
                onChanged: controller.onSearchChanged,
                controller: controller.txtSearchController,
              ),
            ),
            const SizedBox(height: 5.0),
            Visibility(
              visible: controller.addInsumoAUnLote,
              child: Obx(() => Expanded(
                  child: Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.transparent,
                                        child: ListView.builder(
                                          itemCount: controller.lote.value.insumos!.isEmpty ? 0 : 1,
                                          itemBuilder:(context, index) {
                                            int _ultimoInsumo = controller.lote.value.insumos!.length-1;
                                            OLAbmInsumoLote _isnumo = controller.lote.value.insumos![_ultimoInsumo];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Ultimo insumo agregado', style: TextStyle(fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 5.0),
                                                Text('${_isnumo.nombre.toString()} - dosis ${_isnumo.dosis.toString()} ${_isnumo.umOrigen.toString()} / ha', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                                Text('Total a aplicar ${_isnumo.total.toString()} ${_isnumo.umOrigen.toString()}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                              ],
                                            );
                                          })),
                                  ),
                                ),                           
                            ],
                        ),
                    ),
                  ),
                ),
              ),
            ),
            
            Expanded(
              flex: 3,
              child: controller.obx(
                (state) => 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child:  Stack(children: [
                            ListView.separated(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              separatorBuilder: (BuildContext context, int index) => Container(),
                              itemCount: state!.articulos.length,
                              itemBuilder: (BuildContext context, int index) {
                                dataItem = state.articulos[index];
                                registro++;
                                return ShowArticulo(lote: controller.lote.value, articulo: dataItem!, registro: registro, addInsumoAUnLote: controller.addInsumoAUnLote);
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
                              ]),
                        ),
                      
                    ],
                  ),
                onLoading: const MyProgressIndicactor(mensaje: 'Aguarda un instante\n estamos buscando artículos !'),
                onEmpty: const MyDataNotFoundMessage(colorText: kTLightPrimaryColor1, mensaje: "No hemos encontrado artículos !",),
                onError: (error) => MyCustomErrorMessage(error: error.toString(), colorText: kTLightPrimaryColor),
              ),
            ),
          ],
        ),
      
    );
  }
}

// * -------------------------------------------------------------------------------------------------- LISTA DE ITEMS DE LA CUENTA CORRIENTE
// ignore: must_be_immutable
class ShowArticulo extends StatelessWidget {
  
  Lote lote;
  Articulo articulo;
  int registro;
  bool addInsumoAUnLote;

  ShowArticulo({
    Key? key,
    required this.lote,
    required this.articulo,
    required this.registro,
    required this.addInsumoAUnLote,
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
        color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
        child:  GestureDetector(
          onTap: () async {
            if (addInsumoAUnLote)
            {
              await Get.toNamed(AppRoutes.rAgregarArticuloDosis, arguments: { "lote": lote, "articulo": articulo });
            }
            else
            {
              await Get.toNamed(AppRoutes.rAgregarArticuloDosisATodos, arguments: { "articulo": articulo, "addInsumoAUnLote": addInsumoAUnLote });
            }

            FindArticulosController ctrl = Get.find<FindArticulosController>();
            ctrl.lote.refresh();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(articulo.nombre!, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black38)),
                          const SizedBox(height: 10.0),
                          Row(children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Stk Disponible", style: TextStyle(fontSize: 11.0)),
                                  Text(articulo.stockDisponible.toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Stk Fisico", style: TextStyle(fontSize: 11.0)),
                                  Text(articulo.stockFisico.toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Precio", style: TextStyle(fontSize: 11.0)),
                                  //-- Fix Lote Explotacion
                                  Text(articulo.preUnitario.toStringAsFixed(4)),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward_ios, size: 20.0,
                                color: kTLightPrimaryColor),
                          ]),
                    )
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}
