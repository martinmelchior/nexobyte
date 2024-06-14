

import 'package:flutter/material.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:nexobyte/app/utils/utils.dart';

class ShowLoteHasTrabajadas extends StatelessWidget {
  
  Lote lote;
  ShowLoteHasTrabajadas(this.lote, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${lote.loteNombre.toString()}  -  ( ${lote.cantHas.toString()} has )', style: const TextStyle(color: Colors.black87, fontSize: 13.0)),
              const SizedBox(height: 5.0),
              Text(lote.especieNombre!, style: const TextStyle(color: Colors.black54, fontSize: 13.0)),
              const SizedBox(height: 5.0),
              Text('Has a trabajar: ( ${ numberFormat.format(lote.cantHasTrabajadas) } has )', style: const TextStyle(color: kTAllLabelsColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5.0),
          ]);
  }
}