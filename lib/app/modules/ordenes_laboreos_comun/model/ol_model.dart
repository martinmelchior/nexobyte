//*---------------------------------------------------------------------------  EAResourcesRequest
import 'package:nexobyte/app/data/models/cotizacion_model.dart';

class EAResourcesRequest {
  
  String gEconomicoId;
  String empresaId;
  int afipCampaniaId;
  int especieId;
  String tokenDeRefresco;
 
  EAResourcesRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.afipCampaniaId = 0,
    this.especieId = 0,
    this.tokenDeRefresco = ''
  });

}

//*---------------------------------------------------------------------------  EAResourcesResponse
class EAResourcesResponse {
  
  String tokenDeAcceso;
  int nextOlId;
  double cotizacionDolar;
  List<Campania> campanias;
  List<Ingeniero> ingenieros;
  List<Especie> especies;
  List<Laboreo> laboreos;
  List<Contratista> contratistas;
  List<Cotizacion> cotizaciones;
  List<UA> uasOrigen;
  List<Transportista> transportistas;
  //List<ExplotacionAgropecuaria> eas;
  //List<Lote> lotes;
 
  EAResourcesResponse({
    this.tokenDeAcceso = '',
    this.nextOlId = -1,
    this.cotizacionDolar = 0.0,
    this.campanias = const [],
    this.ingenieros = const [],
    this.especies = const [],
    this.laboreos = const [],
    this.contratistas = const [],
    this.cotizaciones = const [],
    this.uasOrigen = const [],
    //this.eas = const [],
    //this.lotes = const []
    this.transportistas = const [],
  });

  factory EAResourcesResponse.fromJson(Map json) => EAResourcesResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    nextOlId:       json["nextOlId"],
    cotizacionDolar:json["cotizacionDolar"],
    campanias:      List<Campania>.from(json["campanias"].map((x) => Campania.fromJson(x))),
    ingenieros:     List<Ingeniero>.from(json["ingenieros"].map((x) => Ingeniero.fromJson(x))),
    especies:       List<Especie>.from(json["especies"].map((x) => Especie.fromJson(x))),
    laboreos:       List<Laboreo>.from(json["laboreos"].map((x) => Laboreo.fromJson(x))),
    contratistas:   List<Contratista>.from(json["contratistas"].map((x) => Contratista.fromJson(x))),
    cotizaciones:   List<Cotizacion>.from(json["cotizaciones"].map((x) => Cotizacion.fromJson(x))),
    uasOrigen:      List<UA>.from(json["uasOrigen"].map((x) => UA.fromJson(x))),
    //eas:            List<ExplotacionAgropecuaria>.from(json["eas"].map((x) => ExplotacionAgropecuaria.fromJson(x))),
    //lotes:          List<Lote>.from(json["lotes"].map((x) => Lote.fromJson(x))),
    transportistas: List<Transportista>.from(json["transportistas"].map((x) => Transportista.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "tokenDeAcceso":  tokenDeAcceso,
      "nextOlId":       nextOlId,
      "cotizacionDolar":cotizacionDolar,
      "campanias":      List<Campania>.from(campanias.map((x) => x.toJson())),
      "ingeniero":      List<Ingeniero>.from(ingenieros.map((x) => x.toJson())),
      "especies":       List<Especie>.from(especies.map((x) => x.toJson())),
      "laboreos":       List<Laboreo>.from(laboreos.map((x) => x.toJson())),
      "contratistas":   List<Contratista>.from(contratistas.map((x) => x.toJson())),
      "cotizaciones":   List<Cotizacion>.from(cotizaciones.map((x) => x.toJson())),
      "uasOrigen":      List<UA>.from(uasOrigen.map((x) => x.toJson())),
      //"eas":            List<ExplotacionAgropecuaria>.from(eas.map((x) => x.toJson())),
      //"lotes":          List<Lote>.from(lotes.map((x) => x.toJson())),
      "transportistas":   List<Transportista>.from(transportistas.map((x) => x.toJson())),
  };

}

//*--------------------------------------------------------------------------- CAMPANIA
class Campania {

  int? afipCampaniaId;
  String? codigo;
  String? descripcion;

  Campania({
    this.afipCampaniaId,
    this.codigo,
    this.descripcion,
  });

  factory Campania.fromJson(Map json) => Campania(
    afipCampaniaId: json["afipCampaniaId"],
    codigo:         json["codigo"],
    descripcion:    json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
      "afipCampaniaId":   afipCampaniaId,
      "codigo":           codigo,
      "descripcion":      descripcion,
  };
}

//*--------------------------------------------------------------------------- EA
class ExplotacionAgropecuaria {

  int? clienteId;
  String? clienteNombre;
  //List<Lote>? lotes;

  ExplotacionAgropecuaria({
    this.clienteId,
    this.clienteNombre,
    //this.lotes,
  });

  factory ExplotacionAgropecuaria.fromJson(Map json) => ExplotacionAgropecuaria(
    clienteId:     json["clienteId"],
    clienteNombre: json["clienteNombre"],
    //lotes:         List<Lote>.from(json["lotes"].map((x) => Lote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clienteId":      clienteId,
    "clienteNombre":  clienteNombre,
    //"lotes":          List<Lote>.from(lotes!.map((x) => x.toJson())),
  };
}

//*---------------------------------------------------------------------------  UA
class UA {

  int? uaId;
  String? uaNombre;

  UA({
    this.uaId,
    this.uaNombre,
  });

  factory UA.fromJson(Map json) => UA(
    uaId:               json["uaId"],
    uaNombre:           json["uaNombre"],
  );

  Map<String, dynamic> toJson() => {
    "uaId":               uaId,
    "uaNombre":           uaNombre,
  };
}

//*---------------------------------------------------------------------------  lote
class Lote {

  int? explotacionLoteId;
  int? loteId;
  String? loteNombre;
  int? clienteId;
  String? clienteNombre;
  int? afipCampaniaId;
  String? campaniaDescripcion;
  int? oncaEspecieId;
  String? especieNombre;
  double? cantHas;
  double? cantHasTrabajadas;
  bool? seleccionado;
  List<OLAbmInsumoLote>? insumos;

  Lote({
    this.explotacionLoteId,
    this.loteId,
    this.loteNombre,
    this.clienteId,
    this.clienteNombre,
    this.afipCampaniaId,
    this.campaniaDescripcion,
    this.oncaEspecieId,
    this.especieNombre,
    this.cantHas,
    this.cantHasTrabajadas,
    this.seleccionado,
    this.insumos
  });

  factory Lote.fromJson(Map json) => Lote(
    explotacionLoteId:    json["explotacionLoteId"],
    loteId:               json["loteId"],
    loteNombre:           json["loteNombre"],
    clienteId:            json["clienteId"],
    clienteNombre:        json["clienteNombre"],
    afipCampaniaId:       json["afipCampaniaId"],
    campaniaDescripcion:  json["campaniaDescripcion"],
    oncaEspecieId:        json["oncaEspecieId"],
    especieNombre:        json["especieNombre"],
    cantHas:              json["cantHas"] ?? 0.0,
    cantHasTrabajadas:    json["cantHasTrabajadas"] ?? json["cantHas"] ?? 0.0,
    seleccionado:         json["seleccionado"] ?? true,
    insumos:              json["insumos"] == null ? const [] : List<OLAbmInsumoLote>.from(json["insumos"].map((x) => OLAbmInsumoLote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "explotacionLoteId":    explotacionLoteId,
    "loteId":               loteId,
    "loteNombre":           loteNombre,
    "clienteId":            clienteId,
    "clienteNombre":        clienteNombre,
    "afipCampaniaId":       afipCampaniaId,
    "campaniaDescripcion":  campaniaDescripcion,
    "oncaEspecieId":        oncaEspecieId,
    "especieNombre":        especieNombre,
    "cantHas":              cantHas,
    "cantHasTrabajadas":    cantHasTrabajadas,
    "seleccionado":         seleccionado,
    "insumos":              List<dynamic>.from(insumos!.map((x) => x.toJson())),
  };
}

//*---------------------------------------------------------------------------  Ingeniero
class Ingeniero {

  int? clienteId;
  String? nombre;
  String? nroCtaCte;

  Ingeniero({
    this.clienteId,
    this.nombre,
    this.nroCtaCte,
  });

  factory Ingeniero.fromJson(Map json) => Ingeniero(
    clienteId:        json["clienteId"],
    nombre:           json["nombre"],
    nroCtaCte:        json["nroCtaCte"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId":        clienteId,
    "nombre":           nombre,
    "nroCtaCte":        nroCtaCte,
  };
}

//*---------------------------------------------------------------------------  Contratista
class Contratista {

  int? clienteId;
  String? nombre;
  String? nroCtaCte;

  Contratista({
    this.clienteId,
    this.nombre,
    this.nroCtaCte,
  });

  factory Contratista.fromJson(Map json) => Contratista(
    clienteId:        json["clienteId"],
    nombre:           json["nombre"],
    nroCtaCte:        json["nroCtaCte"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId":        clienteId,
    "nombre":           nombre,
    "nroCtaCte":        nroCtaCte,
  };
}

//*---------------------------------------------------------------------------  Especie
class Especie {

  int? especieId;
  String? nombre;

  Especie({
    this.especieId,
    this.nombre,
  });

  factory Especie.fromJson(Map json) => Especie(
    especieId:        json["especieId"],
    nombre:           json["nombre"],
  );

  Map<String, dynamic> toJson() => {
    "especieId":        especieId,
    "nombre":           nombre,
  };
}

//*---------------------------------------------------------------------------  Laboreo
class Laboreo {

  int? laboreoId;
  String? laboreo;
  bool? visible;
  int? eaCentroDeCostoId;
  int? articuloFacId;
  bool? asociaInsumos;
  bool? permiteFacturarCero;

  Laboreo({
    this.laboreoId,
    this.laboreo,
    this.visible,
    this.eaCentroDeCostoId,
    this.articuloFacId,
    this.asociaInsumos,
    this.permiteFacturarCero,
  }); 

  factory Laboreo.fromJson(Map json) => Laboreo(
    laboreoId:          json["laboreoId"],
    laboreo:            json["laboreo"],
    visible:            json["visible"],
    eaCentroDeCostoId:  json["eaCentroDeCostoId"],
    articuloFacId:      json["articuloFacId"],
    asociaInsumos:      json["asociaInsumos"] ?? false,
    permiteFacturarCero:json["permiteFacturarCero"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "laboreoId":           laboreoId,
    "laboreo":             laboreo,
    "visible":             visible,
    "eaCentroDeCostoId":   eaCentroDeCostoId,
    "articuloFacId":       articuloFacId,
    "asociaInsumos":       asociaInsumos ?? false,
    "permiteFacturarCero": permiteFacturarCero ?? false,
  };
}

//*---------------------------------------------------------------------------  EAResourcesRequest
class EACampaniaEspecieRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int afipCampaniaId;
  int especieId;
 
  EACampaniaEspecieRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.afipCampaniaId = 0,
    this.especieId = 0,
  });

}

//*---------------------------------------------------------------------------  EAResourcesResponse
class EACampaniaEspecieResponse {
  
  String tokenDeAcceso;
  List<ExplotacionAgropecuaria> eas;
 
  EACampaniaEspecieResponse({
    this.tokenDeAcceso = '',
    this.eas = const [],
  });

  factory EACampaniaEspecieResponse.fromJson(Map json) => EACampaniaEspecieResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    eas:            List<ExplotacionAgropecuaria>.from(json["eas"].map((x) => ExplotacionAgropecuaria.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "eas":            List<ExplotacionAgropecuaria>.from(eas.map((x) => x.toJson())),
  };
}

//*---------------------------------------------------------------------------  EACampaniaRequest
class EACampaniaRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int afipCampaniaId;
 
  EACampaniaRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.afipCampaniaId = 0,
  });

}

//*---------------------------------------------------------------------------  EACampaniaResponse
class EACampaniaResponse {
  
  String tokenDeAcceso;
  List<ExplotacionAgropecuaria> eas;
 
  EACampaniaResponse({
    this.tokenDeAcceso = '',
    this.eas = const [],
  });

  factory EACampaniaResponse.fromJson(Map json) => EACampaniaResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    eas:            List<ExplotacionAgropecuaria>.from(json["eas"].map((x) => ExplotacionAgropecuaria.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "eas":            List<ExplotacionAgropecuaria>.from(eas.map((x) => x.toJson())),
  };
}

//*---------------------------------------------------------------------------  OLAbmRequest
class OLAbmRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int olId;
 
  OLAbmRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.olId = 0,
  });

}

//*---------------------------------------------------------------------------  OLABM
class OLAbm {
  String?                   gEconomicoId;
  String?                   empresaId;
  int?                      olId;
  ExplotacionAgropecuaria?  ea;
  Ingeniero?                ingeniero;
  Contratista?              contratista;
  Campania?                 campania;
  Laboreo?                  laboreo;
  UA?                       uaOrigen;
  UA?                       uaDestino;
  double?                   tipoCambio;             //- Cotizacion Dolar
  double?                   precioHaPesos;          //- PrecioHectarea
  double?                   totalPesos;             //- TotalLaboreo
  double?                   precioHaDolar;          //- PrecioHectareaDolar
  double?                   totalDolar;             //- TotalLaboreoDolar
  DateTime?                 fecEmi;
  DateTime?                 fecVto;
  String?                   observacion;
  String?                   estado;
  double?                   cantTotalHas;           //- TotalLaboreoDolar
  List<Lote>                lotes;
  List<OLAbmTotalInsumo>    totalInsumos;

  OLAbm({
    this.gEconomicoId,  
    this.empresaId,
    this.olId,
    this.ea,
    this.ingeniero,
    this.contratista,
    this.campania,
    this.laboreo,
    this.uaOrigen,
    this.uaDestino,
    this.tipoCambio,
    this.precioHaPesos,
    this.totalPesos,
    this.precioHaDolar,
    this.totalDolar,
    this.fecEmi,
    this.fecVto,
    this.observacion,
    this.estado,
    this.cantTotalHas,
    this.lotes = const [],
    this.totalInsumos = const [],
  });

  factory OLAbm.fromJson(Map json) => OLAbm(
    gEconomicoId:   json["gEconomicoId"] ?? '',
    empresaId:      json["empresaId"] ?? '',
    olId:           json["olId"] ?? -1,
    ea:             ExplotacionAgropecuaria.fromJson(json["ea"]),
    ingeniero:      Ingeniero.fromJson(json["ingeniero"]),
    contratista:    Contratista.fromJson(json["contratista"]),
    campania:       Campania.fromJson(json["campania"]),
    laboreo:        Laboreo.fromJson(json["laboreo"]),
    uaOrigen:       UA.fromJson(json["uaOrigen"]),
    uaDestino:      UA.fromJson(json["uaDestino"]),
    tipoCambio:     json["tipoCambio"] ?? 0.0,
    precioHaPesos:  json["precioHaPesos"] ?? 0.0,
    totalPesos:     json["totalPesos"] ?? 0.0,
    precioHaDolar:  json["precioHaDolar"] ?? 0.0,
    totalDolar:     json["totalDolar"] ?? 0.0,
    fecEmi:         json["fecEmi"] != null ? DateTime.parse(json["fecEmi"]) : null,    /* fecha: DateTime.parse(json["fecha"]),  ya lo tengo en formato datetime */
    fecVto:         json["fecVto"] != null ? DateTime.parse(json["fecVto"]) : null,
    observacion:    json["observacion"] ?? '',
    estado:         json["estado"] ?? '',
    cantTotalHas:   json["cantTotalHas"] ?? 0.0,
    lotes:          json["lotes"] == null ? const [] : List<Lote>.from(json["lotes"].map((x) => Lote.fromJson(x))),
    totalInsumos:   json["totalInsumos"] == null ? const [] : List<OLAbmTotalInsumo>.from(json["totalInsumos"].map((x) => OLAbmTotalInsumo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "gEconomicoId": gEconomicoId,
      "empresaId":    empresaId,
      "olId":         olId,
      "ea":           ea!.toJson(),
      "ingeniero":    ingeniero!.toJson(),
      "contratista":  contratista!.toJson(),
      "campania":     campania!.toJson(),
      "laboreo":      laboreo!.toJson(),
      "uaOrigen":     uaOrigen!.toJson(),
      "uaDestino":    uaDestino!.toJson(),
      "tipoCambio":   tipoCambio,
      "precioHaPesos":precioHaPesos,
      "totalPesos":   totalPesos,
      "precioHaDolar":precioHaDolar,
      "totalDolar":   totalDolar,
      "fecEmi":       fecEmi!.toIso8601String(),
      "fecVto":       fecVto!.toIso8601String(),
      "observacion":  observacion,
      "estado":       estado,
      "cantTotalHas": cantTotalHas,
      "lotes":        List<dynamic>.from(lotes.map((x) => x.toJson())),
      "totalInsumos": List<dynamic>.from(totalInsumos.map((x) => x.toJson())),
    };

}


//*---------------------------------------------------------------------------  OLAbmInsumoLote
class OLAbmInsumoLote {

  int? olLoteInsumoId;
  int?  articuloId;
  String? nombre;
  double? dosis;
  int? idUnico;
  double? total;
  double? precioUltimaCompra;
  double? precioPromedioPonderado;
  double? precioUltimaCompraCotizacion;
  double? precioPromedioPonderadoCotizacion;
  String? umOrigen;
  int?  unidadId;

  OLAbmInsumoLote({
    required this.olLoteInsumoId,
    required this.articuloId,
    required this.nombre,
    required this.dosis,
    required this.idUnico,
    required this.total,
    required this.precioUltimaCompra,
    required this.precioPromedioPonderado,
    required this.precioUltimaCompraCotizacion,
    required this.precioPromedioPonderadoCotizacion,
    required this.umOrigen,
    required this.unidadId,
  });

  factory OLAbmInsumoLote.fromJson(Map json) => OLAbmInsumoLote(
    olLoteInsumoId: json["olLoteInsumoId"],
    articuloId: json["articuloId"],
    nombre: json["nombre"],
    dosis: json["dosis"],
    idUnico: json["idUnico"],
    total: json["total"],
    precioUltimaCompra: json["precioUltimaCompra"],
    precioPromedioPonderado: json["precioPromedioPonderado"],
    precioUltimaCompraCotizacion: json["precioUltimaCompraCotizacion"],
    precioPromedioPonderadoCotizacion: json["precioPromedioPonderadoCotizacion"],
    umOrigen: json["umOrigen"],
    unidadId: json["unidadId"],
  );

  Map<String, dynamic> toJson() => {
    "olLoteInsumoId": olLoteInsumoId,
    "articuloId": articuloId,
    "nombre": nombre,
    "dosis": dosis,
    "idUnico": idUnico,
    "total": total,
    "precioUltimaCompra": precioUltimaCompra,
    "precioPromedioPonderado": precioPromedioPonderado,
    "precioUltimaCompraCotizacion": precioUltimaCompraCotizacion,
    "precioPromedioPonderadoCotizacion": precioPromedioPonderadoCotizacion,
    "umOrigen": umOrigen,
    "unidadId": unidadId,
  };

}


//*--------------------------------------------------------------------------- TOTAL INSUMO - ITEM
class OLAbmTotalInsumo {

  int articuloId; 
  String nombre;
  double total;
  String umo;                   //- Unidad medida origen
  int idUnico;
  double entregado;
  double saldo;

  
  OLAbmTotalInsumo({
    required this.articuloId,
    required this.nombre,
    required this.total,
    required this.umo,
    required this.idUnico,
    required this.entregado,
    required this.saldo,
  });

  factory OLAbmTotalInsumo.fromJson(Map json) => OLAbmTotalInsumo(
    articuloId: json["articuloId"],
    nombre: json["nombre"],
    total: json["total"],
    umo: json["umo"],
    idUnico: json["idUnico"],
    entregado: json["entregado"],
    saldo: json["saldo"],
  );

  Map<String, dynamic> toJson() => {
    "articuloId": articuloId,
    "nombre": nombre,
    "total": total,
    "umo": umo,
    "idUnico": idUnico,
    "entregado": entregado,
    "saldo": saldo,
  };
  
}

//*---------------------------------------------------------------------------  Transportistas - Add v2.6 BO
class Transportista {

  int? clienteId;
  String? nombre;
  String? nroCtaCte;

  Transportista({
    this.clienteId,
    this.nombre,
    this.nroCtaCte,
  });

  factory Transportista.fromJson(Map json) => Transportista(
    clienteId:        json["clienteId"],
    nombre:           json["nombre"],
    nroCtaCte:        json["nroCtaCte"],
  );

  Map<String, dynamic> toJson() => {
    "clienteId":        clienteId,
    "nombre":           nombre,
    "nroCtaCte":        nroCtaCte,
  };
}

//*---------------------------------------------------------------------------  RequestCamionChofer - Add v2.6 BO
class RequestCamionChofer {
  
  String gEconomicoId;
  String empresaId;
  int transportistaClienteId;
 
  RequestCamionChofer({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.transportistaClienteId = -1,
  });

}

//*---------------------------------------------------------------------------  CamionChofer - Add v2.6 BO
class CamionChofer {

  int? clienteCamionId;
  String? chasisDominio;
  String? acopladoDominio;
  int? clienteChoferId;
  String? chofer;
  int? transportistaClienteId;

  CamionChofer({
    this.clienteCamionId,
    this.chasisDominio,
    this.acopladoDominio,
    this.clienteChoferId,
    this.chofer,
    this.transportistaClienteId,
  });

  factory CamionChofer.fromJson(Map json) => CamionChofer(
    clienteCamionId:        json["clienteCamionId"],
    chasisDominio:          json["chasisDominio"],
    acopladoDominio:        json["acopladoDominio"],
    clienteChoferId:        json["clienteChoferId"],
    chofer:                 json["chofer"],
    transportistaClienteId: json["transportistaClienteId"],
  );

  Map<String, dynamic> toJson() => {
    "clienteCamionId":        clienteCamionId,
    "chasisDominio":          chasisDominio,
    "acopladoDominio":        acopladoDominio,
    "clienteChoferId":        clienteChoferId,
    "chofer":                 chofer,
    "transportistaClienteId": transportistaClienteId,
  };
}

//*---------------------------------------------------------------------------  Chofer - Add v2.6 BO
class Chofer {

  int? clienteChoferId;
  int? clienteId;
  String? nombre;
  String? nroCtaCte;

  Chofer({
    this.clienteChoferId,
    this.clienteId,
    this.nombre,
    this.nroCtaCte,
  });

  factory Chofer.fromJson(Map json) => Chofer(
    clienteChoferId:  json["clienteChoferId"],
    clienteId:        json["clienteId"],
    nombre:           json["nombre"],
    nroCtaCte:        json["nroCtaCte"],
  );

  Map<String, dynamic> toJson() => {
    "clienteChoferId":  clienteChoferId,
    "clienteId":        clienteId,
    "nombre":           nombre,
    "nroCtaCte":        nroCtaCte,
  };
}


//*---------------------------------------------------------------------------  RequestStandard - Add v2.6 BO
class RequestFull {
  
  String gEconomicoId;
  String empresaId;
 
  RequestFull({
    this.gEconomicoId = '',
    this.empresaId = '',
  });

}