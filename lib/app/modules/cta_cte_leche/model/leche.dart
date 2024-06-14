import 'package:nexobyte/app/data/models/cta_cte_leche_resumen.dart';

class ObtenerMORequest {
  String tokenDeRefresco;
  String empresaId;
  int clienteId;
  int clienteTamboId;
  DateTime fechaConsulta;
  int top;
  String? expresionSort;

  ObtenerMORequest({
    required this.tokenDeRefresco,
    required this.empresaId,
    required this.clienteId,
    required this.clienteTamboId,
    required this.fechaConsulta,
    required this.top,
    this.expresionSort,
  });
}




class ObtenerMOResponse {

  List<AlertaAnalisisOficialItem> listaMO;

  ObtenerMOResponse({this.listaMO = const []});

  factory ObtenerMOResponse.fromJson(Map<String, dynamic> json) =>
    ObtenerMOResponse(
      listaMO: List<AlertaAnalisisOficialItem>.from(json["listaMO"].map((x) => AlertaAnalisisOficialItem.fromJson(x))
    ),
  );

  Map<String, dynamic> toJson() => {
    "listaMO": List<AlertaAnalisisOficialItem>.from(listaMO.map((x) => x.toJson())),
  };
}
