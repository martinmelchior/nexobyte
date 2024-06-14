import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

//*---------------------------------------------------------------------------  LUVIA
class Lluvia {

  int? lluviaId;
  Campania? campania;
  DateTime? fecha;
  ExplotacionAgropecuaria? ea;
  int? precipitacion;
  String? userName;
  bool? permiteEliminar;

  Lluvia({
    this.lluviaId,
    this.campania,
    this.fecha,
    this.ea,
    this.precipitacion,
    this.userName,
    this.permiteEliminar
  });

  factory Lluvia.fromJson(Map json) => Lluvia(
    lluviaId:         json["lluviaId"] ?? -1,
    campania:         Campania.fromJson(json["campania"]),
    fecha:            DateTime.parse(json["fecha"]),
    ea:               ExplotacionAgropecuaria.fromJson(json["ea"]),
    precipitacion:    json["precipitacion"] ?? 0,
    userName:         json["userName"] ?? '',
    permiteEliminar:  json["permiteEliminar"] ?? false,
  );

  // TODO: TIENE QUE PASAR LA FECHA EN FORMATO SINO DA ERROR
  Map<String, dynamic> toJson() => {
      "lluviaId":         lluviaId,
      "campania":         campania,
      "fecha":            fecha!.toIso8601String(),
      "ea":               ea,
      "precipitacion":    precipitacion,
      "userName":         userName,
      "permiteEliminar":  permiteEliminar,
    };

}

//*---------------------------------------------------------------------------  EiminarLluviaRequest
class EliminarLluviaRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  Lluvia? lluvia;
  
  EliminarLluviaRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.lluvia,
  });

  factory EliminarLluviaRequest.fromJson(Map json) => EliminarLluviaRequest(
    gEconomicoId:     json["gEconomicoId"],
    empresaId:        json["empresaId"],
    tokenDeRefresco:  json["tokenDeRefresco"],
    lluvia:           Lluvia.fromJson(json["lluvia"]),
  );

   Map<String, dynamic> toJson() => {
      "gEconomicoId":    gEconomicoId,
      "empresaId":       empresaId,
      "tokenDeRefresco": tokenDeRefresco,
      "lluvia":          lluvia,
    };
}

//*---------------------------------------------------------------------------  ApiLluviasRequest
class LluviasRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  Lluvia? lluvia;
  
  LluviasRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.lluvia,
  });

  factory LluviasRequest.fromJson(Map json) => LluviasRequest(
    gEconomicoId:     json["gEconomicoId"],
    empresaId:        json["empresaId"],
    tokenDeRefresco:  json["tokenDeRefresco"],
    lluvia:           Lluvia.fromJson(json["lluvia"]),
  );

   Map<String, dynamic> toJson() => {
      "gEconomicoId":    gEconomicoId,
      "empresaId":       empresaId,
      "tokenDeRefresco": tokenDeRefresco,
      "lluvia":          lluvia,
    };
}

//*---------------------------------------------------------------------------  ApiLluviasResponse
class LluviasResponse {
  
  String tokenDeAcceso;
  List<Lluvia> lluvias;

  LluviasResponse({
    this.tokenDeAcceso = '',
    this.lluvias = const [],
  });

  factory LluviasResponse.fromJson(Map json) => LluviasResponse(
    tokenDeAcceso:    json["tokenDeAcceso"],
    lluvias:          List<Lluvia>.from(json["lluvias"].map((x) => Lluvia.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":    tokenDeAcceso,
    "lluvias":          List<Lluvia>.from(lluvias.map((x) => x.toJson())),
  };
}


//*---------------------------------------------------------------------------  ApiSaveLluviaRequest
class SaveLluviaRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  Lluvia? lluvia;
  int contratistaId;
  int ingenieroId;
 
  SaveLluviaRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.lluvia,
    this.contratistaId= -1,
    this.ingenieroId= -1,
  });

}

//*---------------------------------------------------------------------------  ApiSaveLluviaResponse
class SaveLluviaResponse {
  
  String tokenDeAcceso;

  SaveLluviaResponse({
    this.tokenDeAcceso = '',
  });

  factory SaveLluviaResponse.fromJson(Map json) => SaveLluviaResponse(
    tokenDeAcceso:    json["tokenDeAcceso"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":    tokenDeAcceso,
  };
}
