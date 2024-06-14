

class LiquidacionLecheMercadoInterno {

  String concepto;
  double cantidadKg;
  double precioKg;
  double importe;
  String cantidadTexto;
  
  LiquidacionLecheMercadoInterno({
    this.concepto       = '',
    this.cantidadKg     = 0.0,
    this.precioKg       = 0.0,
    this.importe        = 0.0,
    this.cantidadTexto  = '',
  });

  factory LiquidacionLecheMercadoInterno.fromJson(Map json) => LiquidacionLecheMercadoInterno(
    concepto:       json["concepto"],
    cantidadKg:     json["cantidadKg"],
    precioKg:       json["precioKg"],
    importe:        json["importe"],
    cantidadTexto:  json["cantidadTexto"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "concepto":       concepto,
    "cantidadKg":     cantidadKg,
    "precioKg":       precioKg,
    "importe":        importe,
    "cantidadTexto":  cantidadTexto,
  };
}

class LiquidacionLecheBonificacionCalidad {

  String concepto;
  double resultado;
  double porcentaje;
  double importe;
  String cantidadTexto;
  
  LiquidacionLecheBonificacionCalidad({
    this.concepto       = '',
    this.resultado     = 0.0,
    this.porcentaje       = 0.0,
    this.importe        = 0.0,
    this.cantidadTexto  = '',
  });

  factory LiquidacionLecheBonificacionCalidad.fromJson(Map json) => LiquidacionLecheBonificacionCalidad(
    concepto:       json["concepto"],
    resultado:      json["resultado"],
    porcentaje:     json["porcentaje"],
    importe:        json["importe"],
    cantidadTexto:  json["cantidadTexto"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "concepto":       concepto,
    "resultado":      resultado,
    "porcentaje":     porcentaje,
    "importe":        importe,
    "cantidadTexto":  cantidadTexto,
  };
}

class LiquidacionLecheBonificacionComerciales {

  String concepto;
  double porcentaje;
  double importe;
  String cantidadTexto;
  
  LiquidacionLecheBonificacionComerciales({
    this.concepto       = '',
    this.porcentaje       = 0.0,
    this.importe        = 0.0,
    this.cantidadTexto  = '',
  });

  factory LiquidacionLecheBonificacionComerciales.fromJson(Map json) => LiquidacionLecheBonificacionComerciales(
    concepto:       json["concepto"],
    porcentaje:     json["porcentaje"],
    importe:        json["importe"],
    cantidadTexto:  json["cantidadTexto"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "concepto":       concepto,
    "porcentaje":     porcentaje,
    "importe":        importe,
    "cantidadTexto":  cantidadTexto,
  };
}


class LiquidacionLecheItem {
  
  int? liquidacionLecheId;
  int? clienteId;
  int? clienteTamboId;
  DateTime? fecha;
  DateTime? fVto;
  String? letra;
  String? prefijo;
  String? nro;
  double? gravado;
  double? iva;
  double? retencionIB;
  double? retencionG;
  double? retencionIVA;
  double? neto;
  double? precioGrasa;
  double? precioProteina;
  double? porcRetencionIB;
  double? porcRetencionG;
  double? porcRetencionIVA;
  double? baseImponibleRetencionIB;
  double? alicuotaIva;
  String? datosAdicionales;
  String? uis;
  List<LiquidacionLecheMercadoInterno> listaMercadoInterno;
  List<LiquidacionLecheBonificacionCalidad> listaBonificacionesCalidad;
  List<LiquidacionLecheBonificacionComerciales> listaBonificacionesComerciales;

  LiquidacionLecheItem({
    this.liquidacionLecheId,
    this.clienteId,
    this.clienteTamboId,
    this.fecha,
    this.fVto,
    this.letra,
    this.prefijo,
    this.nro,
    this.gravado,
    this.iva,
    this.retencionIB,
    this.retencionG,
    this.retencionIVA,
    this.neto,
    this.precioGrasa,
    this.precioProteina,
    this.porcRetencionIB,
    this.porcRetencionG,
    this.porcRetencionIVA,
    this.baseImponibleRetencionIB,
    this.alicuotaIva,
    this.datosAdicionales,
    this.uis,
    this.listaMercadoInterno = const [],
    this.listaBonificacionesCalidad = const [],
    this.listaBonificacionesComerciales = const [],
  });

  factory LiquidacionLecheItem.fromJson(Map json) => LiquidacionLecheItem(
    liquidacionLecheId:             json["liquidacionLecheId"],
    clienteId:                      json["clienteId"],
    clienteTamboId:                 json["clienteTamboId"],
    fecha:                          DateTime.parse(json["fecha"]),
    fVto:                           DateTime.parse(json["fVto"]),
    letra:                          json["letra"],
    prefijo:                        json["prefijo"],
    nro:                            json["nro"],
    gravado:                        json["gravado"],
    iva:                            json["iva"],
    retencionIB:                    json["retencionIB"],
    retencionG:                     json["retencionG"],
    retencionIVA:                   json["retencionIVA"],
    neto:                           json["neto"],
    precioGrasa:                    json["precioGrasa"],
    precioProteina:                 json["precioProteina"],
    porcRetencionIB:                json["porcRetencionIB"],
    porcRetencionG:                 json["porcRetencionG"],
    porcRetencionIVA:               json["porcRetencionIVA"],
    baseImponibleRetencionIB:       json["baseImponibleRetencionIB"],
    alicuotaIva:                    json["alicuotaIva"],
    datosAdicionales:               json["datosAdicionales"],
    uis:                            json["uis"],
    listaMercadoInterno:            List<LiquidacionLecheMercadoInterno>.from(json["listaMercadoInterno"].map((x) => LiquidacionLecheMercadoInterno.fromJson(x))),
    listaBonificacionesCalidad:     List<LiquidacionLecheBonificacionCalidad>.from(json["listaBonificacionesCalidad"].map((x) => LiquidacionLecheBonificacionCalidad.fromJson(x))),
    listaBonificacionesComerciales: List<LiquidacionLecheBonificacionComerciales>.from(json["listaBonificacionesComerciales"].map((x) => LiquidacionLecheBonificacionComerciales.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "liquidacionLecheId":             liquidacionLecheId,
    "clienteId":                      clienteId,
    "clienteTamboId":                 clienteTamboId,
    "fecha":                          fecha!.toIso8601String(),
    "fVto":                           fVto!.toIso8601String(),
    "letra":                          letra,
    "prefijo":                        prefijo,
    "nro":                            nro,
    "gravado":                        gravado,
    "iva":                            iva,
    "retencionIB":                    retencionIB,
    "retencionG":                     retencionG,
    "retencionIVA":                   retencionIVA,
    "neto":                           neto,
    "precioGrasa":                    precioGrasa,
    "precioProteina":                 precioProteina,
    "porcRetencionIB":                porcRetencionIB,
    "porcRetencionG":                 porcRetencionG,
    "porcRetencionIVA":               porcRetencionIVA,
    "baseImponibleRetencionIB":       baseImponibleRetencionIB,
    "alicuotaIva":                    alicuotaIva,
    "datosAdicionales":               datosAdicionales,
    "uis":                            uis,
    "listaMercadoInterno":            List<LiquidacionLecheMercadoInterno>.from(listaMercadoInterno.map((x) => x.toJson())),
    "listaBonificacionesCalidad":     List<LiquidacionLecheBonificacionCalidad>.from(listaBonificacionesCalidad.map((x) => x.toJson())),
    "listaBonificacionesComerciales": List<LiquidacionLecheBonificacionComerciales>.from(listaBonificacionesComerciales.map((x) => x.toJson())),
  };
}

class LiquidacionLecheResponse {

  List<LiquidacionLecheItem> listaDeLiquidaciones;

  LiquidacionLecheResponse({this.listaDeLiquidaciones = const []});

  factory LiquidacionLecheResponse.fromJson(Map<String, dynamic> json) =>
    LiquidacionLecheResponse(
      listaDeLiquidaciones: List<LiquidacionLecheItem>.from(json["listaDeLiquidaciones"].map((x) => LiquidacionLecheItem.fromJson(x))),
    );

  Map<String, dynamic> toJson() => {
    "listaDeLiquidaciones": List<LiquidacionLecheItem>.from(listaDeLiquidaciones.map((x) => x.toJson())),
  };
}