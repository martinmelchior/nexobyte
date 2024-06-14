


//*-------------------------------------------------------------- DownloadComprobanteRequest
class DownloadComprobanteRequest {
  
  String? tokenDeRefresco;
  String? gEconomicoId;
  String? empresaId;
  String? guidComprobante;
  int? ctaCteId;
  String? tituloPage;
  String? comprobanteAliasName;

  DownloadComprobanteRequest({
    this.tokenDeRefresco,
    this.gEconomicoId,
    this.empresaId,
    this.guidComprobante,
    this.ctaCteId,
    this.tituloPage,
    this.comprobanteAliasName,
  });

  factory DownloadComprobanteRequest.fromJson(Map json) => DownloadComprobanteRequest(
    tokenDeRefresco:          json["tokenDeRefresco"] ?? '',
    gEconomicoId:             json["gEconomicoId"] ?? '',
    empresaId:                json["empresaId"] ?? '',
    guidComprobante:          json["guidComprobante"] ?? '',
    ctaCteId:                 json["ctaCteId"] ?? -1,
    tituloPage:               json["tituloPage"] ?? '',
    comprobanteAliasName:     json["comprobanteAliasName"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco":        tokenDeRefresco,
    "gEconomicoId":           gEconomicoId,
    "empresaId":              empresaId,
    "guidComprobante":        guidComprobante,
    "ctaCteId":               ctaCteId,
    "tituloPage":             tituloPage,
    "comprobanteAliasName":   comprobanteAliasName,
  };
}


//*-------------------------------------------------------------- DownloadComprobanteResponse
class DownloadComprobanteResponse {
  
  String? fileName;
  String? fileUrl;
  String? fileExtension;
  List<DownloadComprobante> listaDeComprobantes;

  DownloadComprobanteResponse({
    this.fileName,
    this.fileUrl,
    this.fileExtension,
    this.listaDeComprobantes = const []
  });

  factory DownloadComprobanteResponse.fromJson(Map json) => DownloadComprobanteResponse(
    fileName:             json["fileName"] ?? '',
    fileUrl:              json["fileUrl"] ?? '',
    fileExtension:        json["fileExtension"] ?? '',
    listaDeComprobantes:  List<DownloadComprobante>.from(json["listaDeComprobantes"].map((x) => DownloadComprobante.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fileName":             fileName,
    "fileUrl":              fileUrl,
    "fileExtension":        fileExtension,
    "listaDeComprobantes":  List<DownloadComprobante>.from(listaDeComprobantes.map((x) => x.toJson())),
  };
}


//*-------------------------------------------------------------- DownloadComprobante
class DownloadComprobante {
  
  String? fileName;
  String? fileUrl;
  String? fileExtension;

  DownloadComprobante({
    this.fileName,
    this.fileUrl,
    this.fileExtension,
  });

  factory DownloadComprobante.fromJson(Map json) => DownloadComprobante(
    fileName:             json["fileName"] ?? '',
    fileUrl:              json["fileUrl"] ?? '',
    fileExtension:        json["fileExtension"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "fileName":             fileName,
    "fileUrl":              fileUrl,
    "fileExtension":        fileExtension,
  };
}