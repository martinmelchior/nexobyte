import 'package:nexobyte/app/modules/ordenes_laboreos_comun/model/ol_model.dart';

class OrdenesLaboreosContratistaRequest {
  String tokenDeRefresco;
  OrdenesLaboreosResumenDeContratistasItem? itemResumenContratista;
  int pageNro;
  int pageSize;
  FiltrosOLsCon? filtrosOLs;
  
  OrdenesLaboreosContratistaRequest({
    this.tokenDeRefresco = '',
    this.itemResumenContratista,
    this.pageNro = 1,
    this.pageSize = 100,
    this.filtrosOLs,
  });
}

class OrdenesLaboreosContratistaResponse {

  List<OLItemContratista> listaOLsUsuario;

  OrdenesLaboreosContratistaResponse({
    this.listaOLsUsuario = const []
  });

  factory OrdenesLaboreosContratistaResponse.fromJson(Map<String, dynamic> json) => OrdenesLaboreosContratistaResponse(
    listaOLsUsuario: List<OLItemContratista>.from(json["listaDeOrdenesLaboreos"].map((x) => OLItemContratista.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaOLsUsuario": List<OLItemContratista>.from(listaOLsUsuario.map((x) => x.toJson())),
  };
}

class OLItemContratista {

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
  //-- v4.0
  String? uis;  


  OLItemContratista({
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
    this.uis,
  });

  factory OLItemContratista.fromJson(Map json) => OLItemContratista(
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
    uis: json["uis"],
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
      "uis": uis,
    };
}

//*--------------------------------------------------------------------------- RESUMEN CONTRATISTAS
class OrdenesLaboreosResumenDeContratistasEstado {

  String estado;
  int cantidad;
  double totalPesos;           
  double totalDolar;         

  OrdenesLaboreosResumenDeContratistasEstado({
      required this.estado,
      required this.cantidad,
      required this.totalPesos,
      required this.totalDolar,
    });

  factory OrdenesLaboreosResumenDeContratistasEstado.fromJson(Map json) => OrdenesLaboreosResumenDeContratistasEstado(
    estado: json["estado"],
    cantidad: json["cantidad"],
    totalPesos: json["totalPesos"],
    totalDolar: json["totalDolar"],
  );

  Map<String, dynamic> toJson() => {
      "estado": estado,
      "cantidad": cantidad,
      "totalPesos": totalPesos,
      "totalDolares": totalDolar,
    };
}

//*--------------------------------------------------------------------------- RESUMEN CONTRATISTAS
class OrdenesLaboreosResumenDeContratistasItem {

  String gEconomicoId;
  String empresaId;
  String empresa;
  int contratistaId;
  String contratista;
  int cantidadTotalOLs;
  List<OrdenesLaboreosResumenDeContratistasEstado> listaDeEstados;

  OrdenesLaboreosResumenDeContratistasItem({
      required this.gEconomicoId,
      required this.empresaId,
      required this.empresa,
      required this.contratistaId,
      required this.contratista,
      required this.cantidadTotalOLs,
      required this.listaDeEstados,
    });

  factory OrdenesLaboreosResumenDeContratistasItem.fromJson(Map json) => OrdenesLaboreosResumenDeContratistasItem(
    gEconomicoId: json["gEconomicoId"],
    empresaId: json["empresaId"],
    empresa: json["empresa"],
    contratistaId: json["contratistaId"],
    contratista: json["contratista"],
    cantidadTotalOLs: json["cantidadTotalOLs"],
    listaDeEstados: List<OrdenesLaboreosResumenDeContratistasEstado>.from(json["listaDeEstados"].map((x) => OrdenesLaboreosResumenDeContratistasEstado.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId": gEconomicoId,
    "empresaId": empresaId,
    "empresa": empresa,
    "contratistaId": contratistaId,
    "contratista": contratista,
    "cantidadTotalOLs": cantidadTotalOLs,
    "listaDeEstados": List<OrdenesLaboreosResumenDeContratistasEstado>.from(listaDeEstados.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- RESPONSE
class OrdenesLaboreosResumenDeContratistaResponse {

  List<OrdenesLaboreosResumenDeContratistasItem> listaResumenDeContratistasItem;

  OrdenesLaboreosResumenDeContratistaResponse({
    this.listaResumenDeContratistasItem = const []
  });

  factory OrdenesLaboreosResumenDeContratistaResponse.fromJson(Map<String, dynamic> json) => OrdenesLaboreosResumenDeContratistaResponse(
    listaResumenDeContratistasItem: List<OrdenesLaboreosResumenDeContratistasItem>.from(json["listaDeContratistas"].map((x) => OrdenesLaboreosResumenDeContratistasItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaResumenDeContratistasItem": List<OrdenesLaboreosResumenDeContratistasItem>.from(listaResumenDeContratistasItem.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- REQUEST
class OrdenesLaboreosResumenDeContratistaRequest {
  String tokenDeRefresco;
 
  OrdenesLaboreosResumenDeContratistaRequest({
    this.tokenDeRefresco = '',
  });
}


//*--------------------------------------------------------------------------- TOTAL INSUMO - ITEM
class OLTotalInsumoItem {

  String art;
  int cod; 
  double total;
  double entregado; 
  double saldo; 
  String umo;                   //- Unidad medida origen
  String umd;
  
  OLTotalInsumoItem({
    required this.art,
    required this.cod,
    required this.total,
    required this.entregado,
    required this.saldo,
    required this.umo,
    required this.umd,
  });

  factory OLTotalInsumoItem.fromJson(Map json) => OLTotalInsumoItem(
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

class OLDetalleLoteInsumoItem {

  int cod;
  String art;
  double dosis;
  String umo;
  String umd;
  double total;

  OLDetalleLoteInsumoItem({
    required this.cod,
    required this.art,
    required this.dosis,
    required this.umo,
    required this.umd,
    required this.total,
  });

  factory OLDetalleLoteInsumoItem.fromJson(Map json) => OLDetalleLoteInsumoItem(
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

class OLDetalleLoteItem {

  int clienteId;
  String loteNombre;
  String campania;
  String cereal;
  double cantHas;
  double cantHasParciales;
  List<OLDetalleLoteInsumoItem> listaDetalleLoteInsumos;

  OLDetalleLoteItem({
    required this.clienteId,
    required this.loteNombre,
    required this.campania,
    required this.cereal,
    required this.cantHas,
    required this.cantHasParciales,
    required this.listaDetalleLoteInsumos,
  });

  factory OLDetalleLoteItem.fromJson(Map json) => OLDetalleLoteItem(
    clienteId: json["clienteId"],
    loteNombre: json["loteNombre"],
    campania: json["campania"],
    cereal: json["cereal"],
    cantHas: json["cantHas"],
    cantHasParciales: json["cantHasParciales"],
    listaDetalleLoteInsumos: List<OLDetalleLoteInsumoItem>.from(json["listaDetalleLoteInsumos"].map((x) => OLDetalleLoteInsumoItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clienteId": clienteId,
    "loteNombre": loteNombre,
    "campania": campania,
    "cereal": cereal,
    "cantHas": cantHas,
    "cantHasParciales": cantHasParciales,
    "listaDetalleLoteInsumos": List<OLDetalleLoteInsumoItem>.from(listaDetalleLoteInsumos.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- DETALLE FULL DE LA OL
class OLFullContratista {

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

  OLFullContratista({
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

  factory OLFullContratista.fromJson(Map json) => OLFullContratista(
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

class ObtenerOrdenDeLaboreoContratistaDetalleRequest {
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int olId;
  
  ObtenerOrdenDeLaboreoContratistaDetalleRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.olId = 0,
  });
}

class ObtenerOrdenDeLaboreoContratistaDetalleResponse {

  OLFullContratista? ol;
  String? tokenDeRefresco;

  ObtenerOrdenDeLaboreoContratistaDetalleResponse({
    this.ol,
    this.tokenDeRefresco,
  });

  factory ObtenerOrdenDeLaboreoContratistaDetalleResponse.fromJson(Map<String, dynamic> json) => ObtenerOrdenDeLaboreoContratistaDetalleResponse(
    ol: OLFullContratista.fromJson(json["ol"]),
    tokenDeRefresco: json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "ol": OLFullContratista.fromJson(ol!.toJson()),
    "tokenDeRefresco": tokenDeRefresco,
  };
}

class FiltrosOLsCon {

  Especie? especie;
  ExplotacionAgropecuaria?  ea; 
  Campania? campania;
  Laboreo? laboreo;
  String estado;
  
  FiltrosOLsCon({
    this.ea,
    this.campania,
    this.laboreo,
    this.especie,
    this.estado = '',
  });

  factory FiltrosOLsCon.fromJson(Map json) => FiltrosOLsCon(
    especie:        json["especie"],
    ea:             json["ea"],
    campania:       json["campania"],
    laboreo:        json["laboreo"],
    estado:         json["estado"] ?? '',
  );

  Map<String, dynamic> toJson() => {
      "campania":       campania,
      "laboreo":        laboreo,
      "especie":        especie,
      "ea":             ea,
      "estado":         estado,
    };
}