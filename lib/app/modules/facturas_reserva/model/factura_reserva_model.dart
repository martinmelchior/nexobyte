//*---------------------------------------------------------------------------  ApiComprobantesPendientesAplicacionResponse
class ApiComprobantesPendientesAplicacionResponse {

  List<ArticuloPendienteItem> listaDeArticulos;

  ApiComprobantesPendientesAplicacionResponse({
    required this.listaDeArticulos
  });

  factory ApiComprobantesPendientesAplicacionResponse.fromJson(Map<String, dynamic> json) => ApiComprobantesPendientesAplicacionResponse(
    listaDeArticulos: List<ArticuloPendienteItem>.from(json["listaDeArticulos"].map((x) => ArticuloPendienteItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeArticulos": List<ArticuloPendienteItem>.from(listaDeArticulos.map((x) => x.toJson())),
  };

}


//*---------------------------------------------------------------------------  ComprobantePendienteItem
class ArticuloPendienteItem {

  int codigo;
  String descripcion;
  double cantidad;
  String um;

  ArticuloPendienteItem({
    required this.codigo,
    required this.descripcion,
    required this.cantidad,
    required this.um,
  });

  factory ArticuloPendienteItem.fromJson(Map json) => ArticuloPendienteItem(
    codigo:       json["codigo"],
    descripcion:  json["descripcion"] ?? '',
    cantidad:     json["cantidad"].toDouble(),
    um:           json["um"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "codigo":       codigo,
    "descripcion":  descripcion,
    "cantidad":     cantidad,
    "um":           um,
  };
}