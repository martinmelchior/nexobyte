
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';





class MovimientoInterno {

  int?                      movId;
  Lote?                     lote;
  UA?                       ua;
  double?                   cantidad;
  ExplotacionAgropecuaria?  ea; 
  Campania?                 campania;
  Especie?                  especie;
  String?                   estado;
  DateTime?                 fechaDescarga;
  String?                   usuarioCreacion;

  MovimientoInterno({
      this.movId,
      this.lote,
      this.ua,
      this.cantidad,
      this.campania,
      this.especie,
      this.estado,
      this.ea,
      this.fechaDescarga,
      this.usuarioCreacion,
  });

  factory MovimientoInterno.fromJson(Map json) =>
    MovimientoInterno(
      movId:          json["movId"] ?? -1,
      especie:        Especie.fromJson(json["especie"]),
      ea:             ExplotacionAgropecuaria.fromJson(json["ea"]),
      campania:       Campania.fromJson(json["campania"]),
      lote:           Lote.fromJson(json["lote"]),
      ua:             UA.fromJson(json["ua"]),
      cantidad:       json["cantidad"],
      estado:         json["estado"] ?? '',
      fechaDescarga:  json["fechaDescarga"] != null ? DateTime.parse(json["fechaDescarga"]) : null,    /* fecha: DateTime.parse(json["fecha"]),  ya lo tengo en formato datetime */
      usuarioCreacion:json["usuarioCreacion"] ?? '',
    );
  
  Map<String, dynamic> toJson() => {
      "movId":          movId,
      "campania":       campania!.toJson(),
      "especie":        especie!.toJson(),
      "ea":             ea!.toJson(),
      "lote":           lote!.toJson(),
      "ua":             ua!.toJson(),
      "cantidad":       cantidad,
      "estado":         estado,
      "fechaDescarga":  fechaDescarga!.toIso8601String(),
      "usuarioCreacion":usuarioCreacion,
    };
}



//*---------------------------------------------------------------------------  EAResourcesResponse
class EAEspecieEnCampaniaResponse {
  
  String tokenDeAcceso;
  List<Especie> especies;
 
  EAEspecieEnCampaniaResponse({
    this.tokenDeAcceso = '',
    this.especies = const [],
  });

  factory EAEspecieEnCampaniaResponse.fromJson(Map json) => EAEspecieEnCampaniaResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    especies:       List<Especie>.from(json["especies"].map((x) => Especie.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "especies":       List<Especie>.from(especies.map((x) => x.toJson())),
  };
}







//*---------------------------------------------------------------------------  ApiUAsPorCampaniaEspecieEARequest
class UAsPorCampaniaEspecieEARequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int clienteId;
  int afipCampaniaId;
  int especieId;
 
  UAsPorCampaniaEspecieEARequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.clienteId = 0,
    this.afipCampaniaId = 0,
    this.especieId = 0,
  });

}

//*---------------------------------------------------------------------------  ApiUAsPorCampaniaEspecieEAResponse
class UAsPorCampaniaEspecieEAResponse {
  
  String tokenDeAcceso;
  List<UA> uas;
 
  UAsPorCampaniaEspecieEAResponse({
    this.tokenDeAcceso = '',
    this.uas = const [],
  });

  factory UAsPorCampaniaEspecieEAResponse.fromJson(Map json) => UAsPorCampaniaEspecieEAResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    uas:            List<UA>.from(json["uas"].map((x) => UA.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "uas":            List<UA>.from(uas.map((x) => x.toJson())),
  };
}




//*---------------------------------------------------------------------------  ApiMovimientoRequest
class MovimientoRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  MovimientoInterno? movInterno;
  int contratistaId;
  int ingenieroId;
 
  MovimientoRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.movInterno,
    this.contratistaId= -1,
    this.ingenieroId= -1,
  });

}

//*---------------------------------------------------------------------------  ApiMovimientoResponse
class MovimientoResponse {
  
  String tokenDeAcceso;
  List<MovimientoInterno> movimientos;

  MovimientoResponse({
    this.tokenDeAcceso = '',
    this.movimientos = const [],
  });

  factory MovimientoResponse.fromJson(Map json) => MovimientoResponse(
    tokenDeAcceso:    json["tokenDeAcceso"],
    movimientos:      List<MovimientoInterno>.from(json["movimientos"].map((x) => MovimientoInterno.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":    tokenDeAcceso,
    "movimientos":      List<MovimientoInterno>.from(movimientos.map((x) => x.toJson())),
  };
}