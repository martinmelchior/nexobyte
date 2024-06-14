


//*---------------------------------------------------------------------------  EAEspecieEnCampaniaRequest
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

class EAEspecieEnCampaniaRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int afipCampaniaId;
 
  EAEspecieEnCampaniaRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.afipCampaniaId = 0,
  });

}


//*---------------------------------------------------------------------------  EAUaDestinoRequest
class EAUaDestinoRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int clienteId;
 
  EAUaDestinoRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.clienteId = 0,
  });

}


//*---------------------------------------------------------------------------  LotesPorCampaniaEspecieEARequest
class LotesPorCampaniaEspecieEARequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int clienteId;
  int afipCampaniaId;
  int especieId;
 
  LotesPorCampaniaEspecieEARequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.clienteId = 0,
    this.afipCampaniaId = 0,
    this.especieId = 0,
  });

}

//*---------------------------------------------------------------------------  LotesPorCampaniaEspecieEAResponse
class LotesPorCampaniaEspecieEAResponse {
  
  String tokenDeAcceso;
  List<Lote> lotes;
 
  LotesPorCampaniaEspecieEAResponse({
    this.tokenDeAcceso = '',
    this.lotes = const [],
  });

  factory LotesPorCampaniaEspecieEAResponse.fromJson(Map json) => LotesPorCampaniaEspecieEAResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    lotes:          List<Lote>.from(json["lotes"].map((x) => Lote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "lotes":          List<Lote>.from(lotes.map((x) => x.toJson())),
  };
}


//*---------------------------------------------------------------------------  LotesPorCampaniaEARequest
class LotesPorCampaniaEARequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int clienteId;
  int afipCampaniaId;
 
  LotesPorCampaniaEARequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.clienteId = 0,
    this.afipCampaniaId = 0,
  });

}

//*---------------------------------------------------------------------------  LotesPorCampaniaEAResponse
class LotesPorCampaniaEAResponse {
  
  String tokenDeAcceso;
  List<Lote> lotes;
 
  LotesPorCampaniaEAResponse({
    this.tokenDeAcceso = '',
    this.lotes = const [],
  });

  factory LotesPorCampaniaEAResponse.fromJson(Map json) => LotesPorCampaniaEAResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    lotes:          List<Lote>.from(json["lotes"].map((x) => Lote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "lotes":          List<Lote>.from(lotes.map((x) => x.toJson())),
  };
}