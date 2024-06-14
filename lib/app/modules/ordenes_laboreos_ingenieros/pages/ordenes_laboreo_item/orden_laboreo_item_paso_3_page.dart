import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/model/articulos_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/widgets/show_lote_has_trabajadas.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:money2/money2.dart';
import 'orden_laboreo_item_paso_1_controller.dart';
import 'orden_laboreo_item_paso_3_controller.dart';


class OrdenLaboreoItemPaso3 extends GetView<OrdenLaboreoItemPaso3Controller> {

  OrdenLaboreoItemPaso3({Key? key}) : super(key: key);
  
  final GlobalKey<FormState> _key = GlobalKey();

  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  @override
  Widget build(BuildContext context) {

    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _key,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBar(
              flexibleSpace: kTflexibleSpace,
              elevation: 10.0,
              backgroundColor: kTLightPrimaryColor,
              iconTheme: const IconThemeData(
                color: kTIconColor, //change your color here
              ),
              //!-- Add Cerrar OL
              title: Text(controller.mode == FormMode.insert 
                                ? "Nueva Orden de Laboreo\nPaso  3"
                                : controller.accion == "CERRAR"
                                    ? "Cerrar Orden de Laboreo"
                                    : "Edición de\nOrden de Laboreo",
                style: TextStyle(fontSize: 17.0, color: controller.accion == "CERRAR" 
                                                                ? Colors.yellow[100]
                                                                : kTAllLabelsColor)),
              centerTitle: true,
              bottom: const TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5.0,
                tabs: [
                  Tab(child: Text('INSUMOS\nPOR LOTES', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                  Tab(child: Text('TOTAL\nINSUMOS', textAlign: TextAlign.center,style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                  Tab(child: Text('COSTEO', textAlign: TextAlign.center,style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor))),
                ],
              ),
            ),
            body: Column(
            children: [
              Expanded(
                flex: 10,
                child: TabBarView(
                children: [
                   SingleChildScrollView(
                      child:  Obx(() =>
                          Column(children: [
                            ...controller.paso1Controller.rxOLAbm.value.lotes.map((l) => showHeaderLote(context, l)),
                          ]),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(() => _totalInsumos(controller.paso1Controller.rxOLAbm.value.totalInsumos)),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Obx(() => _costeo(controller.paso1Controller)),
                      ),
                    ),
                  ],
                ),
              ),
              //*----------------------------------------- BOTON SIGUIENTE PASO
              Expanded(
                flex: 1,
                child: Center(
                  child: Obx(() => Visibility(
                    visible: !controller.saving.value,
                    child: ElevatedButton(
                          child: SizedBox(
                            width: Get.width * 0.85,
                            //!-- Add Cerrar OL
                            child: Text(controller.accion == "CERRAR" ? "CERRAR  OL  " : "Guardar  Orden de Laboreo",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: kTLabelColorBtnIngresarLogin,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                )),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  kTBackgroundColorBtnIngresarLogin),
                              elevation: MaterialStateProperty.all(15.0),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15.0)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              //-- Este save() es el que pasa los valores de las cajas de texto al controller!
                              _key.currentState!.save();
                              //!-- Add Cerrar OL
                              controller.save(controller.accion);
                            }
                          },
                        ),
                  )),
                ),
              ),
            ],
          ),
        )));
  }

  
  //*------------------------------------------------------------------------------------- showHeaderLote
  Widget showHeaderLote(BuildContext _context, Lote l) {

    final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();
    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) { 
      enabled = true; 
    }
    else if (controllerP1.mode == FormMode.update) { 
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE"; 
    }

    int registro = 0;

    return ListTileTheme(
              tileColor: kTBackgroundBtnHome.withOpacity(0.10),
              child: ExpansionTile(
                  initiallyExpanded: true,
                  iconColor: Colors.black54,
                  collapsedIconColor: Colors.black54,
                  tilePadding: const EdgeInsets.only(left: 2, right: 20),
                  title: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: enabled,
                              child: Checkbox(
                                activeColor: kTLightPrimaryColor2,
                                value: l.seleccionado, 
                                onChanged: (value) { 
                                  //*-- MarcaDesmarca lote
                                  //-- Fix Lote Explotacion
                                  controller.marcarDesmarcarLote(value!, l.loteId!, l.explotacionLoteId!);  
                                  //*-- DESMARCA => RECALCULO TOTALES
                                  controller.paso1Controller.actualizarTotal();

                                  //-- Fix Lote Explotacion
                                  Lote lote = controller.paso1Controller.rxOLAbm.value.lotes.firstWhere((lo) => lo.loteId == l.loteId && lo.explotacionLoteId == l.explotacionLoteId);
                                  lote.seleccionado = value;
                                  
                                  //*-- REFRESCO OBX
                                  controller.paso1Controller.rxOLAbm.refresh();
                                }
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: ShowLoteHasTrabajadas(l)),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: enabled,
                              child: PopupMenuButton(
                                enabled: l.seleccionado!,
                                onSelected: (value) async {
                                  switch (value) {
                                    case 1:
                                      //*--------------------------------------------- Cant de has trabajadas
                                      return showDialogHasTrabajadas(_context, l);
                                    case 2:
                                      //*--------------------------------------------- Agrega insumo al lote Lote
                                      await Get.toNamed(AppRoutes.rOlArticulos, arguments: { 
                                                                                  "addInsumoAUnLote": true,
                                                                                  "requestEARerources": controller.paramReqEAResources,
                                                                                  "precioDolar": controller.paso1Controller.rxOLAbm.value.precioHaDolar,
                                                                                  "uaOrigenId": controller.paso1Controller.rxOLAbm.value.uaOrigen!.uaId,
                                                                                  "lote": l
                                                                                });
                                      controller.paso1Controller.rxOLAbm.refresh();
                                      break;                                        
                                    case 3:
                                      //*--------------------------------------------- Agrega insumo al TODOS LOS LOTES SELECCIONADOS
                                      await Get.toNamed(AppRoutes.rOlArticulos, arguments: { 
                                                                                  "addInsumoAUnLote": false,
                                                                                  "requestEARerources": controller.paramReqEAResources,
                                                                                  "precioDolar": controller.paso1Controller.rxOLAbm.value.precioHaDolar,
                                                                                  "uaOrigenId": controller.paso1Controller.rxOLAbm.value.uaOrigen!.uaId,
                                                                                  "lote": null
                                                                                });
                                      controller.paso1Controller.rxOLAbm.refresh();
                                      break;       
                                    default:
                                      throw UnimplementedError();
                                  }
                                },
                                itemBuilder: (_context) => [
                                  const PopupMenuItem(
                                    child: Text("Modificar Cant de Has a trabajar", style: TextStyle(fontSize: 13.0)),
                                    value: 1
                                  ),
                                  PopupMenuItem(
                                    enabled: l.cantHasTrabajadas! > 0,
                                    child: const Text("Agregar insumo al Lotes", style: TextStyle(fontSize: 13.0)),
                                    value: 2,
                                  ),
                                  PopupMenuItem(
                                    enabled: l.cantHasTrabajadas! > 0,
                                    child: const Text("Agregar insumo a TODOS los lotes", style: TextStyle(fontSize: 13.0)),
                                    value: 3,
                                  )
                                ]
                              ),
                            ),
                          ]
                        )),
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide( //                   <--- left side
                            color: kTBackgroundBtnHome,
                            width: 3.0,
                          ),
                        )),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) => Container(),
                        itemCount: l.insumos!.length,
                        itemBuilder: (BuildContext context, int index) {
                          OLAbmInsumoLote dataItem = l.insumos![index];
                          registro++;
                          return Dismissible(
                                  key: UniqueKey(), //Key(dataItem.articuloId.toString()),
                                  direction: enabled ? DismissDirection.startToEnd : DismissDirection.none,
                                  background: Container(
                                    color: Colors.red, 
                                    child: const Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete_forever, color: Colors.white),
                                              SizedBox(width: 10.0),
                                              Text('Elimina insumo !', style: TextStyle(color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ]
                                    )
                                  ),
                                  onDismissed: (direction) {
                                    // * ----------------------------------------------------------------------------------------
                                    // * -- Elimina el insumo
                                    // * ----------------------------------------------------------------------------------------
                                    l.insumos!.removeWhere((i) => i.articuloId == dataItem.articuloId);
                                    controller.paso1Controller.actualizarTotalArticulo(
                                      Articulo(
                                        articuloFacId: dataItem.articuloId!,
                                        nombre: dataItem.nombre,
                                        umOrigen: dataItem.umOrigen!,
                                      )
                                    );
                                    controller.paso1Controller.rxOLAbm.refresh();
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 1), backgroundColor: kTRedColor, content: Text("Insumo eliminado")));
                                  },
                                  child: ShowOLInsumoLote(insumoItem: dataItem, registro: registro));
                        }),
                    ),  
                  ]),
              );
  }

  //*------------------------------------------------------------------------------------- showDialogHasTrabajadas
  showDialogHasTrabajadas(BuildContext context, Lote l) {
    final GlobalKey<FormState> _key = GlobalKey();
    controller.txtCantHasController.text = l.cantHas.toString();
    return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.white,
                title: Text("Defina la cantidad de has reales a trabajar en ${l.loteNombre} de ${l.cantHas} has", style: const TextStyle(color: Colors.black54, fontSize: 15.0),),
                content: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _key,
                  child: SizedBox(
                    height: 150.0,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        _cantHasTrabajadas(l),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  )),
                actions: <Widget>[
                  Visibility(
                    visible: controller.hasTrabajadasOk.value,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTImporteAFavor)),
                      onPressed: () { 
                        if (_key.currentState!.validate())
                        {
                          if (controller.txtCantHasController.text.isNotEmpty)
                          {
                            //-- Fix Lote Explotacion
                            controller.setHectareasTrabajadasALote(l.loteId!, l.explotacionLoteId!, double.parse(controller.txtCantHasController.text));
                            Navigator.of(ctx).pop(); 
                          }
                          else {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'ATENCION',
                              message: 'Cantidad de has erroneas !',
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2)));
                          }
                        }
                        else {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'ATENCION',
                            message: 'Cantidad de has erroneas !',
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2)));
                        }
                      },
                      child: const Text("Confirmar"),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor)),
                    onPressed: () { Navigator.of(ctx).pop(); },
                    child: const Text("Cerrar"),
                  ),
                ],
              ),
            );
    
  }

  //*------------------------------------------------------------------------------------------------------ Cotizacion
  Widget _cantHasTrabajadas(Lote l) {

    return TextFormField(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelText: 'CANT. DE HAS',
          suffixText: r"  has",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(6), //max length
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
        ],
        controller: controller.txtCantHasController,
        validator: (value) {
          if (value!.isNotEmpty)
          {
            if (double.parse(value.toString()) > l.cantHas! || double.parse(value.toString()) <= 0.0)  {
              return 'Valor incorrecto de has a trabajar !';
            }
          }
          return null;
        },
    );
  }

  // * -------------------------------------------------------------------------------------------------- solapa 2
  Widget _totalInsumos(List<OLAbmTotalInsumo> listaTotalInsumos) {

    int registro = 0;

    return Column(
      children: [
        const SizedBox(height: 10.0),
        const Text('Total de insumos a utilizar', style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20.0),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) => Container(),
          itemCount: listaTotalInsumos.length,
          itemBuilder: (BuildContext context, int index) {
            OLAbmTotalInsumo dataItem = listaTotalInsumos[index];
            registro++;
            return ShowOLInsumo(insumoItem: dataItem, registro: registro);
          }),
      ],
    );
  }

  // * -------------------------------------------------------------------------------------------------- solapa 3
  Widget _costeo(OrdenLaboreoItemPaso1Controller  controllerPaso1) {

    OLAbm ordenLaboreo = controllerPaso1.rxOLAbm.value;

    double _totalPesos = ordenLaboreo.totalPesos ?? 0.0;
    double _totalDolar = ordenLaboreo.totalDolar ?? 0.0;
    double _precioHaPesos = ordenLaboreo.precioHaPesos ?? 0.0;
    double _precioHaDolar = ordenLaboreo.precioHaDolar ?? 0.0;
    double _tipoDeCambio = ordenLaboreo.tipoCambio ?? 0.0;
    
    Widget _returnWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("DATOS MONETARIOS", style: TextStyle(fontSize: 12.0, color: Colors.black87)),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Has a trabajar", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text('${(controllerPaso1.getTotalHasATrabajar()).toStringAsFixed(2)} has', style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Precio por ha", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text(Money.fromNumWithCurrency(_precioHaPesos, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total laboreo en pesos", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text(Money.fromNumWithCurrency(_totalPesos, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 15.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Cotización dolar", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text(Money.fromNumWithCurrency(_tipoDeCambio, Constants.monedaAR).toString(), style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Precio por ha en US\$", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text(Money.fromNumWithCurrency(_precioHaDolar, Constants.monedaUSD).toString(), style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total laboreo en dolares", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            Text(Money.fromNumWithCurrency(_totalDolar, Constants.monedaUSD).toString(), style: const TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.bold)),
          ],
        ),
        
      ]);

    return _returnWidget;

  }

  

}

// * -------------------------------------------------------------------------------------------------- LISTA DE INSUMOS TOTAL
// ignore: must_be_immutable
class ShowOLInsumo extends StatelessWidget {
  
  final GlobalKey<FormState> _keyTotal = GlobalKey();

  final OrdenLaboreoItemPaso3Controller paso3Controller = Get.find<OrdenLaboreoItemPaso3Controller>();
  final TextStyle _labelStyle = const TextStyle(color: kTLightPrimaryColor, fontSize: 18);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OrdenLaboreoItemPaso1Controller controllerP1 = Get.find<OrdenLaboreoItemPaso1Controller>();

  OLAbmTotalInsumo insumoItem;
  int registro;

  ShowOLInsumo({
    Key? key,
    required this.insumoItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool enabled = false;
    if (controllerP1.mode == FormMode.insert) { 
      enabled = true; 
    }
    else if (controllerP1.mode == FormMode.update) { 
      //!-- Add Remitar OL
      enabled = controllerP1.rxOLAbm.value.estado == "PENDIENTE" || controllerP1.rxOLAbm.value.estado == "REMITADO"; 
    }

    return  Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Column(
        children: [
          //* ---------- Insummo
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 8,
                  child: Text(insumoItem.nombre.toString(),style: const TextStyle(fontSize: 12.0, color: Colors.black54))),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(insumoItem.total.toStringAsFixed(2), textAlign: TextAlign.right, style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text(insumoItem.umo.toString(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                    ]
                  ),
                ),
                Visibility(
                  visible: insumoItem.total > 0 && enabled,
                  child: Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => showDialogCambiarConsumoTotal(context, insumoItem),
                      child: const Icon(Icons.edit, color: Colors.indigo)),
                  ),
                ),
            ]),
          ),
        ],
      ),
    );
  }

  //*------------------------------------------------------------------------------------- showDialogCambiarConsumoTotal
  showDialogCambiarConsumoTotal(BuildContext context, OLAbmTotalInsumo insumo) {
    return showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.white,
                title: Text("Defina la cantidad total a consumir de ${insumo.nombre}", style: const TextStyle(color: Colors.black54, fontSize: 15.0),),
                content: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _keyTotal,
                  child: SizedBox(
                    height: 150.0,
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        _cantTotalConsumo(insumo),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  )),
                actions: <Widget>[
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTImporteAFavor)),
                      onPressed: () async { 
                        if (_keyTotal.currentState!.validate())
                        {
                          await paso3Controller.recalcularGastosPorLote(
                            Articulo(
                              articuloFacId: insumo.articuloId,
                              nombre: insumo.nombre,
                              umOrigen: insumo.umo, 
                              idUnico: insumo.idUnico),
                            double.parse(paso3Controller.txtTotalAConsumir.text),
                            insumo.total,
                          );
                          Navigator.of(ctx).pop(); 
                        }
                        else {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'ATENCION',
                            message: 'Cantidad erronea !',
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2)));
                        }
                      },
                      child: const Text("Confirmar"),
                    ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor)),
                    onPressed: () { Navigator.of(ctx).pop(); },
                    child: const Text("Cerrar"),
                  ),
                ],
              ),
            );
    
  }

  
  //*------------------------------------------------------------------------------------------------------ Cotizacion
  Widget _cantTotalConsumo(OLAbmTotalInsumo insumo) {

    paso3Controller.txtTotalAConsumir.text = insumo.total.toString();

    return TextFormField(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelText: 'TOTAL A CONSUMIR',
          suffixText: "  ${insumo.umo}",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(6), //max length
          FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
        ],
        controller: paso3Controller.txtTotalAConsumir,
        validator: (value) {
          if (value == null || value.isEmpty) { return 'Valor incorrecto !'; }
          if (value.isNotEmpty)
          {
            if (double.parse(value.toString()) <= 0.0)  {
              return 'Valor incorrecto !';
            }
          }
          return null;
        },
    );
  }

}

// * -------------------------------------------------------------------------------------------------- LISTA DE INSUMOS 
// ignore: must_be_immutable
class ShowOLInsumoLote extends StatelessWidget {
  
  OLAbmInsumoLote insumoItem;
  int registro;

  ShowOLInsumoLote({
    Key? key,
    required this.insumoItem,
    required this.registro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: (registro % 2 == 0) ? Colors.white70 : kTItemBackGroundColor,
      child: Column(
        children: [
          //* ---------- NRO + ESTADO
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(insumoItem.nombre.toString(),style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                      RichText(
                        text: TextSpan( 
                          style: const TextStyle(fontSize: 13.0, color: Colors.black38),
                          children: <TextSpan>[
                            //const TextSpan(text: 'DOSIS  '),
                            TextSpan(text: insumoItem.dosis!.toStringAsFixed(4), style: const TextStyle(fontSize: 15.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                            TextSpan(text: '  ${insumoItem.umOrigen.toString()} /ha.'),
                          ],
                        ),
                      )
                    ],
                  )),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(insumoItem.total!.toStringAsFixed(2), textAlign: TextAlign.right, style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold)),
                      Text(insumoItem.umOrigen.toString(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12.0, color: Colors.black54)),
                    ],
                )),
                
            ]),
          ),
        ],
      ),
    );
  }
}

