
import 'package:nexobyte/app/theme/app_theme.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter/material.dart';

List<String> estadoOL = [ 'FACTURADA','ANULADA','CERRADA','REALIZADA','PENDIENTE','CREADA','REMITADO'];

class OL {

  static Color getColorEstadoOL(String estado) {
    switch (estado.toUpperCase()) {
      case "FACTURADA": return kOlColorEstadoFacturada;
      case "ANULADA": return kOlColorEstadoAnulada;
      case "CERRADA": return kOlColorEstadoCerrada;
      case "REALIZADA": return kOlColorEstadoRealizada;
      case "PENDIENTE": return kOlColorEstadoPendiente;
      case "CREADA": return kOlColorEstadoCreada;
      case "REMITADO": return kOlColorEstadoRemitado;
      default: return kOlColorEstadoPendiente;
    }
  }

}

//* -------------------------------------------------------------------------- SHOW OBSERVACION
Widget showObservacionOL(String observacion, [bool showDivider = false]) {

  Widget _returnWidget = const SizedBox(height: 0);
  if (observacion.isNotEmpty)
  {
    _returnWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(children: [
          Text('OBSERVACION', style: TextStyle(fontSize: 12.0, color: Colors.black87)),
        ],),
        RichText(
            text: TextSpan( 
              style: const TextStyle(fontSize: 14.0, color: Colors.black87),
              children: <TextSpan>[
                TextSpan(text: observacion.toLowerCase(), style: const TextStyle(fontSize: 16.0, color: Colors.black54)),
              ],
            ),
          ),
        showDivider ? const Divider(height: 30.0) : const SizedBox(height: 15.0)
      ]);
  }
  return _returnWidget;
}

//* -------------------------------------------------------------------------- SHOW DEPOSITOS
Widget showDepositosOL(String uao, String uad, [bool showDivider = false] ) {

  Widget _returnWidget = const SizedBox(height: 0);

  if (uao.isNotEmpty || uad.isNotEmpty)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(children: [
          Text('DEPOSITOS', style: TextStyle(fontSize: 12.0, color: Colors.black87)),
        ],),
        const SizedBox(height: 2.0),
        RichText(
          text: TextSpan( 
            style: const TextStyle(fontSize: 13.0, color: Colors.black38),
            children: <TextSpan>[
              const TextSpan(text: 'ORIGEN   '),
              TextSpan(text: uao.toUpperCase(), style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
              const TextSpan(text: '\nDESTINO '),
              TextSpan(text: uad.toUpperCase(), style: const TextStyle(fontSize: 16.0, color: Colors.black87)),
            ],
          ),
        ),
        showDivider ? const Divider(height: 30.0) : const SizedBox(height: 15.0)
      ],
    );
  }

  return _returnWidget;
}

//* -------------------------------------------------------------------------- NRO + ESTADO
Widget showNroYEstadoOL(int olId, String estado, String gEconomicoId, String empresaId) {

    bool enableEdit = true;
    switch (estado) {
      case "PENDIENTE":
        break;
      case "REMITADO":
        break;
      case "CERRADA":
        enableEdit = false;
        break;
      case "ANULADA":
        enableEdit = false;
        break;
      case "FACTURADA":
        enableEdit = false;
        break;
      case "PAGADA":
        enableEdit = false;
        break;
      default:
    }

    return Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: OL.getColorEstadoOL(estado),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.5),
                child: Center(child: Text(estado,style: const TextStyle(fontSize: 10.0, color: Colors.white, fontWeight: FontWeight.bold))),
              )),
          ),
          const Expanded(
            flex: 5,
            child: SizedBox(width: 50.0)),
          Expanded(
            flex: 2,
            child: Text('# ${olId.toString()}',style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold))
          ),
      ]);
}

//* -------------------------------------------------------------------------- INGENIERO + ESTADO
class ShowCabeceraOL extends StatelessWidget {
  
  final String ing;
  final String laboreo;
  final String ea;
  final String cereal;
  final DateTime fecVto;
  final DateTime fecEmi;      //!-- Add 2.8

  const ShowCabeceraOL({
    Key? key, 
    required this.ing,
    required this.laboreo,
    required this.ea,
    required this.cereal,
    required this.fecVto,
    required this.fecEmi,     //!-- Add 2.8    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
            text: TextSpan( 
              style: const TextStyle(fontSize: 16.0, color: Colors.black38),
              children: <TextSpan>[
                //!-- Add 2.8
                const TextSpan(text: 'El  '),
                TextSpan(text: DateFormat("dd-MM-yyyy").format(fecEmi), style: const TextStyle(fontSize: 18.0, color: Colors.purple)),
                const TextSpan(text: '  el Ing.  '),
                TextSpan(text: ing.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.green)),
                const TextSpan(text: '  te asignó  '),
                TextSpan(text: laboreo.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.red)),
                const TextSpan(text: '  en la Explotación Agropecuaria  '),
                TextSpan(text: ea.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.orange)),
                  cereal.isNotEmpty
                  ? TextSpan(
                      children: [
                        TextSpan(text: '  (${cereal.trim()})', style: const TextStyle(fontSize: 18.0, color: Colors.blue))
                      ])
                  : const TextSpan(text: ''),
                const TextSpan(text: '  con fecha límite para el  '),
                TextSpan(text: DateFormat("dd-MM-yyyy").format(fecVto), style: const TextStyle(fontSize: 18.0, color: Colors.purple)),
              ],
            ),
          );
  }
}

class ShowCabeceraOLIngeniero extends StatelessWidget {
  
  final String ing;
  final String laboreo;
  final String ea;
  final String cereal;
  final String contratista;
  final DateTime fecVto;
  final DateTime fecEmi;          //!-- Add 2.8

  const ShowCabeceraOLIngeniero({
    Key? key, 
    required this.ing,
    required this.laboreo,
    required this.ea,
    required this.cereal,
    required this.contratista,
    required this.fecVto,
    required this.fecEmi,       //!-- Add 2.8
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
            text: TextSpan( 
              style: const TextStyle(fontSize: 16.0, color: Colors.black38),
              children: <TextSpan>[
                //!-- Add 2.8
                const TextSpan(text: 'El  '),
                TextSpan(text: DateFormat("dd-MM-yyyy").format(fecEmi), style: const TextStyle(fontSize: 18.0, color: Colors.purple)),
                const TextSpan(text: '  el Ing.  '),
                TextSpan(text: ing.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.green)),
                const TextSpan(text: '  asignó al contratista  '),
                TextSpan(text: contratista.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.indigo)),
                const TextSpan(text: '  la labor  '),
                TextSpan(text: laboreo.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.red)),
                const TextSpan(text: '  en la Explotación Agropecuaria  '),
                TextSpan(text: ea.toUpperCase(), style: const TextStyle(fontSize: 18.0, color: Colors.orange)),
                  cereal.isNotEmpty
                  ? TextSpan(
                      children: [
                        TextSpan(text: '  (${cereal.trim()})', style: const TextStyle(fontSize: 18.0, color: Colors.blue))
                      ])
                  : const TextSpan(text: ''),
                const TextSpan(text: '  con fecha límite para el  '),
                TextSpan(text: DateFormat("dd-MM-yyyy").format(fecVto), style: const TextStyle(fontSize: 18.0, color: Colors.purple)),
              ],
            ),
          );
  }
}