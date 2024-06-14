
//!-- ADD 2.7 (todas las clases)
//*-------------------------------------------------------------- ResumenOperarioOlsItem
class ResumenOperarioOlsItem {
  
    final String operario;
    final String campania;
    final String especie;
    final double totalHas;
    final double totalPesos;

    ResumenOperarioOlsItem({
      this.operario = '',
      this.campania = '',
      this.especie = '',
      this.totalHas = 0.0,
      this.totalPesos = 0.0,
    });

    factory ResumenOperarioOlsItem.fromJson(Map<String, dynamic> json) => ResumenOperarioOlsItem(
      operario    : json["operario"] ?? '',
      campania    : json["campania"] ?? '',
      especie     : json["especie"] ?? '',
      totalHas    : json["totalHas"] ?? 0.0,
      totalPesos  : json["totalPesos"] ?? 0.0,
    );

    Map<String, dynamic> toJson() => {
      "operario"  : operario,
      "campania"  : campania,
      "especie"   : especie,
      "totalHas"  : totalHas,
      "totalPesos": totalPesos,
    };
}


//*---------------------------------------------------------------------------  ResumenOperarioOlsRequest
class ResumenOperarioOlsRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int clienteId;
 
  ResumenOperarioOlsRequest({
    this.gEconomicoId     = '',
    this.empresaId        = '',
    this.tokenDeRefresco  = '',
    this.clienteId        = 0,
  });

  factory ResumenOperarioOlsRequest.fromJson(Map json) => ResumenOperarioOlsRequest(
    gEconomicoId:     json["gEconomicoId"]    ?? '',
    empresaId:        json["empresaId"]       ?? '',
    tokenDeRefresco:  json["tokenDeRefresco"] ?? '',
    clienteId:        json["clienteId"]       ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId":     gEconomicoId,
    "empresaId":        empresaId,
    "tokenDeRefresco":  tokenDeRefresco,
    "clienteId":        clienteId,
  };
}

//*---------------------------------------------------------------------------  ResumenOperarioOlsResponse
class ResumenOperarioOlsResponse {
  
  String tokenDeAcceso;
  List<ResumenOperarioOlsItem> listaDeItems;
 
  ResumenOperarioOlsResponse({
    this.tokenDeAcceso = '',
    this.listaDeItems = const [],
  });

  factory ResumenOperarioOlsResponse.fromJson(Map json) => ResumenOperarioOlsResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    listaDeItems:   List<ResumenOperarioOlsItem>.from(json["listaDeItems"].map((x) => ResumenOperarioOlsItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "listaDeItems":   List<ResumenOperarioOlsItem>.from(listaDeItems.map((x) => x.toJson())),
  };
}