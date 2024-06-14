
import 'cta_cte_resumen_saldo.dart';

//!-------------------------------------------------------------- SaldoAVencerItem
class SaldoAVencerItem {
  
  DateTime fecha;
  double saldo;

  SaldoAVencerItem({
    required this.fecha,
    required this.saldo,
  });

  factory SaldoAVencerItem.fromJson(Map json) => SaldoAVencerItem(
    fecha:        DateTime.parse(json["fecha"]),
    saldo:        json["saldo"],
  );

   Map<String, dynamic> toJson() => {
      "fecha":        fecha.toIso8601String(),
      "saldo":        saldo,
    };
}

//!-------------------------------------------------------------- ResumenMensualDeSaldosAVencerResponse
class ResumenMensualDeSaldosAVencerResponse {

  String? tokenDeAcceso;
  List<SaldoAVencerItem>? listaSaldosAVencer;

  ResumenMensualDeSaldosAVencerResponse({
    this.tokenDeAcceso,
    this.listaSaldosAVencer = const [],
  });

  factory ResumenMensualDeSaldosAVencerResponse.fromJson(Map<String, dynamic> json) => ResumenMensualDeSaldosAVencerResponse(
    tokenDeAcceso: json["tokenDeAcceso"],
    listaSaldosAVencer: List<SaldoAVencerItem>.from(json["listaSaldosAVencer"].map((x) => SaldoAVencerItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso": tokenDeAcceso,
    "listaSaldosAVencer": List<SaldoAVencerItem>.from(listaSaldosAVencer!.map((x) => x.toJson())),
  };

}

//!-------------------------------------------------------------- ResumenMensualDeSaldosAVencerResponse
class ResumenMensualDeSaldosAVencerRequest {

  String? tokenDeRefresco;
  CtaCteResumenDeSaldosItem? ctaCteResumenDeSaldosItem;

  ResumenMensualDeSaldosAVencerRequest({
    this.tokenDeRefresco,
    this.ctaCteResumenDeSaldosItem,
  });

  factory ResumenMensualDeSaldosAVencerRequest.fromJson(Map<String, dynamic> json) => ResumenMensualDeSaldosAVencerRequest(
    tokenDeRefresco:            json["tokenDeRefresco"],
    ctaCteResumenDeSaldosItem:  json["ctaCteResumenDeSaldosItem"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco":            tokenDeRefresco,
    "ctaCteResumenDeSaldosItem":  ctaCteResumenDeSaldosItem,
  };

}