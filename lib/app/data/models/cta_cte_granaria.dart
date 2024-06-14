//!-------------------------------------------------------------- SaldoPorEspecieItem
class CtaCteProductorEspecieCosechaItem {
  //-- ver comprobante
  String gEconomicoId;
  String empresaId;
  String empresa;
  int clienteId;
  String productor;
  int especieId;
  String especie;
  String cosecha;
  double disponibleKgs;
  double disponibleQq;
  double disponibleTn;

  CtaCteProductorEspecieCosechaItem({
    required this.gEconomicoId,
    required this.empresaId,
    required this.empresa,
    required this.clienteId,
    required this.productor,
    required this.especieId,
    required this.especie,
    required this.cosecha,
    required this.disponibleKgs,
    required this.disponibleQq,
    required this.disponibleTn,
  });

  factory CtaCteProductorEspecieCosechaItem.fromJson(Map json) => CtaCteProductorEspecieCosechaItem(
      gEconomicoId: json["gEconomicoId"],
      empresaId: json["empresaId"],
      empresa: json["empresa"],
      clienteId: json["clienteId"],
      productor: json["productor"],
      especieId: json["especieId"],
      especie: json["especie"],
      cosecha: json["cosecha"],
      disponibleKgs: json["disponibleKgs"],
      disponibleQq: json["disponibleQq"],
      disponibleTn: json["disponibleTn"],
    );

   Map<String, dynamic> toJson() => {
      "empresaId": empresaId,
      "gEconomicoId": gEconomicoId,
      "empresa": empresa,
      "clienteId": clienteId,
      "productor": productor,
      "especieId": especieId,
      "especie": especie,
      "cosecha": cosecha,
      "disponibleKgs": disponibleKgs,
      "disponibleQq": disponibleQq,
      "disponibleTn": disponibleTn,
    };
}

class CtaCteProductorEspecieCosechaResponse {

  List<CtaCteProductorEspecieCosechaItem> listaDeSaldoProductorEspecieCosecha;

  CtaCteProductorEspecieCosechaResponse({
    this.listaDeSaldoProductorEspecieCosecha = const []
  });

  factory CtaCteProductorEspecieCosechaResponse.fromJson(Map<String, dynamic> json) => CtaCteProductorEspecieCosechaResponse(
    listaDeSaldoProductorEspecieCosecha: List<CtaCteProductorEspecieCosechaItem>.from(json["listaDeSaldoProductorEspecieCosecha"].map((x) => CtaCteProductorEspecieCosechaItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeSaldoProductorEspecieCosecha": List<CtaCteProductorEspecieCosechaItem>.from(listaDeSaldoProductorEspecieCosecha.map((x) => x.toJson())),
  };

}




class SaldoPorEspecieItem {
  
  String especie;
  double disponibleKgs;
  double disponibleQq;
  double disponibleTn;

  SaldoPorEspecieItem({
    required this.especie,
    required this.disponibleKgs,
    required this.disponibleQq,
    required this.disponibleTn,
  });

  factory SaldoPorEspecieItem.fromJson(Map json) => SaldoPorEspecieItem(
    especie:        json["especie"],
    disponibleKgs:  json["disponibleKgs"],
    disponibleQq:   json["disponibleQq"],
    disponibleTn:   json["disponibleTn"],
  );

   Map<String, dynamic> toJson() => {
      "especie":        especie,
      "disponibleKgs":  disponibleKgs,
      "disponibleQq":   disponibleQq,
      "disponibleTn":   disponibleTn,
    };
}

class SaldosPorEspecieResponse {

  List<SaldoPorEspecieItem> listaDeSaldosPorEspecie;

  SaldosPorEspecieResponse({
    this.listaDeSaldosPorEspecie = const []
  });

  factory SaldosPorEspecieResponse.fromJson(Map<String, dynamic> json) => SaldosPorEspecieResponse(
    listaDeSaldosPorEspecie: List<SaldoPorEspecieItem>.from(json["listaDeSaldosPorEspecie"].map((x) => SaldoPorEspecieItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeSaldosPorEspecie": List<SaldoPorEspecieItem>.from(listaDeSaldosPorEspecie.map((x) => x.toJson())),
  };

}

class DetalleCtaCteGranariaResponse 
{
  double ultimoSaldo;
  List<DetalleCtaCteGranariaItem> listaDetalleCtaCteGranariaItem;

  DetalleCtaCteGranariaResponse({
    this.ultimoSaldo = 0,
    this.listaDetalleCtaCteGranariaItem = const [],
  });

  factory DetalleCtaCteGranariaResponse.fromJson(Map<String, dynamic> json) => DetalleCtaCteGranariaResponse(
    ultimoSaldo: json["ultimoSaldo"],
    listaDetalleCtaCteGranariaItem: List<DetalleCtaCteGranariaItem>.from(json["listaDetalleCtaCteGranaria"].map((x) => DetalleCtaCteGranariaItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ultimoSaldo": ultimoSaldo,
    "listaDetalleCtaCteGranariaItem": List<DetalleCtaCteGranariaItem>.from(listaDetalleCtaCteGranariaItem.map((x) => x.toJson())),
  };
}


//!-------------------------------------------------------------- DetalleCtaCteGranariaRequest
class DetalleCtaCteGranariaRequest 
{
  String tokenDeRefresco;
  String gEconomicoId;
  String empresaId;
  int clienteId;
  int especieId;
  String cosecha;
  int pageNro;
  int pageSize;
  double ultimoSaldo;

  DetalleCtaCteGranariaRequest({
    this.tokenDeRefresco = '',
    this.gEconomicoId = '',
    this.empresaId = '',
    this.clienteId = 0,
    this.especieId = 0,
    this.cosecha = '',
    this.pageNro = 1,
    this.pageSize = 100,
    this.ultimoSaldo = 0,
  });

  factory DetalleCtaCteGranariaRequest.fromJson(Map json) => DetalleCtaCteGranariaRequest(
      tokenDeRefresco: json["tokenDeRefresco"],
      gEconomicoId: json["gEconomicoId"] ?? '',
      empresaId: json["empresaId"],
      clienteId: json["clienteId"],
      especieId: json["especieId"],
      cosecha: json["cosecha"],
      pageNro: json["pageNro"],
      pageSize: json["pageSize"],
      ultimoSaldo: json["ultimoSaldo"],
    );

   Map<String, dynamic> toJson() => {
      "tokenDeRefresco": tokenDeRefresco,
      "gEconomicoId": gEconomicoId,
      "empresaId": empresaId,
      "clienteId": clienteId,
      "especieId": especieId,
      "cosecha": cosecha,
      "pageNro": pageNro,
      "pageSize": pageSize,
      "ultimoSaldo": ultimoSaldo,
    };
}

class DetalleCtaCteGranariaItem {

  int cartaPorteId;
  int idAnalisisDescarga;
  double importe;
  DateTime fecha;
  String comprobanteRespaldo;
  String nro;
  String nroCert;
  double saldo;
  String campoProcedencia;
  String localidadProcedencia;
  String provinciaProcedencia;
  String nombreChofer;
  String patente;
  String? imagenCPEID;

  DetalleCtaCteGranariaItem({
    required this.cartaPorteId,
    required this.idAnalisisDescarga,
    required this.importe,
    required this.fecha,
    required this.comprobanteRespaldo,
    required this.nro,
    required this.nroCert,
    required this.saldo,
    required this.campoProcedencia,
    required this.localidadProcedencia,
    required this.provinciaProcedencia,
    required this.nombreChofer,
    required this.patente,
    required this.imagenCPEID,
  });

  factory DetalleCtaCteGranariaItem.fromJson(Map json) => DetalleCtaCteGranariaItem(
      cartaPorteId:             json["cartaPorteId"],
      idAnalisisDescarga:       json["idAnalisisDescarga"],
      importe:                  json["importe"],
      fecha:                    DateTime.parse(json["fecha"]),
      comprobanteRespaldo:      json["comprobanteRespaldo"],
      nro:                      json["nro"],
      nroCert:                  json["nroCert"],
      saldo:                    json["saldo"],
      campoProcedencia:         json["campoProcedencia"],
      localidadProcedencia:     json["localidadProcedencia"],
      provinciaProcedencia:     json["provinciaProcedencia"],
      nombreChofer:             json["nombreChofer"],
      patente:                  json["patente"],
      imagenCPEID:              json["imagenCPEID"],
    );

   Map<String, dynamic> toJson() => {
      "cartaPorteId":           cartaPorteId,
      "idAnalisisDescarga":     idAnalisisDescarga,
      "importe":                importe,
      "fecha":                  fecha,
      "comprobanteRespaldo":    comprobanteRespaldo,
      "nro":                    nro,
      "nroCert":                nroCert,
      "saldo":                  saldo,
      "campoProcedencia":       campoProcedencia,
      "localidadProcedencia":   localidadProcedencia,
      "provinciaProcedencia":   provinciaProcedencia,
      "nombreChofer":           nombreChofer,
      "patente":                patente,
      "imagenCPEID":            imagenCPEID,
    };
}

