

//*--------------------------------------------------------------------------- TOTAL INSUMO - ITEM
class OLGenericaTotalInsumoItem {

  String art;
  int cod; 
  double total;
  double entregado; 
  double saldo; 
  String umo;                   //- Unidad medida origen
  String umd;
  
  OLGenericaTotalInsumoItem({
    required this.art,
    required this.cod,
    required this.total,
    required this.entregado,
    required this.saldo,
    required this.umo,
    required this.umd,
  });

  factory OLGenericaTotalInsumoItem.fromJson(Map json) => OLGenericaTotalInsumoItem(
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

class OLGenericaDetalleLoteInsumoItem {

  int cod;
  String art;
  double dosis;
  String umo;
  String umd;
  double total;

  OLGenericaDetalleLoteInsumoItem({
    required this.cod,
    required this.art,
    required this.dosis,
    required this.umo,
    required this.umd,
    required this.total,
  });

  factory OLGenericaDetalleLoteInsumoItem.fromJson(Map json) => OLGenericaDetalleLoteInsumoItem(
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

class OLGenericaDetalleLoteItem {

  int clienteId;
  String loteNombre;
  String campania;
  String cereal;
  double cantHas;
  double cantHasParciales;
  List<OLGenericaDetalleLoteInsumoItem> listaDetalleLoteInsumos;

  OLGenericaDetalleLoteItem({
    required this.clienteId,
    required this.loteNombre,
    required this.campania,
    required this.cereal,
    required this.cantHas,
    required this.cantHasParciales,
    required this.listaDetalleLoteInsumos,
  });

  factory OLGenericaDetalleLoteItem.fromJson(Map json) => OLGenericaDetalleLoteItem(
    clienteId: json["clienteId"],
    loteNombre: json["loteNombre"],
    campania: json["campania"],
    cereal: json["cereal"],
    cantHas: json["cantHas"],
    cantHasParciales: json["cantHasParciales"],
    listaDetalleLoteInsumos: List<OLGenericaDetalleLoteInsumoItem>.from(json["listaDetalleLoteInsumos"].map((x) => OLGenericaDetalleLoteInsumoItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "clienteId": clienteId,
    "loteNombre": loteNombre,
    "campania": campania,
    "cereal": cereal,
    "cantHas": cantHas,
    "cantHasParciales": cantHasParciales,
    "listaDetalleLoteInsumos": List<OLGenericaDetalleLoteInsumoItem>.from(listaDetalleLoteInsumos.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- OLGenericaDetalleOperarioItem
//!-- Add 2.6
class OLGenericaDetalleOperarioItem {

  int clienteId;
  String operario;
  double porcentaje;
  double precioPorHa;
  double cantidadHas;
  double total;
  String lote;

  OLGenericaDetalleOperarioItem({
    required this.clienteId,
    required this.operario,
    required this.porcentaje,
    required this.precioPorHa,
    required this.cantidadHas,
    required this.total,
    required this.lote,
  });

  factory OLGenericaDetalleOperarioItem.fromJson(Map json) => OLGenericaDetalleOperarioItem(
    clienteId:    json["clienteId"],
    operario:     json["operario"],
    porcentaje:   json["porcentaje"],
    precioPorHa:  json["precioPorHa"],
    cantidadHas:  json["cantidadHas"],
    total:        json["total"],
    lote:         json["lote"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "clienteId":    clienteId,
    "operario":     operario,
    "porcentaje":   porcentaje,
    "precioPorHa":  precioPorHa,
    "cantidadHas":  cantidadHas,
    "total":        total,
    "lote":         lote,
  };
}

//*--------------------------------------------------------------------------- DETALLE FULL DE LA OL
class OLGenerica {

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
  List<OLGenericaTotalInsumoItem> listaTotalInsumos;
  List<OLGenericaDetalleLoteItem> listaDetalleLotes;
  //!-- Add 2.6
  List<OLGenericaDetalleOperarioItem> listaOperarios;

  OLGenerica({
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
      //!-- Add 2.6
      required this.listaOperarios,
    });

  factory OLGenerica.fromJson(Map json) => OLGenerica(
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
    listaTotalInsumos: List<OLGenericaTotalInsumoItem>.from(json["listaTotalInsumos"].map((x) => OLGenericaTotalInsumoItem.fromJson(x))),
    listaDetalleLotes: List<OLGenericaDetalleLoteItem>.from(json["listaDetalleLotes"].map((x) => OLGenericaDetalleLoteItem.fromJson(x))),
    //!-- Add 2.6
    listaOperarios: List<OLGenericaDetalleOperarioItem>.from(json["listaOperarios"].map((x) => OLGenericaDetalleOperarioItem.fromJson(x))),
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
      "listaTotalInsumos": List<OLGenericaTotalInsumoItem>.from(listaTotalInsumos.map((x) => x.toJson())),
      "listaDetalleLotes": List<OLGenericaDetalleLoteItem>.from(listaDetalleLotes.map((x) => x.toJson())),
      //!-- Add 2.6
      "listaOperarios": List<OLGenericaDetalleOperarioItem>.from(listaOperarios.map((x) => x.toJson())),
    };
}


//*------------------------------------------------------------------------- OLGenericaDetalleRequest
class OLGenericaDetalleRequest {
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int olId;
  //!-- Add 2.6
  bool showDatosMonetarios;
  bool showDatosMonetariosOperario;
  int operarioClienteId;
  
  OLGenericaDetalleRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.olId = 0,
    //!-- Add 2.6
    this.showDatosMonetarios = false,
    this.showDatosMonetariosOperario = false,
    this.operarioClienteId = 0,
  });
}


//*------------------------------------------------------------------------- OLGenericaDetalleResponse
class OLGenericaDetalleResponse {

  OLGenerica? ol;
  String? tokenDeRefresco;

  OLGenericaDetalleResponse({
    this.ol,
    this.tokenDeRefresco,
  });

  factory OLGenericaDetalleResponse.fromJson(Map<String, dynamic> json) => OLGenericaDetalleResponse(
    ol: OLGenerica.fromJson(json["ol"]),
    tokenDeRefresco: json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "ol": OLGenerica.fromJson(ol!.toJson()),
    "tokenDeRefresco": tokenDeRefresco,
  };
}