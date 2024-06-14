import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/modules/genericos/cotizaciones/model/model_cotizaciones.dart';
import 'package:nexobyte/app/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:money2/money2.dart';
import 'cotizacion_cereales_controller.dart';

class CotizacionCerealesWidget extends GetView<CotizacionCerealesController> {

  final List<CotizacionCereal> listaCotizacionCereal;

  const CotizacionCerealesWidget(this.listaCotizacionCereal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.55,
          height: 65.0,
          autoPlay: true,
          autoPlayInterval: const Duration(milliseconds: 6000),
          autoPlayAnimationDuration: const Duration(milliseconds: 6300),
        ),
        items: listaCotizacionCereal.map((i) {

          var grano = '';
          if (i.grano.length <= 5)
          {
            grano = "${i.grano} - ${dateFormatDM.format(i.fecha!).toString().toUpperCase()}";
          }
          else
          {
            grano = i.grano;
          }

          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: kTCircleAvatarBackgroundColor,
                        radius: 28,
                        backgroundImage: AssetImage('assets/img/${i.grano.trim().toString().toLowerCase().replaceAll(' ', '_')}.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(grano, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: kTLabelEspecieCarrousel)),
                                    // Text(i.grano, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: kTLabelEspecieCarrousel)),
                                    // Text(" - " + dateFormatDM.format(i.fecha!).toString().toUpperCase(), style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: kTLabelEspecieCarrousel)),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("ROSARIO", textAlign: TextAlign.left, style: TextStyle(fontSize: 11.0, color: kTAllLabelsColor)),
                                  const SizedBox(height: 5.0),
                                  Text(Money.fromNumWithCurrency(i.ros, Constants.monedaARN0).toString(), style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: kTLabelEspeciePrecio)),
                              ],)
                            ],
                          ),
                        ),
                      ],
                    ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

}