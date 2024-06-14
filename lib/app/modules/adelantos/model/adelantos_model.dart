
enum TipoDeCuenta { cuentaspropias, otrascuentas, todas }

extension TipoDeCuentaEx on TipoDeCuenta {
  String get toValueText {
    switch (this) {
      case TipoDeCuenta.cuentaspropias:
        return "cuentaspropias";
      case TipoDeCuenta.otrascuentas:
        return "otrascuentas";
      default:
        return "todas";
    }
  }
   String get toValueSqlFilter {
    switch (this) {
      case TipoDeCuenta.cuentaspropias:
        return "CUENTAS PROPIAS";
      case TipoDeCuenta.otrascuentas:
        return "OTRAS CUENTAS";
      default:
        return "";
    }
  }
}



class GenericoRequest {
  String tokenDeRefresco;
  String gEconomicoId;
  String empresaId;
  int clienteId;
  int? solicitudId;
  
  GenericoRequest({
    required this.tokenDeRefresco,
    required this.gEconomicoId,
    required this.empresaId,
    required this.clienteId,
    required this.solicitudId,
  });

  factory GenericoRequest.fromJson(Map json) => GenericoRequest(
    tokenDeRefresco:  json["tokenDeRefresco"],
    gEconomicoId:     json["gEconomicoId"],
    empresaId:        json["empresaId"],
    clienteId:        json["clienteId"],
    solicitudId:      json["solicitudId"],
  );

   Map<String, dynamic> toJson() => {
    "tokenDeRefresco":  tokenDeRefresco,
    "gEconomicoId":     gEconomicoId,
    "empresaId":        empresaId,
    "clienteId":        clienteId,
    "solicitudId":      solicitudId,
  };
}


//!-------------------------------------------------------------- ObtenerSolicitudesRequest
class ObtenerSolicitudesRequest 
{
  String tokenDeRefresco;
  int pageSize;
  int pageNro;

  ObtenerSolicitudesRequest({
    this.tokenDeRefresco = '',
    this.pageSize = 100,
    this.pageNro = 1,
  });

  factory ObtenerSolicitudesRequest.fromJson(Map json) => ObtenerSolicitudesRequest(
    tokenDeRefresco: json["tokenDeRefresco"],
    pageSize:        json["pageSize"],
    pageNro:         json["pageNro"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco": tokenDeRefresco,
    "pageSize":        pageSize,
    "pageNro":         pageNro,
  };
}


//!-------------------------------------------------------------- SOCheque
class SOCheque 
{
  int? chequeId;
  String? estado;
  int? banId;
  String? banco;
  DateTime? fechaVto;
  double? importe;
  String? aNombreDe;

  SOCheque({
    this.chequeId,
    this.estado,
    this.banId,
    this.banco,
    this.fechaVto,
    this.importe,
    this.aNombreDe,
  });

  factory SOCheque.fromJson(Map json) => SOCheque(
    chequeId:     json["chequeId"] ?? -1,
    estado:       json["estado"] ?? '',
    banId:        json["banId"] ?? -1,
    banco:        json["banco"] ?? '',
    fechaVto:     json["fechaVto"] != null ? DateTime.parse(json["fechaVto"]) : null,    /* fecha: DateTime.parse(json["fecha"]),  ya lo tengo en formato datetime */
    importe:      json["importe"] ?? 0.0,
    aNombreDe:    json["aNombreDe"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "chequeId":   chequeId,
    "estado":     estado,
    "banId":      banId,
    "banco":      banco,
    "fechaVto":   fechaVto == null ? null : fechaVto!.toIso8601String(),
    "importe":    importe,
    "aNombreDe":  aNombreDe,
  };
}


//!-------------------------------------------------------------- SOEfectivo
class SOEfectivo 
{
  int? efectivoId;
  DateTime? fechaEntrega;
  String? estado;
  double? importe;

  SOEfectivo({
    this.efectivoId,
    this.fechaEntrega,
    this.estado,
    this.importe
  });

  factory SOEfectivo.fromJson(Map json) => SOEfectivo(
    efectivoId:   json["efectivoId"] ?? -1,
    fechaEntrega: json["fechaEntrega"] != null ? DateTime.parse(json["fechaEntrega"]) : null,    /* fecha: DateTime.parse(json["fecha"]),  ya lo tengo en formato datetime */
    estado:       json["estado"] ?? '',
    importe:      json["importe"] ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
    "efectivoId":   efectivoId,
    "fechaEntrega": fechaEntrega == null ? null : fechaEntrega!.toIso8601String(),
    "estado":       estado,
    "importe":      importe,
  };
}


//!-------------------------------------------------------------- SOTransferencia
class SOTransferencia 
{
  int? transferenciaId;
  String? tipoDeCuenta;
  String? estado;
  String? descripcion;
  String? banco;
  String? cbuAlias;
  DateTime? fechaTransferencia;
  double? importe;
  String? cuit;

  SOTransferencia({
    this.transferenciaId,
    this.tipoDeCuenta,
    this.estado,
    this.descripcion,
    this.banco,
    this.cbuAlias,
    this.fechaTransferencia,
    this.importe,
    this.cuit,
  });

  factory SOTransferencia.fromJson(Map json) => SOTransferencia(
    transferenciaId:    json["transferenciaId"] ?? -1,
    tipoDeCuenta:       json["tipoDeCuenta"] ?? '',
    estado:             json["estado"] ?? '',
    descripcion:        json["descripcion"] ?? '',
    banco:              json["banco"] ?? '',
    cbuAlias:           json["cbuAlias"] ?? '',
    fechaTransferencia: DateTime.parse(json["fechaTransferencia"]),
    importe:            json["importe"] ?? 0.0,
    cuit:               json["cuit"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "transferenciaId":    transferenciaId,
    "tipoDeCuenta":       tipoDeCuenta,
    "estado":             estado,
    "descripcion":        descripcion,
    "banco":              banco,
    "cbuAlias":           cbuAlias,
    "fechaTransferencia": fechaTransferencia == null ? null : fechaTransferencia!.toIso8601String(),
    "importe":            importe,
    "cuit":               cuit,
  };
}


//!-------------------------------------------------------------- Solicitud
class Solicitud 
{
  String? gEconomicoId;
  String? empresaId;
  String? empresa;
  int? clienteId;
  int? nroCtaCte;
  String? cliente;
  int? solicitudId;
  String? usuarioCarga;
  DateTime? fechaCarga;
  String? estado;
  String? observacion;
  double? totalEfectivo;
  double? totalCheques;
  double? totalTransferencias;
  double? totalTransferenciasPropias;
  double? totalTransferenciasOtras;
  double? totalSolicitud;
  // DateTime? fechaAprobacion;
  // DateTime? fechaRechazo;
  List<SOCheque> listaDeCheques;
  List<SOEfectivo> listaDeEfectivo;
  List<SOTransferencia> listaDeTransferenciasPropias;
  List<SOTransferencia> listaDeTransferenciasOtras;
  String? motivoDeRechazo;

  Solicitud({
    this.gEconomicoId,
    this.empresaId,
    this.empresa,
    this.clienteId,
    this.nroCtaCte,
    this.cliente,
    this.solicitudId,
    this.usuarioCarga,
    this.fechaCarga,
    this.estado,
    this.observacion,
    this.totalEfectivo,
    this.totalCheques,
    this.totalTransferencias,
    this.totalTransferenciasPropias,
    this.totalTransferenciasOtras,
    this.totalSolicitud,
    // this.fechaAprobacion,
    // this.fechaRechazo,
    this.listaDeCheques = const [],
    this.listaDeEfectivo = const [],
    this.listaDeTransferenciasPropias = const [],
    this.listaDeTransferenciasOtras = const [],
    this.motivoDeRechazo,
  });

  factory Solicitud.fromJson(Map json) => Solicitud(
    gEconomicoId:                 json["gEconomicoId"] ?? '',
    empresaId:                    json["empresaId"] ?? '',
    empresa:                      json["empresa"] ?? '',
    clienteId:                    json["clienteId"] ?? -1,
    nroCtaCte:                    json["nroCtaCte"] ?? -1,
    cliente:                      json["cliente"] ?? '',
    solicitudId:                  json["solicitudId"] ?? -1,
    usuarioCarga:                 json["usuarioCarga"] ?? '',
    fechaCarga:                   DateTime.parse(json["fechaCarga"]) ,
    estado:                       json["estado"] ?? '',
    observacion:                  json["observacion"] ?? '',
    totalEfectivo:                json["totalEfectivo"] ?? 0.0,
    totalCheques:                 json["totalCheques"] ?? 0.0,
    totalTransferencias:          json["totalTransferencias"] ?? 0.0,
    totalTransferenciasPropias:   json["totalTransferenciasPropias"] ?? 0.0,
    totalTransferenciasOtras:     json["totalTransferenciasOtras"] ?? 0.0,
    totalSolicitud:               json["totalSolicitud"] ?? 0.0,
    // fechaAprobacion:              json["fechaAprobacion"] != null ? DateTime.parse(json["fechaAprobacion"]) : null,
    // fechaRechazo:                 json["fechaRechazo"] != null ? DateTime.parse(json["fechaRechazo"]) : null,
    listaDeCheques:               json["listaDeCheques"] == null ? const [] : List<SOCheque>.from(json["listaDeCheques"].map((x) => SOCheque.fromJson(x))),   
    listaDeEfectivo:              json["listaDeEfectivo"] == null ? const [] :List<SOEfectivo>.from(json["listaDeEfectivo"].map((x) => SOEfectivo.fromJson(x))),   
    listaDeTransferenciasPropias: json["listaDeTransferenciasPropias"] == null ? const [] :List<SOTransferencia>.from(json["listaDeTransferenciasPropias"].map((x) => SOTransferencia.fromJson(x))),   
    listaDeTransferenciasOtras:   json["listaDeTransferenciasOtras"] == null ? const [] :List<SOTransferencia>.from(json["listaDeTransferenciasOtras"].map((x) => SOTransferencia.fromJson(x))),   
    motivoDeRechazo:              json["motivoDeRechazo"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId":                 gEconomicoId,
    "empresaId":                    empresaId,
    "empresa":                      empresa,
    "clienteId":                    clienteId,
    "nroCtaCte":                    nroCtaCte,
    "cliente":                      cliente,
    "solicitudId":                  solicitudId,
    "usuarioCarga":                 usuarioCarga,
    "fechaCarga":                   fechaCarga == null ? null : fechaCarga!.toIso8601String(),
    "estado":                       estado,
    "observacion":                  observacion,
    "totalEfectivo":                totalEfectivo,
    "totalCheques":                 totalCheques,
    "totalTransferencias":          totalTransferencias,
    "totalTransferenciasPropias":   totalTransferenciasPropias,
    "totalTransferenciasOtras":     totalTransferenciasOtras,
    "totalSolicitud":               totalSolicitud,
    //"fechaAprobacion":              fechaAprobacion == null ? null : fechaAprobacion!.toIso8601String(),
    //"fechaRechazo":                 fechaRechazo == null ? null : fechaRechazo!.toIso8601String(),
    "listaDeCheques":               List<dynamic>.from(listaDeCheques.map((x) => x.toJson())),   
    "listaDeEfectivo":              List<dynamic>.from(listaDeEfectivo.map((x) => x.toJson())),  
    "listaDeTransferenciasPropias": List<dynamic>.from(listaDeTransferenciasPropias.map((x) => x.toJson())),  
    "listaDeTransferenciasOtras":   List<dynamic>.from(listaDeTransferenciasOtras.map((x) => x.toJson())),  
    "motivoDeRechazo":              motivoDeRechazo,
  };
}



//!-------------------------------------------------------------- ObtenerSolicitudesResponse
class ObtenerSolicitudesResponse 
{
  List<Solicitud> listaDeSolicitudes;

  ObtenerSolicitudesResponse({
    this.listaDeSolicitudes = const [],
  });

  factory ObtenerSolicitudesResponse.fromJson(Map json) => ObtenerSolicitudesResponse(
    listaDeSolicitudes: List<Solicitud>.from(json["listaDeSolicitudes"].map((x) => Solicitud.fromJson(x))),   
  );

  Map<String, dynamic> toJson() => {
    "listaDeSolicitudes": List<Solicitud>.from(listaDeSolicitudes.map((x) => x.toJson())),  
  };
}



//!-------------------------------------------------------------- SOCtaCteOrigen
class SOCtaCteOrigen 
{
  int clienteId;
  String cliente;
  int nroCtaCte;
  String gEconomicoId;
  String empresaId;
  String empresa;

  SOCtaCteOrigen({
    this.clienteId    = -1,
    this.cliente      = '',
    this.nroCtaCte    = -1,
    this.gEconomicoId = '',
    this.empresaId    = '',
    this.empresa      = '',
  });

  factory SOCtaCteOrigen.fromJson(Map json) => SOCtaCteOrigen(
    clienteId:    json["clienteId"],
    cliente:      json["cliente"],
    nroCtaCte:    json["nroCtaCte"],
    gEconomicoId: json["gEconomicoId"],
    empresaId:    json["empresaId"],
    empresa:      json["empresa"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId":    clienteId,
    "cliente":      cliente,
    "nroCtaCte":    nroCtaCte,
    "gEconomicoId": gEconomicoId,
    "empresaId":    empresaId,
    "empresa":      empresa,
  };

}

//!-------------------------------------------------------------- ObtenerCtasCtesOrigenResponse
class ObtenerCtasCtesOrigenResponse 
{
  List<SOCtaCteOrigen> listaDeCtasCtesOrigen;

  ObtenerCtasCtesOrigenResponse({
    this.listaDeCtasCtesOrigen = const [],
  });

  factory ObtenerCtasCtesOrigenResponse.fromJson(Map json) => ObtenerCtasCtesOrigenResponse(
    listaDeCtasCtesOrigen: List<SOCtaCteOrigen>.from(json["listaDeCtasCtesOrigen"].map((x) => SOCtaCteOrigen.fromJson(x))),   
  );

  Map<String, dynamic> toJson() => {
    "listaDeCtasCtesOrigen": List<SOCtaCteOrigen>.from(listaDeCtasCtesOrigen.map((x) => x.toJson())),  
  };
}



//!-------------------------------------------------------------- SOBanco
class SOBanco 
{
  int banId;
  String nombre;
  bool defaultInApp;

  SOBanco({
    this.banId = -1,
    this.nombre = '',
    this.defaultInApp = false,
  });

  factory SOBanco.fromJson(Map json) => SOBanco(
    banId:        json["banId"],
    nombre:       json["nombre"],
    defaultInApp: json["defaultInApp"],
  );

  Map<String, dynamic> toJson() => {
    "banId":        banId,
    "nombre":       nombre,
    "defaultInApp": defaultInApp,
  };
}

//!-------------------------------------------------------------- ObtenerBancosResponse
class ObtenerBancosResponse 
{
  List<SOBanco> listaDeBancos;

  ObtenerBancosResponse({
    this.listaDeBancos = const [],
  });

  factory ObtenerBancosResponse.fromJson(Map json) => ObtenerBancosResponse(
    listaDeBancos: List<SOBanco>.from(json["listaDeBancos"].map((x) => SOBanco.fromJson(x))),   
  );

  Map<String, dynamic> toJson() => {
    "listaDeBancos": List<SOBanco>.from(listaDeBancos.map((x) => x.toJson())),  
  };
}


//!-------------------------------------------------------------- Agenda Cbu
class AgendaCbu 
{
  int id;
  String cbuAlias;
  String tipoDeCuenta;
  String descripcion;
  String cuit;
  String banco;
  String tipoDeCuentaEnBanco;

  AgendaCbu({
    this.id = -1,
    this.cbuAlias = '',
    this.tipoDeCuenta = '',
    this.descripcion = '',
    this.cuit = '',
    this.banco = '',
    this.tipoDeCuentaEnBanco = '',
  });

  factory AgendaCbu.fromJson(Map json) => AgendaCbu(
    id:                   json["id"],
    cbuAlias:             json["cbuAlias"],
    tipoDeCuenta:         json["tipoDeCuenta"],     
    descripcion:          json["descripcion"],
    cuit:                 json["cuit"],
    banco:                json["banco"] ?? '',
    tipoDeCuentaEnBanco:  json["tipoDeCuentaEnBanco"] ?? '',     
  );

  Map<String, dynamic> toJson() => {
    "id":                   id,
    "cbuAlias":             cbuAlias,
    "tipoDeCuenta":         tipoDeCuenta,
    "descripcion":          descripcion,
    "cuit":                 cuit,
    "banco":                banco,
    "tipoDeCuentaEnBanco":  tipoDeCuentaEnBanco,
  };

  @override
  String toString() => '$descripcion\n$cbuAlias\n$cuit'.toUpperCase();

  
}


//*---------------------------------------------------------------------------  AgendaCbuResponse
class AgendaCbuResponse {
  
  List<AgendaCbu> listaDeCbuAlias;

  AgendaCbuResponse({
    this.listaDeCbuAlias = const [],
  });

  factory AgendaCbuResponse.fromJson(Map json) => AgendaCbuResponse(
    listaDeCbuAlias:  List<AgendaCbu>.from(json["listaDeCbuAlias"].map((x) => AgendaCbu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeCbuAlias":  List<AgendaCbu>.from(listaDeCbuAlias.map((x) => x.toJson())),
  };
}



//!-------------------------------------------------------------- SOTipoDeCuenta
class SOTipoDeCuenta 
{
  String tipoCuentaId;
  String tipoCuenta;

  SOTipoDeCuenta({
    this.tipoCuentaId = '',
    this.tipoCuenta = '',
  });

  factory SOTipoDeCuenta.fromJson(Map json) => SOTipoDeCuenta(
    tipoCuentaId: json["tipoCuentaId"],
    tipoCuenta:   json["tipoCuenta"],
  );

  Map<String, dynamic> toJson() => {
    "tipoCuentaId": tipoCuentaId,
    "tipoCuenta":   tipoCuenta,
  };
}

//*---------------------------------------------------------------------------  TiposDeCuentasResponse
class TiposDeCuentasResponse {
  
  List<SOTipoDeCuenta> listaTiposDeCuentas;

  TiposDeCuentasResponse({
    this.listaTiposDeCuentas = const [],
  });

  factory TiposDeCuentasResponse.fromJson(Map json) => TiposDeCuentasResponse(
    listaTiposDeCuentas:  List<SOTipoDeCuenta>.from(json["listaTiposDeCuentas"].map((x) => SOTipoDeCuenta.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaTiposDeCuentas":  List<SOTipoDeCuenta>.from(listaTiposDeCuentas.map((x) => x.toJson())),
  };
}



//*---------------------------------------------------------------------------  GuardarSolicitudRequest
class GuardarSolicitudRequest {
  
  GenericoRequest request;
  Solicitud solicitud;

  GuardarSolicitudRequest({
    required this.request,
    required this.solicitud,
  });

  factory GuardarSolicitudRequest.fromJson(Map json) => GuardarSolicitudRequest(
    request:    json["request"],
    solicitud:  json["solicitud"],
  );

  Map<String, dynamic> toJson() => {
    "request": request,
    "solicitud": solicitud,
  };
}
