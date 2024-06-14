import 'package:nexobyte/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/data/models/cta_cte_granaria.dart';
import 'package:nexobyte/app/routes/routes_app.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'ctacte_granaria_consolida_especie_controller.dart';

// ignore: must_be_immutable
class CtaCteGranariaConsolidaEspecieWidget extends GetView<CtaCteGranariaConsolidaEspecieController> {

  
  const CtaCteGranariaConsolidaEspecieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tus Saldos Acumulados',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: kTAllLabelsColor)),
        const SizedBox(height: 10.0),
        
        controller.saldosPorEspecieResponse.value.listaDeSaldosPorEspecie.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(), //! Previene el scroll propio del listview
                      itemCount: controller.saldosPorEspecieResponse.value.listaDeSaldosPorEspecie.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ShowItemEspecie(itemSaldoPorEspecie: controller.saldosPorEspecieResponse.value.listaDeSaldosPorEspecie[index]);
                      })
                  : const Center(child: Text('Parece que no tienes saldos de cerales !')),
      ],
    );
  }
}

class ShowItemEspecie extends StatelessWidget {
  
  final SaldoPorEspecieItem itemSaldoPorEspecie;

  const ShowItemEspecie({
    Key? key,
    required this.itemSaldoPorEspecie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.rCtacteGranariaResumenPEC),
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
          child:  Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kTCircleAvatarBackgroundColor,
                                    radius: 30,
                                    backgroundImage: AssetImage('assets/img/${itemSaldoPorEspecie.especie.toString().toLowerCase().replaceAll(' ', '_')}.png'),
                                  ),
                                  const SizedBox(width: 15),
                                  //-- aca fix conargroup
                                  Expanded(
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(itemSaldoPorEspecie.especie, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: kTLabelEspecieResumenHome)),
                                          const SizedBox(height: 3.0),
                                          Text("${numberFormat.format(itemSaldoPorEspecie.disponibleKgs)}  Kgs", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: kTLabelResumenHome)),
                                          const SizedBox(height: 3.0),
                                          Text("${numberFormat.format(itemSaldoPorEspecie.disponibleTn)}  TN", style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: kTLabelResumenHome)),
                                          const SizedBox(height: 3.0),
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
                  ),
                ),
              ),
   );
    
  }
}

