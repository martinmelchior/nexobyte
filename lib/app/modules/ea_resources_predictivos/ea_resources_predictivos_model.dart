//*---------------------------------------------------------------------------  FiltrosObtenerEAsPredictivoRequest
import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

class EAsPredictivoRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int afipCampaniaId;
  int especieId;
 
  EAsPredictivoRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.afipCampaniaId = 0,
    this.especieId = 0,
  });

}


//*---------------------------------------------------------------------------  EAsPredictivoResponse
class EAsPredictivoResponse {
  
  String tokenDeAcceso;
  List<ExplotacionAgropecuaria> eas;
 
  EAsPredictivoResponse({
    this.tokenDeAcceso = '',
    this.eas = const [],
  });

  factory EAsPredictivoResponse.fromJson(Map json) => EAsPredictivoResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    eas:            List<ExplotacionAgropecuaria>.from(json["eas"].map((x) => ExplotacionAgropecuaria.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "eas":            List<ExplotacionAgropecuaria>.from(eas.map((x) => x.toJson())),
  };
}