
//!-------------------------------------------------------------- CtaCteResumenDeSaldosItem

import 'cta_cte_resumen_mensual_a_vencer.dart';

class CtaCteResumenDeSaldosItem {
  
  String gEconomicoId;
  String empresaId;
  String empresa;
  int clienteId;
  String cliente;
  double saldo;
  bool alertaControlDeCheques;
  //-- ADD 2.2
  bool usaCtaCteDolares;
  double saldoAVencer;
  List<SaldoAVencerItem> listaSaldosAVencer;
  double saldoVencido;
  //-- ADD 3.2
  int? nroCtaCte;

  CtaCteResumenDeSaldosItem({
    required this.gEconomicoId,
    required this.empresaId,
    required this.empresa,
    required this.clienteId,
    required this.cliente,
    required this.saldo,
    required this.alertaControlDeCheques,
    //-- ADD 2.2
    required this.usaCtaCteDolares,
    required this.saldoAVencer,
    this.listaSaldosAVencer = const [],
    required this.saldoVencido,
    //-- ADD 3.2
    this.nroCtaCte = 0
  });

  factory CtaCteResumenDeSaldosItem.fromJson(Map json) => CtaCteResumenDeSaldosItem(
    gEconomicoId:           json["gEconomicoId"],
    empresaId:              json["empresaId"],
    empresa:                json["empresa"],
    clienteId:              json["clienteId"],
    cliente:                json["cliente"],
    saldo:                  json["saldo"],
    alertaControlDeCheques: json["alertaControlDeCheques"],
    //-- ADD 2.2
    usaCtaCteDolares:       json["usaCtaCteDolares"] ?? false,
    saldoAVencer:           json["saldoAVencer"],
    listaSaldosAVencer:     List<SaldoAVencerItem>.from(json["listaSaldosAVencer"].map((x) => SaldoAVencerItem.fromJson(x))),   //! ADD v1.9
    saldoVencido:           json["saldoVencido"] ?? 0,
    //-- ADD 3.2
    nroCtaCte:              json["nroCtaCte"] ?? 0,
  );

   Map<String, dynamic> toJson() => {
      "gEconomicoId":           gEconomicoId,
      "empresaId":              empresaId,
      "empresa":                empresa,
      "clienteId":              clienteId,
      "cliente":                cliente,
      "saldo":                  saldo,
      "alertaControlDeCheques": alertaControlDeCheques,
      //-- ADD 2.2
      "usaCtaCteDolares":       usaCtaCteDolares,
      "saldoAVencer":           saldoAVencer,
      "listaSaldosAVencer":     List<dynamic>.from(listaSaldosAVencer.map((x) => x.toJson())),   //! ADD v1.9 - dynamic to Fix
      "saldoVencido":           saldoVencido,
      //-- ADD 3.2
      "nroCtaCte":              nroCtaCte,
    };
}


class CtaCteResumenDeSaldosResponse {

  List<CtaCteResumenDeSaldosItem> listaDeSaldosDeCtasCtes;

  CtaCteResumenDeSaldosResponse({
    required this.listaDeSaldosDeCtasCtes
  });

  factory CtaCteResumenDeSaldosResponse.fromJson(Map<String, dynamic> json) => CtaCteResumenDeSaldosResponse(
    listaDeSaldosDeCtasCtes: List<CtaCteResumenDeSaldosItem>.from(json["listaDeSaldosDeCtasCtes"].map((x) => CtaCteResumenDeSaldosItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeSaldosDeCtasCtes": List<CtaCteResumenDeSaldosItem>.from(listaDeSaldosDeCtasCtes.map((x) => x.toJson())),
  };

}