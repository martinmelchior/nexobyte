//*---------------------------------------------------------------------------  ApiComprobantesPendientesAplicacionResponse
class ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse {

  List<RemitosSinFacturarSubtotal> listaDeSubTotal;
  List<RESinFacturarPorArticulo> listaDeRE;
  List<RSSinFacturarPorArticulo> listaDeRS;
  List<DetallePorArticulo> listaDetallePorArticulo;
  double saldo;

  ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse({
    required this.listaDeSubTotal,
    required this.listaDeRE,
    required this.listaDeRS,
    required this.listaDetallePorArticulo,
    this.saldo = 0.0,
  });

  factory ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse.fromJson(Map<String, dynamic> json) => ApiRemitosSinFacturarPrecioActualValorizadoDolarResponse(
    listaDeSubTotal: List<RemitosSinFacturarSubtotal>.from(json["listaDeSubTotal"].map((x) => RemitosSinFacturarSubtotal.fromJson(x))),
    listaDeRE: List<RESinFacturarPorArticulo>.from(json["listaDeRE"].map((x) => RESinFacturarPorArticulo.fromJson(x))),
    listaDeRS: List<RSSinFacturarPorArticulo>.from(json["listaDeRS"].map((x) => RSSinFacturarPorArticulo.fromJson(x))),
    listaDetallePorArticulo: List<DetallePorArticulo>.from(json["listaDetallePorArticulo"].map((x) => DetallePorArticulo.fromJson(x))),
    saldo: json["saldo"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "listaDeSubTotal": List<RemitosSinFacturarSubtotal>.from(listaDeSubTotal.map((x) => x.toJson())),
    "listaDeRE": List<RemitosSinFacturarSubtotal>.from(listaDeRE.map((x) => x.toJson())),
    "listaDeRS": List<RemitosSinFacturarSubtotal>.from(listaDeRS.map((x) => x.toJson())),
    "listaDetallePorArticulo": List<DetallePorArticulo>.from(listaDetallePorArticulo.map((x) => x.toJson())),
    "saldo": saldo,
  };

}


//*---------------------------------------------------------------------------  RemitosSinFacturarSubtotal
class RemitosSinFacturarSubtotal {

  String codTipoDeRemito;
  String tipoDeRemito;
  double subTotal;

  RemitosSinFacturarSubtotal({
    required this.codTipoDeRemito,
    required this.tipoDeRemito,
    required this.subTotal,
  });

  factory RemitosSinFacturarSubtotal.fromJson(Map json) => RemitosSinFacturarSubtotal(
    codTipoDeRemito:  json["codTipoDeRemito"],
    tipoDeRemito:     json["tipoDeRemito"] ?? '',
    subTotal:         json["subTotal"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "codTipoDeRemito":  codTipoDeRemito,
    "tipoDeRemito":     tipoDeRemito,
    "subTotal":         subTotal,
  };
}

//*---------------------------------------------------------------------------  RESinFacturarPorArticulo
class RESinFacturarPorArticulo {

  String codTipoDeRemito;
  String tipoDeRemito;
  double codArticulo;
  String articulo;
  double cantPendiente;
  double subTotal;

  RESinFacturarPorArticulo({
    required this.codTipoDeRemito,
    required this.tipoDeRemito,
    required this.codArticulo,
    required this.articulo,
    required this.cantPendiente,
    required this.subTotal,
  });

  factory RESinFacturarPorArticulo.fromJson(Map json) => RESinFacturarPorArticulo(
    codTipoDeRemito:  json["codTipoDeRemito"],
    tipoDeRemito:     json["tipoDeRemito"] ?? '',
    codArticulo:      json["codArticulo"].toDouble(),
    articulo:         json["articulo"] ?? '',
    cantPendiente:    json["cantPendiente"].toDouble(),
    subTotal:         json["subTotal"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "codTipoDeRemito":  codTipoDeRemito,
    "tipoDeRemito":     tipoDeRemito,
    "codArticulo":      codArticulo,
    "articulo":         articulo,
    "cantPendiente":    cantPendiente,
    "subTotal":         subTotal,
  };
}

//*---------------------------------------------------------------------------  RSSinFacturarPorArticulo
class RSSinFacturarPorArticulo {

  String codTipoDeRemito;
  String tipoDeRemito;
  double codArticulo;
  String articulo;
  double cantPendiente;
  double subTotal;

  RSSinFacturarPorArticulo({
    required this.codTipoDeRemito,
    required this.tipoDeRemito,
    required this.codArticulo,
    required this.articulo,
    required this.cantPendiente,
    required this.subTotal,
  });

  factory RSSinFacturarPorArticulo.fromJson(Map json) => RSSinFacturarPorArticulo(
    codTipoDeRemito:  json["codTipoDeRemito"],
    tipoDeRemito:     json["tipoDeRemito"] ?? '',
    codArticulo:      json["codArticulo"].toDouble(),
    articulo:         json["articulo"] ?? '',
    cantPendiente:    json["cantPendiente"].toDouble(),
    subTotal:         json["subTotal"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "codTipoDeRemito":  codTipoDeRemito,
    "tipoDeRemito":     tipoDeRemito,
    "codArticulo":      codArticulo,
    "articulo":         articulo,
    "cantPendiente":    cantPendiente,
    "subTotal":         subTotal,
  };
}


//*---------------------------------------------------------------------------  DetallePorArticulo
class DetallePorArticulo {

  String codTipoDeRemito;
  String tipoDeRemito;
  double codArticulo;
  String articulo;
  double cantPendiente;
  double subTotal;

  DetallePorArticulo({
    required this.codTipoDeRemito,
    required this.tipoDeRemito,
    required this.codArticulo,
    required this.articulo,
    required this.cantPendiente,
    required this.subTotal,
  });

  factory DetallePorArticulo.fromJson(Map json) => DetallePorArticulo(
    codTipoDeRemito:  json["codTipoDeRemito"],
    tipoDeRemito:     json["tipoDeRemito"] ?? '',
    codArticulo:      json["codArticulo"].toDouble(),
    articulo:         json["articulo"] ?? '',
    cantPendiente:    json["cantPendiente"].toDouble(),
    subTotal:         json["subTotal"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "codTipoDeRemito":  codTipoDeRemito,
    "tipoDeRemito":     tipoDeRemito,
    "codArticulo":      codArticulo,
    "articulo":         articulo,
    "cantPendiente":    cantPendiente,
    "subTotal":         subTotal,
  };
}