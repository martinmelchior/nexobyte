import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/model/ol_model.dart';

class FiltrosOLsIng {

  int ingenieroId;
  Contratista? contratista;  
  Especie? especie;
  ExplotacionAgropecuaria?  ea; 
  Campania? campania;
  Laboreo? laboreo;
  String estado;
  bool verSoloMisOLs;

  FiltrosOLsIng({
    this.ingenieroId = 0,
    this.contratista,
    this.ea,
    this.campania,
    this.laboreo,
    this.especie,
    this.estado = '',
    this.verSoloMisOLs = false,
  });

  factory FiltrosOLsIng.fromJson(Map json) => FiltrosOLsIng(
    ingenieroId:    json["ingenieroId"] ?? 0,
    contratista:    json["contratista"],
    especie:        json["especie"],
    ea:             json["ea"],
    campania:       json["campania"],
    laboreo:        json["laboreo"],
    estado:         json["estado"] ?? '',
    verSoloMisOLs:  json["verSoloMisOLs"] ?? false,
  );

  Map<String, dynamic> toJson() => {
      "ingenieroId":    ingenieroId,
      "contratista":    contratista,
      "campania":       campania,
      "laboreo":        laboreo,
      "especie":        especie,
      "ea":             ea,
      "estado":         estado,
      "verSoloMisOLs":  verSoloMisOLs,
    };
}



class OrdenesLaboreosIngenieroRequest {

  String tokenDeRefresco;
  OrdenesLaboreosResumenDeIngenieroItem? itemResumenIngeniero;
  int pageNro;
  int pageSize;
  FiltrosOLsIng? filtrosOLs;
  
  OrdenesLaboreosIngenieroRequest({
    this.tokenDeRefresco = '',
    this.itemResumenIngeniero,
    this.pageNro = 1,
    this.pageSize = 100,
    this.filtrosOLs,
  });
}

class OrdenesLaboreosIngenieroResponse {

  List<OLIngenieroItem> listaOLsUsuario;

  OrdenesLaboreosIngenieroResponse({
    this.listaOLsUsuario = const []
  });

  factory OrdenesLaboreosIngenieroResponse.fromJson(Map<String, dynamic> json) => OrdenesLaboreosIngenieroResponse(
    listaOLsUsuario: List<OLIngenieroItem>.from(json["listaDeOrdenesLaboreos"].map((x) => OLIngenieroItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaOLsUsuario": List<OLIngenieroItem>.from(listaOLsUsuario.map((x) => x.toJson())),
  };
}

class OLIngenieroItem {

  String gEconomicoId;
  String empresaId;

  int olId;
  int eaId;
  String ea;
  int ingId;
  String ing;
  int conId;
  String con;
  int conNroCtaCte;
  String campania;
  String cereal;
  String laboreo;
  //-- Monetarios
  double tipoCambio;             //- Cotizacion Dolar
  double precioHaPesos;          //- PrecioHectarea
  double totalPesos;             //- TotalLaboreo
  double precioHaDolar;          //- PrecioHectareaDolar
  double totalDolar;             //- TotalLaboreoDolar
  DateTime fecEmi;
  DateTime fecVto;
  String obs;
  String estado;
  //-- UA
  int uaoId;
  String uao;
  int uadId;
  String uad;

  OLIngenieroItem({
    required this.gEconomicoId,  
    required this.empresaId,
    required this.olId,
    required this.eaId,
    required this.ea,
    required this.ingId,
    required this.ing,
    required this.conId,
    required this.con,
    required this.conNroCtaCte,
    required this.campania,
    required this.cereal,
    required this.laboreo,
    required this.tipoCambio,
    required this.precioHaPesos,
    required this.totalPesos,
    required this.precioHaDolar,
    required this.totalDolar,
    required this.fecEmi,
    required this.fecVto,
    required this.obs,
    required this.estado,
    required this.uaoId,
    required this.uao,
    required this.uadId,
    required this.uad,
  });

  factory OLIngenieroItem.fromJson(Map json) => OLIngenieroItem(
    gEconomicoId: json["gEconomicoId"],
    empresaId: json["empresaId"],
    olId: json["olId"],
    eaId: json["eaId"],
    ea: json["ea"],
    ingId: json["ingId"],
    ing: json["ing"],
    conId: json["conId"],
    con: json["con"],
    conNroCtaCte: json["conNroCtaCte"],
    campania: json["campania"],
    cereal: json["cereal"],
    laboreo: json["laboreo"],
    tipoCambio: json["tipoCambio"],
    precioHaPesos: json["precioHaPesos"],
    totalPesos: json["totalPesos"],
    precioHaDolar: json["precioHaDolar"],
    totalDolar: json["totalDolar"],
    fecEmi: DateTime.parse(json["fecEmi"]),
    fecVto: DateTime.parse(json["fecVto"]),
    obs: json["obs"],
    estado: json["estado"],
    uaoId: json["uaoId"],
    uao: json["uao"],
    uadId: json["uadId"],
    uad: json["uad"],
  );

  Map<String, dynamic> toJson() => {
      "gEconomicoId": gEconomicoId,
      "empresaId": empresaId,
      "olId": olId,
      "eaId": eaId,
      "ea": ea,
      "ingId": ingId,
      "ing": ing,
      "conId": conId,
      "con": con,
      "conNroCtaCte": conNroCtaCte,
      "campania": campania,
      "cereal": cereal,
      "laboreo": laboreo,
      "tipoCambio": tipoCambio,
      "precioHaPesos": precioHaPesos,
      "totalPesos": totalPesos,
      "precioHaDolar": precioHaDolar,
      "totalDolar": totalDolar,
      "fecEmi": fecEmi,
      "fecVto": fecVto,
      "obs": obs,
      "estado": estado,
      "uaoId": uaoId,
      "uao": uao,
      "uadId": uadId,
      "uad": uad,
    };
}

//*--------------------------------------------------------------------------- RESUMEN INGENIEROS
class OrdenesLaboreosResumenDeIngenieroEstado {

  String campania;
  String estado;
  int cantidad;
  double totalPesos;           
  double totalDolar;         

  OrdenesLaboreosResumenDeIngenieroEstado({
      required this.campania,
      required this.estado,
      required this.cantidad,
      required this.totalPesos,
      required this.totalDolar,
    });

  factory OrdenesLaboreosResumenDeIngenieroEstado.fromJson(Map json) => OrdenesLaboreosResumenDeIngenieroEstado(
    campania: json["campania"] ?? "",
    estado: json["estado"],
    cantidad: json["cantidad"],
    totalPesos: json["totalPesos"],
    totalDolar: json["totalDolar"],
  );

  Map<String, dynamic> toJson() => {
      "campania": campania,
      "estado": estado,
      "cantidad": cantidad,
      "totalPesos": totalPesos,
      "totalDolares": totalDolar,
    };
}

//*--------------------------------------------------------------------------- RESUMEN INGENIEROS
class OrdenesLaboreosResumenDeIngenieroItem {

  String gEconomicoId;
  String empresaId;
  String empresa;
  int ingenieroId;
  String ingeniero;
  String inCampaniasIds;
  List<OrdenesLaboreosResumenDeIngenieroEstado> listaDeEstados;

  OrdenesLaboreosResumenDeIngenieroItem({
      required this.gEconomicoId,
      required this.empresaId,
      required this.empresa,
      required this.ingenieroId,
      required this.ingeniero,
      required this.inCampaniasIds,
      required this.listaDeEstados,
    });

  factory OrdenesLaboreosResumenDeIngenieroItem.fromJson(Map json) => OrdenesLaboreosResumenDeIngenieroItem(
    gEconomicoId: json["gEconomicoId"],
    empresaId: json["empresaId"],
    empresa: json["empresa"],
    ingenieroId: json["ingenieroId"],
    ingeniero: json["ingeniero"],
    inCampaniasIds: json["inCampaniasIds"],
    listaDeEstados: List<OrdenesLaboreosResumenDeIngenieroEstado>.from(json["listaDeEstados"].map((x) => OrdenesLaboreosResumenDeIngenieroEstado.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId": gEconomicoId,
    "empresaId": empresaId,
    "empresa": empresa,
    "ingenieroId": ingenieroId,
    "ingeniero": ingeniero,
    "inCampaniasIds": inCampaniasIds,
    "listaDeEstados": List<OrdenesLaboreosResumenDeIngenieroEstado>.from(listaDeEstados.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- RESPONSE
class OrdenesLaboreosResumenDeIngenieroResponse {

  List<OrdenesLaboreosResumenDeIngenieroItem> listaResumenDeIngenierosItem;

  OrdenesLaboreosResumenDeIngenieroResponse({
    this.listaResumenDeIngenierosItem = const []
  });

  factory OrdenesLaboreosResumenDeIngenieroResponse.fromJson(Map<String, dynamic> json) => OrdenesLaboreosResumenDeIngenieroResponse(
    listaResumenDeIngenierosItem: List<OrdenesLaboreosResumenDeIngenieroItem>.from(json["listaResumenDeIngenierosItem"].map((x) => OrdenesLaboreosResumenDeIngenieroItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaResumenDeIngenierosItem": List<OrdenesLaboreosResumenDeIngenieroItem>.from(listaResumenDeIngenierosItem.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- REQUEST
class OrdenesLaboreosResumenDeIngenieroRequest {
  String tokenDeRefresco;
 
  OrdenesLaboreosResumenDeIngenieroRequest({
    this.tokenDeRefresco = '',
  });
}

//*--------------------------------------------------------------------------- TOTAL INSUMO - ITEM
class OLIngenieroTotalInsumoItem {

  String art;
  int cod; 
  double total;
  double entregado; 
  double saldo; 
  String umo;                   //- Unidad medida origen
  String umd;
  
  OLIngenieroTotalInsumoItem({
    required this.art,
    required this.cod,
    required this.total,
    required this.entregado,
    required this.saldo,
    required this.umo,
    required this.umd,
  });

  factory OLIngenieroTotalInsumoItem.fromJson(Map json) => OLIngenieroTotalInsumoItem(
    art: json["art"],
    cod: json["cod"],
    total: json["total"],
    entregado: json["entregado"],
    saldo: json["saldo"],
    umo: json["umo"],
    umd: json["umd"],
  );

  Map<String, dynamic> toJson() => {
    "art": art,
    "cod": cod,
    "total": total,
    "entregado": entregado,
    "saldo": saldo,
    "umo": umo,
    "umd": umd,
  };
  
}

class OLIngenieroDetalleLoteInsumoItem {

  int cod;
  String art;
  double dosis;
  String umo;
  String umd;
  double total;

  OLIngenieroDetalleLoteInsumoItem({
    required this.cod,
    required this.art,
    required this.dosis,
    required this.umo,
    required this.umd,
    required this.total,
  });

  factory OLIngenieroDetalleLoteInsumoItem.fromJson(Map json) => OLIngenieroDetalleLoteInsumoItem(
    cod: json["cod"],
    art: json["art"],
    dosis: json["dosis"],
    umo: json["umo"],
    umd: json["umd"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "art": art,
    "dosis": dosis,
    "umo": umo,
    "umd": umd,
    "total": total,
  };

}

class OLIngenieroDetalleLoteItem {

  int clienteId;
  String loteNombre;
  String campania;
  String cereal;
  double cantHas;
  double cantHasParciales;
  List<OLIngenieroDetalleLoteInsumoItem> listaDetalleLoteInsumos;

  OLIngenieroDetalleLoteItem({
    required this.clienteId,
    required this.loteNombre,
    required this.campania,
    required this.cereal,
    required this.cantHas,
    required this.cantHasParciales,
    required this.listaDetalleLoteInsumos,
  });

  factory OLIngenieroDetalleLoteItem.fromJson(Map json) => OLIngenieroDetalleLoteItem(
    clienteId: json["clienteId"],
    loteNombre: json["loteNombre"],
    campania: json["campania"],
    cereal: json["cereal"],
    cantHas: json["cantHas"],
    cantHasParciales: json["cantHasParciales"],
    listaDetalleLoteInsumos: List<OLIngenieroDetalleLoteInsumoItem>.from(json["listaDetalleLoteInsumos"].map((x) => OLIngenieroDetalleLoteInsumoItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clienteId": clienteId,
    "loteNombre": loteNombre,
    "campania": campania,
    "cereal": cereal,
    "cantHas": cantHas,
    "cantHasParciales": cantHasParciales,
    "listaDetalleLoteInsumos": List<OLIngenieroDetalleLoteInsumoItem>.from(listaDetalleLoteInsumos.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- DETALLE FULL DE LA OL
class OLFullIngeniero {

  int olId;
  int eaId;
  String ea;
  int ingId;
  String ing;
  int conId;
  String con;
  int conNroCtaCte;
  String campania;
  String cereal;
  String laboreo;
  //-- Monetarios
  double tipoCambio;             //- Cotizacion Dolar
  double precioHaPesos;          //- PrecioHectarea
  double totalPesos;             //- TotalLaboreo
  double precioHaDolar;          //- PrecioHectareaDolar
  double totalDolar;             //- TotalLaboreoDolar
  DateTime fecEmi;
  DateTime fecVto;
  String obs;
  String estado;
  //-- UA
  int uaoId;
  String uao;
  int uadId;
  String uad;
  List<OLTotalInsumoItem> listaTotalInsumos;
  List<OLDetalleLoteItem> listaDetalleLotes;

  OLFullIngeniero({
      required this.olId,
      required this.eaId,
      required this.ea,
      required this.ingId,
      required this.ing,
      required this.conId,
      required this.con,
      required this.conNroCtaCte,
      required this.campania,
      required this.cereal,
      required this.laboreo,
      required this.tipoCambio,
      required this.precioHaPesos,
      required this.totalPesos,
      required this.precioHaDolar,
      required this.totalDolar,
      required this.fecEmi,
      required this.fecVto,
      required this.obs,
      required this.estado,
      required this.uaoId,
      required this.uao,
      required this.uadId,
      required this.uad,
      required this.listaTotalInsumos,
      required this.listaDetalleLotes,
    });

  factory OLFullIngeniero.fromJson(Map json) => OLFullIngeniero(
    olId: json["olId"],
    eaId: json["eaId"],
    ea: json["ea"],
    ingId: json["ingId"],
    ing: json["ing"],
    conId: json["conId"],
    con: json["con"],
    conNroCtaCte: json["conNroCtaCte"],
    campania: json["campania"],
    cereal: json["cereal"],
    laboreo: json["laboreo"],
    tipoCambio: json["tipoCambio"],
    precioHaPesos: json["precioHaPesos"],
    totalPesos: json["totalPesos"],
    precioHaDolar: json["precioHaDolar"],
    totalDolar: json["totalDolar"],
    fecEmi: DateTime.parse(json["fecEmi"]),
    fecVto: DateTime.parse(json["fecVto"]),
    obs: json["obs"],
    estado: json["estado"],
    uaoId: json["uaoId"],
    uao: json["uao"],
    uadId: json["uadId"],
    uad: json["uad"],
    listaTotalInsumos: List<OLTotalInsumoItem>.from(json["listaTotalInsumos"].map((x) => OLTotalInsumoItem.fromJson(x))),
    listaDetalleLotes: List<OLDetalleLoteItem>.from(json["listaDetalleLotes"].map((x) => OLDetalleLoteItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
      "olId": olId,
      "eaId": eaId,
      "ea": ea,
      "ingId": ingId,
      "ing": ing,
      "conId": conId,
      "con": con,
      "conNroCtaCte": conNroCtaCte,
      "campania": campania,
      "cereal": cereal,
      "laboreo": laboreo,
      "tipoCambio": tipoCambio,
      "precioHaPesos": precioHaPesos,
      "totalPesos": totalPesos,
      "precioHaDolar": precioHaDolar,
      "totalDolar": totalDolar,
      "fecEmi": fecEmi,
      "fecVto": fecVto,
      "obs": obs,
      "estado": estado,
      "uaoId": uaoId,
      "uao": uao,
      "uadId": uadId,
      "uad": uad,
      "listaTotalInsumos": List<OLTotalInsumoItem>.from(listaTotalInsumos.map((x) => x.toJson())),
      "listaDetalleLotes": List<OLDetalleLoteItem>.from(listaDetalleLotes.map((x) => x.toJson())),
    };
}

class ObtenerOrdenDeLaboreoIngenieroDetalleRequest {
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int olId;
  
  ObtenerOrdenDeLaboreoIngenieroDetalleRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.olId = 0,
  });
}

class ObtenerOrdenDeLaboreoIngenieroDetalleResponse {

  OLFullIngeniero? ol;
  String? tokenDeRefresco;

  ObtenerOrdenDeLaboreoIngenieroDetalleResponse({
    this.ol,
    this.tokenDeRefresco,
  });

  factory ObtenerOrdenDeLaboreoIngenieroDetalleResponse.fromJson(Map<String, dynamic> json) => ObtenerOrdenDeLaboreoIngenieroDetalleResponse(
    ol: OLFullIngeniero.fromJson(json["ol"]),
    tokenDeRefresco: json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "ol": OLFullIngeniero.fromJson(ol!.toJson()),
    "tokenDeRefresco": tokenDeRefresco,
  };
}


class AsientoContableItemOL {

  String articulo;
  String concepto;
  double debe;
  double haber;

  AsientoContableItemOL({
    this.articulo = '',
    this.concepto = '',
    this.debe = 0.00,
    this.haber = 0.00,
  });

  factory AsientoContableItemOL.fromJson(Map json) => AsientoContableItemOL(
    articulo:   json["articulo"] ?? '',
    concepto:   json["concepto"] ?? '',
    debe:       json["debe"] ?? 0.00,
    haber:      json["haber"] ?? 0.00,
  );

  Map<String, dynamic> toJson() => {
      "articulo": articulo,
      "concepto": concepto,
      "debe":     debe,
      "haber":    haber,
    };
}

class AsientoContableOL {

  String tipo;
  List<AsientoContableItemOL> items;
  double totalDebe;
  double totalHaber;

  AsientoContableOL({
    this.tipo = '',
    this.items = const [],
    this.totalDebe = 0.00,
    this.totalHaber = 0.00,
  });

  factory AsientoContableOL.fromJson(Map json) => AsientoContableOL(
    tipo:       json["tipo"] ?? '',
    items:      List<AsientoContableItemOL>.from(json["items"].map((x) => AsientoContableItemOL.fromJson(x))),
    totalDebe:  json["totalDebe"] ?? 0.00,
    totalHaber: json["totalHaber"] ?? 0.00,
  );

  Map<String, dynamic> toJson() => {
      "tipo":       tipo,
      "items":      List<AsientoContableItemOL>.from(items.map((x) => x.toJson())),
      "totalDebe":  totalDebe,
      "totalHaber": totalHaber,
    };
}

class ObtenerAsientosContablesOLResponse {

  List<AsientoContableOL> listaAsientosContables;

  ObtenerAsientosContablesOLResponse({
    this.listaAsientosContables = const [],
  });

  factory ObtenerAsientosContablesOLResponse.fromJson(Map<String, dynamic> json) => ObtenerAsientosContablesOLResponse(
    listaAsientosContables: List<AsientoContableOL>.from(json["listaAsientosContables"].map((x) => AsientoContableOL.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaAsientosContables": List<AsientoContableOL>.from(listaAsientosContables.map((x) => x.toJson())),
  };
}