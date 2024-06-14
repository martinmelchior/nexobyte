import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/widgets/show_lote_has_trabajadas.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'agregar_articulo_controller.dart';

class AgregarArticuloPage extends GetView<AgregarArticuloController> {
  AgregarArticuloPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey();
  final TextStyle _labelStyle =
      const TextStyle(color: kTLightPrimaryColor, fontSize: 15);
  final OutlineInputBorder _enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: kTLightPrimaryColor, width: 0.2));

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _key,
        child: Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: Colors.white.withOpacity(0.95),
          appBar: AppBar(
            flexibleSpace: kTflexibleSpace,
            elevation: 10.0,
            backgroundColor: kTLightPrimaryColor,
            iconTheme: const IconThemeData(
              color: kTIconColor, //change your color here
            ),
            title:
                const Text("Dosis a Aplicar", style: TextStyle(fontSize: 16.0, color: kTAllLabelsColor)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: controller.addInsumoAUnLote,
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            ShowLoteHasTrabajadas(controller.lote.value),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                      width: double.infinity,
                      color: kTLightPrimaryColor3.withOpacity(0.3),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Estás agregando el siguiente Insumo',
                            style: TextStyle(
                                color: kTLightPrimaryColor3,
                                fontWeight: FontWeight.bold)),
                      )),
                  const SizedBox(height: 10.0),
                  //*----------------------------------------- DATOS DE STOCK DE PRODUCTOS
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${controller.articulo.value.codigo.toString()} - ${controller.articulo.value.nombre.toString()}'),
                          const SizedBox(height: 10.0),
                          Row(children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Stk Disponible",
                                      style: TextStyle(fontSize: 11.0)),
                                  Text(controller.articulo.value.stockDisponible
                                      .toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Stk Fisico",
                                      style: TextStyle(fontSize: 11.0)),
                                  Text(controller.articulo.value.stockFisico
                                      .toString()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text("Precio",
                                      style: TextStyle(fontSize: 11.0)),
                                  Text(controller.articulo.value.preUnitario
                                      .toString()),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  //*----------------------------------------- CARGAR DOSIS POR HA
                  const SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _dosisPorHa(controller.articulo.value.umOrigen),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _total(controller.articulo.value.umOrigen),
                  ),
                  //*----------------------------------------- BOTON SIGUIENTE PASO
                  const SizedBox(height: 20.0),
                  _botonAgregarInsumo(),
                ],
            )),
          ),
        ));
  }

  Widget _botonAgregarInsumo() {
    return ElevatedButton(
      child: SizedBox(
        width: Get.width * 0.85,
        child: const Text('Agregar  Insumo',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTLabelColorBtnIngresarLogin,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            )),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(kTBackgroundColorBtnIngresarLogin),
          elevation: MaterialStateProperty.all(15.0),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15.0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)))),
      onPressed: () async {
        //-- Cierro keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        if (controller.pageIsValid()) {
          await controller.agregarInsumo();
          Get.back();
        } else {
          Get.showSnackbar(GetSnackBar(
              title: 'ATENCION',
              message: controller.errorMessage,
              duration: const Duration(seconds: 4)));
        }
      },
    );
  }

  //*------------------------------------------------------------------------------------------------------ Cotizacion
  Widget _dosisPorHa(um) {
    return Focus(
      focusNode: controller.txtFocusDosis,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelText: 'DOSIS por HA a utilizar ',
          suffixText: r"  " + um + " / ha ",
          labelStyle: _labelStyle,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(10),
          CommaTextInputFormatter(),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
        ],
        controller: controller.txtDosisController.value,
        onChanged: (value) {
          try {
            if (value.isEmpty) return;
            double _dosis = double.parse(value);
            controller.txtTotalController.value.text =
                (_dosis * controller.lote.value.cantHasTrabajadas!)
                    .toStringAsFixed(4);
          } catch (e) {
            controller.txtDosisController.value.text = "0";
            controller.txtTotalController.value.text = "0";
          }
        },
      ),
    );
  }

  //*------------------------------------------------------------------------------------------------------ Cotizacion
  Widget _total(um) {
    return Focus(
      focusNode: controller.txtFocusTotal,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
        ),
        textAlignVertical: TextAlignVertical.center,
        //readOnly: true,
        decoration: InputDecoration(
          enabledBorder: _enabledBorder,
          focusedBorder: _focusedBorder,
          labelText:
              'TOTAL a utilizar en ${controller.lote.value.cantHasTrabajadas} has',
          labelStyle: _labelStyle,
          suffixText: r"  " + um,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        textAlign: TextAlign.end,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
        ],
        controller: controller.txtTotalController.value,
        onChanged: (value) {
          try {
            double _total = double.parse(value);
            controller.txtDosisController.value.text =
                (_total / controller.lote.value.cantHasTrabajadas!)
                    .toStringAsFixed(4);
          } catch (e) {
            controller.txtDosisController.value.text = "0";
            controller.txtTotalController.value.text = "0";
          }
        },
      ),
    );
  }
}
