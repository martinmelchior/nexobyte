
//*---------------------------------------------------------------------------  Cliente
class Cliente {

  int? clienteId;
  String? nombre;
  String? nroCtaCte;

  Cliente({
    this.clienteId,
    this.nombre,
    this.nroCtaCte,
  });

  factory Cliente.fromJson(Map json) => Cliente(
    clienteId:        json["clienteId"],
    nombre:           json["nombre"],
    nroCtaCte:        json["nroCtaCte"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId":        clienteId,
    "nombre":           nombre,
    "nroCtaCte":        nroCtaCte,
  };
}

//*---------------------------------------------------------------------------  ComprobantePendienteItem
class ComprobantePendienteItem {
  
  DateTime fecha;
  DateTime fVto;
  String tipoComprobante;
  String nroComprobante;
  double debe;
  double haber;
  double importe;
  double saldo;
  double importeDolar;
  double saldoDolar;
  bool vencido;

  ComprobantePendienteItem({
    required this.fecha,
    required this.fVto,
    required this.tipoComprobante,
    required this.nroComprobante,
    required this.debe,
    required this.haber,
    required this.importe,
    required this.saldo,
    required this.importeDolar,
    required this.saldoDolar,
    required this.vencido,
  });

  factory ComprobantePendienteItem.fromJson(Map json) => ComprobantePendienteItem(
    fecha:            DateTime.parse(json["fecha"]),
    fVto:             DateTime.parse(json["fVto"]),
    tipoComprobante:  json["tipoComprobante"] ?? '',
    nroComprobante:   json["nroComprobante"] ?? '',
    debe:             json["debe"].toDouble(),
    haber:            json["haber"].toDouble(),
    importe:          json["importe"].toDouble(),
    saldo:            json["saldo"].toDouble(),
    importeDolar:     json["importeDolar"].toDouble(),
    saldoDolar:       json["saldoDolar"].toDouble(),
    vencido:          json["vencido"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "fecha":            fecha,
    "fVto":             fVto,
    "tipoComprobante":  tipoComprobante,
    "nroComprobante":   nroComprobante,
    "debe":             debe,
    "haber":            haber,
    "importe":          importe,
    "saldo":            saldo,
    "importeDolar":     importeDolar,
    "saldoDolar":       saldoDolar,
    "vencido":          vencido,
  };
}

//*---------------------------------------------------------------------------  ComprobantesPendientesRequest
class ComprobantesPendientesRequest {

  String tokenDeRefresco;

  ComprobantesPendientesRequest({
    this.tokenDeRefresco = '',
  });

}


//*---------------------------------------------------------------------------  ComprobantesPendientesResponse
class ComprobantesPendientesResponse {

  bool mostrarColumnaDolar;
  List<ComprobantePendienteItem> listaDeComprobantesPendientes;

  ComprobantesPendientesResponse({
    this.mostrarColumnaDolar = false,
    required this.listaDeComprobantesPendientes
  });

  factory ComprobantesPendientesResponse.fromJson(Map<String, dynamic> json) => ComprobantesPendientesResponse(
    mostrarColumnaDolar:           json["mostrarColumnaDolar"] ?? false,
    listaDeComprobantesPendientes: List<ComprobantePendienteItem>.from(json["listaDeComprobantesPendientes"].map((x) => ComprobantePendienteItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mostrarColumnaDolar":           mostrarColumnaDolar,
    "listaDeComprobantesPendientes": List<ComprobantePendienteItem>.from(listaDeComprobantesPendientes.map((x) => x.toJson())),
  };

}

//*---------------------------------------------------------------------------  CompPendientesDownloadResponse
class CompPendientesDownloadResponse {

  bool generando;

  CompPendientesDownloadResponse({
    this.generando = false,
  });

}

