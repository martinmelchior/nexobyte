
//!-------------------------------------------------------------- CtaCteResumenDeSaldosItem

import 'cta_cte_resumen_saldo.dart';

class DetalleCtaCteItem {
  
  DateTime fecha;
  String? detalle;
  double debe;
  double haber;
  double importe;
  double saldo;
  DateTime? vto;
  String? nroContrato;
  //!-- ADD 2.6
  int olId;
  //-- ver comprobante
  String? comprobanteImagenId;
  int? ctaCteId;

  DetalleCtaCteItem({
    required this.fecha,
    this.detalle,
    required this.debe,
    required this.haber,
    required this.importe,
    required this.saldo,
    this.vto,
    this.nroContrato,
    //!-- ADD 2.6      
    required this.olId,
    //-- ver comprobante
    this.comprobanteImagenId,  
    this.ctaCteId,
  });

  factory DetalleCtaCteItem.fromJson(Map json) => DetalleCtaCteItem(
    fecha:                DateTime.parse(json["fecha"]),
    detalle:              json["detalle"] ?? '',
    debe:                 json["debe"].toDouble(),
    haber:                json["haber"].toDouble(),
    importe:              json["importe"].toDouble(),
    saldo:                json["saldo"].toDouble(),
    vto:                  json["vto"] != null ? DateTime.parse(json["vto"]) : null,
    nroContrato:          json["nroContrato"],
    //!-- ADD 2.6   
    olId:                 json["olId"],         
    //-- ver comprobante
    comprobanteImagenId:  json["comprobanteImagenId"],         
    ctaCteId:             json["ctaCteId"] ?? -1,         
  );

   Map<String, dynamic> toJson() => {
      "fecha":                fecha,
      "detalle":              detalle,
      "debe":                 debe,
      "haber":                haber,
      "importe":              importe,
      "saldo":                saldo,
      "vto":                  vto,
      "nroContrato":          nroContrato,
      //!-- ADD 2.6       
      "olId":                 olId,     
      //-- ver comprobante        
      "comprobanteImagenId":  comprobanteImagenId,             
      "ctaCteId":             ctaCteId,             
    };
}

class DetalleCtaCteResponse {

  String? tokenDeAcceso;
  CtaCteResumenDeSaldosItem? resumenDeSaldoItem;    
  List<DetalleCtaCteItem>? listaDetalleCtaCteItem;
  double? ultimoSaldo;
  //!-- ADD 2.7
  bool showResumenOL;

  DetalleCtaCteResponse({
    this.tokenDeAcceso,
    this.resumenDeSaldoItem,
    this.listaDetalleCtaCteItem = const [],
    this.ultimoSaldo = 0,
    //!-- ADD 2.7
    this.showResumenOL = false,
  });

  factory DetalleCtaCteResponse.fromJson(Map<String, dynamic> json) => DetalleCtaCteResponse(
    tokenDeAcceso: json["tokenDeAcceso"],
    resumenDeSaldoItem: CtaCteResumenDeSaldosItem.fromJson(json["resumenDeSaldoItem"]),
    listaDetalleCtaCteItem: List<DetalleCtaCteItem>.from(json["listaDetalleCtaCte"].map((x) => DetalleCtaCteItem.fromJson(x))),
    ultimoSaldo: json["ultimoSaldo"],
    //!-- ADD 2.7
    showResumenOL: json["showResumenOL"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso": tokenDeAcceso,
    "resumenDeSaldoItem": CtaCteResumenDeSaldosItem.fromJson(resumenDeSaldoItem!.toJson()),
    "listaDetalleCtaCteItem": List<DetalleCtaCteItem>.from(listaDetalleCtaCteItem!.map((x) => x.toJson())),
    "ultimoSaldo": ultimoSaldo,
    //!-- ADD 2.7
    "showResumenOL": showResumenOL,
  };

}

class DetalleCtaCteRequest {

  String? tokenDeRefresco;
  CtaCteResumenDeSaldosItem? ctaCteResumenDeSaldosItem;
  DateTime? fd;
  DateTime? fh;
  int pageSize;
  int pageNro;
  String? fieldName;
  bool? isAsc;
  double? ultimoSaldo;

  DetalleCtaCteRequest({
    this.tokenDeRefresco,
    this.ctaCteResumenDeSaldosItem,
    this.fd,
    this.fh,
    this.pageSize = 50,
    this.pageNro = 1,
    this.fieldName,
    this.isAsc,
    this.ultimoSaldo = 0,
  });

  factory DetalleCtaCteRequest.fromJson(Map<String, dynamic> json) => DetalleCtaCteRequest(
    tokenDeRefresco:            json["tokenDeRefresco"],
    ctaCteResumenDeSaldosItem:  json["ctaCteResumenDeSaldosItem"],
    fd:                         json["fd"],
    fh:                         json["fh"],
    pageSize:                   json["pageSize"],
    pageNro:                    json["pageNro"],
    fieldName:                  json["fieldName"],
    isAsc:                      json["isAsc"],
    ultimoSaldo:                json["ultimoSaldo"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco":            tokenDeRefresco,
    "ctaCteResumenDeSaldosItem":  ctaCteResumenDeSaldosItem,
    "fd":                         fd,
    "fh":                         fh,
    "pageSize":                   pageSize,
    "pageNro":                    pageNro,
    "fieldName":                  fieldName,
    "isAsc":                      isAsc,
    "ultimoSaldo":                ultimoSaldo,
  };

}

//!-- ADD 3.0
class GenerarResumenXlsPdfResponse {

  String? link;
  String? fileName;
  String? linkPdf;
  String? fileNamePdf;

  GenerarResumenXlsPdfResponse({
    this.link = '',
    this.fileName = '',
    this.linkPdf = '',
    this.fileNamePdf = '',
  });

  factory GenerarResumenXlsPdfResponse.fromJson(Map<String, dynamic> json) => GenerarResumenXlsPdfResponse(
    link:         json["link"],
    fileName:     json["fileName"],
    linkPdf:      json["linkPdf"],
    fileNamePdf:  json["fileNamePdf"],
  );

  Map<String, dynamic> toJson() => {
    "link":         link,
    "fileName":     fileName,
    "linkPdf":      linkPdf,
    "fileNamePdf":  fileNamePdf,
  };

}