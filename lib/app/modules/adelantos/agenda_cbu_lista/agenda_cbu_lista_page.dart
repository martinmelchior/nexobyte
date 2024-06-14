import 'package:nexobyte/app/modules/adelantos/model/adelantos_model.dart';
import 'package:nexobyte/app/modules/adelantos/utils/adelanto_constants.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/utils/manager_api_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/global_widgets.dart';
import 'agenda_cbu_lista_controller.dart';

class AgendaCbuListPage extends GetView<AgendaCbuListController> {
  
  AgendaCbuListPage({Key? key}) : super(key: key);

  AgendaCbu agendaCbu = AgendaCbu();
  var registro = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: const Icon(Icons.add),
          backgroundColor: kTBackgroundColorBtnIngresarLogin,
          foregroundColor: Colors.white,
          onPressed: () async {
             await Get.toNamed(AppRoutes.rAgendaCbuItem, arguments: { "id": -1 });
             await controller.obtenerAgendaCbu();
          },
        ),
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          flexibleSpace: kTflexibleSpace,
          elevation: 10.0,
          backgroundColor: kTLightPrimaryColor,
          iconTheme: const IconThemeData(
            color: kTIconColor, //change your color here
          ),
          title: Column(

            children: [
              const Text('Agenda Cbu/Alias', style: TextStyle(fontSize: 16.0, fontFamily: 'Sora', color: kTAllLabelsColor)),
              Text(controller.getSubTitulo(), style: const TextStyle(fontSize: 14.0, fontFamily: 'Sora', color: Colors.orange)),
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
              controller.obx(
                (state) =>  RefreshIndicator(
                  color: kTLabelEspecieResumenHome,
                  backgroundColor: kTLightPrimaryColor3,
                  onRefresh: () async => await controller.obtenerAgendaCbu(),
                  child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state!.listaDeCbuAlias.length,
                        itemBuilder: (BuildContext context, int index) {
                          agendaCbu = state.listaDeCbuAlias[index];
                          registro++;
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                                  color: kTRedColor, 
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                                        child: Row(
                                          children:  [
                                            Icon(Icons.delete_forever, color: Colors.white),
                                            SizedBox(width: 10.0),
                                            Text('Eliminar CBU / Alias !', style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                            onDismissed: (direction) async {
                              // * ----------------------------------------------------------------------------------------
                              // * -- Elimina el cbu
                              // * ----------------------------------------------------------------------------------------
                              try {
                                bool returnValue = await controller.eliminarAgendaCbu(agendaCbu, context);
                                if (returnValue)
                                {
                                  controller.obtenerAgendaCbu();
                                }
                              }
                              catch (e)
                              {
                                String error = ApiExceptions.getCustomError(e);
                                if (error.isNotEmpty)    
                                {
                                  Get.snackbar("Se produjo un ERROR",
                                              error,
                                              snackPosition: SnackPosition.BOTTOM,
                                              icon: const Icon(Icons.error, color: kErrorTextColor),
                                              backgroundColor: kTRedColor,
                                              colorText: kErrorTextColor,
                                              borderRadius: 0,
                                              margin: const EdgeInsets.all(0),
                                            );
                                }
                                await controller.obtenerAgendaCbu();
                              }
                            },
                            child: GestureDetector(
                              onTap: () async {
                                  bool reloadList = await Get.toNamed(AppRoutes.rAgendaCbuItem, 
                                                arguments: { 
                                                  "id": state.listaDeCbuAlias[index].id,
                                                });
                                  if (reloadList)
                                  {
                                    await controller.obtenerAgendaCbu();
                                  }
                              },
                              child: ShowCbuAlias(cbuAlias: agendaCbu, registro: registro))
                          );
                        }),
                ),
                onLoading: const MyProgressIndicactor(mensaje: 'Espere un momento !'),
                onEmpty: const Center(child: MyDataNotFoundMessage(colorText: kTLightPrimaryColor, mensaje: 'Aún no tienes ningún Cbu/Alias\nagendado.\n\nPuedes agendarlos desde el\nbotón + inferior. ',)),
                onError: (error) => Center(child: MyCustomErrorMessage(error: error.toString(), colorText: kTRedColor)),
              ),
          ]
        ));
  }
}


// * ------------------------------------------------------------------------------------- MUESTRA ITEM DEL RESUMEN
class ShowCbuAlias extends StatelessWidget {

  final AgendaCbuListController _controller = Get.find<AgendaCbuListController>();

  final AgendaCbu cbuAlias;
  final int registro;

  ShowCbuAlias({
    Key? key,
    required this.cbuAlias,
    required this.registro
  }) : super(key: key);

  final TextStyle _lblNormal = const TextStyle(fontSize: 10.0);
  final TextStyle _lblNegrita = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kTLightPrimaryColor);
  final TextStyle _lblNegrita2 = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.green);
  
  @override
  Widget build(BuildContext context) {
    
    return Card(
      child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                   Text(cbuAlias.tipoDeCuentaEnBanco.toString(), style: _lblNegrita2),
                  Text(cbuAlias.banco.toString(), style: _lblNegrita2),
                  Text("BANCO", style: _lblNormal),
                  const SizedBox(height: 8.0),
                  Text(cbuAlias.cbuAlias.toString(), style: _lblNegrita2),
                  Text("CBU/ALIAS", style: _lblNormal),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(cbuAlias.tipoDeCuenta.toString(), style: _lblNegrita),
                      const SizedBox(width: 10.0),
                      cbuAlias.tipoDeCuenta.toString().toUpperCase().contains("OTRAS") 
                        ? const Icon(Icons.arrow_upward, color: Colors.red, size: 20) 
                        : const Icon(Icons.arrow_upward, color: Colors.green, size: 20),
                    ],
                  ),
                  Text("TIPO DE CUENTA", style: _lblNormal),
                  const SizedBox(height: 8.0),
                  Text(cbuAlias.descripcion.toString().toUpperCase(), style: _lblNegrita),
                  Text("DESCRIPCION", style: _lblNormal),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cbuAlias.cuit.toString(), style: _lblNegrita),
                      Image.asset(AdelantoConstants.kImgDismiss,  height: 20.0,  width: 20.0),
                    ],
                  ),
                  Text("CUIT", style: _lblNormal),
                  const SizedBox(height: 8.0),
                ],
              ),
      ),
    );

  }
}
