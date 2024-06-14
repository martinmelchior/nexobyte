
//*-------------------------------------------------------------------------------------------- CotizacionMoneda
class CotizacionMoneda {
  
  int id;
  DateTime? fecha;
  String origen;
  String moneda;
  String descripcion;
  double compra;
  double venta;
  String hora;


  CotizacionMoneda({
    this.id           = 0,
    this.fecha,
    this.origen       = '',
    this.moneda       = '',
    this.descripcion  = '',
    this.compra       = 0.0,
    this.venta        = 0.0,
    this.hora         = '',
  });

  factory CotizacionMoneda.fromJson(Map json) => CotizacionMoneda(
    id:             json["id"] ?? 0,
    fecha:          DateTime.parse(json["fecha"]),
    origen:         json["origen"] ?? '',
    moneda:         json["moneda"] ?? '',
    descripcion:    json["descripcion"] ?? '',
    compra:         json["compra"] ?? 0.0,
    venta:          json["venta"] ?? 0.0,
    hora:           json["hora"] ?? '',
  );

   Map<String, dynamic> toJson() => {
      "id":         id,
      "fecha":      fecha,
      "origen":     origen,
      "moneda":     moneda,
      "descripcion":descripcion,
      "compra":     compra,
      "venta":      venta,
      "hora":       hora,
    };
}


//*-------------------------------------------------------------------------------------------- CotizacionMonedaResponse
class CotizacionMonedaResponse {

  List<CotizacionMoneda> listaCotizacionMoneda;

  CotizacionMonedaResponse({
    this.listaCotizacionMoneda = const [],
  });

  factory CotizacionMonedaResponse.fromJson(Map<String, dynamic> json) => CotizacionMonedaResponse(
    listaCotizacionMoneda: List<CotizacionMoneda>.from(json["listaCotizacionMoneda"].map((x) => CotizacionMoneda.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaCotizacionMoneda": List<CotizacionMoneda>.from(listaCotizacionMoneda.map((x) => x.toJson())),
  };

}


//*-------------------------------------------------------------------------------------------- CotizacionMonedaResponse
class CotizacionMonedaRequest {
  
  String tokenDeRefresco;

  CotizacionMonedaRequest({
    this.tokenDeRefresco = ''
  });

  factory CotizacionMonedaRequest.fromJson(Map<String, dynamic> json) => CotizacionMonedaRequest(
    tokenDeRefresco: json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco": tokenDeRefresco,
  };

}



//*-------------------------------------------------------------------------------------------- CotizacionCereal
class CotizacionCereal {
  
  int id;
  DateTime? fecha;
  String origen;
  String grano;
  double bsas;
  double ros;
  double bb;
  double qq;
  double cba;


  CotizacionCereal({
    this.id           = 0,
    this.fecha,
    this.origen       = '',
    this.grano        = '',
    this.bsas         = 0.0,
    this.ros          = 0.0,
    this.bb           = 0.0,
    this.qq           = 0.0,
    this.cba          = 0.0,
  });

  factory CotizacionCereal.fromJson(Map json) => CotizacionCereal(
    id:             json["id"] ?? 0,
    fecha:          DateTime.parse(json["fecha"]),
    origen:         json["origen"] ?? '',
    grano:          json["grano"] ?? '',
    bsas:           json["bsas"] ?? 0.0,
    ros:            json["ros"] ?? 0.0,
    bb:             json["bb"] ?? 0.0,
    qq:             json["qq"] ?? 0.0,
    cba:            json["cba"] ?? 0.0,
  );

   Map<String, dynamic> toJson() => {
      "id":     id,
      "fecha":  fecha,
      "origen": origen,
      "grano":  grano,
      "bsas":   bsas,
      "ros":    ros,
      "bb":     bb,
      "qq":     qq,
      "cba":    cba,
    };
}


//*-------------------------------------------------------------------------------------------- CotizacionCerealResponse
class CotizacionCerealResponse {

  List<CotizacionCereal> listaCotizacionCereal;

  CotizacionCerealResponse({
    this.listaCotizacionCereal = const [],
  });

  factory CotizacionCerealResponse.fromJson(Map<String, dynamic> json) => CotizacionCerealResponse(
    listaCotizacionCereal: List<CotizacionCereal>.from(json["listaCotizacionCereal"].map((x) => CotizacionCereal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaCotizacionCereal": List<CotizacionCereal>.from(listaCotizacionCereal.map((x) => x.toJson())),
  };

}


//*-------------------------------------------------------------------------------------------- CotizacionMonedaResponse
class CotizacionCerealRequest {

  String tokenDeRefresco;

  CotizacionCerealRequest({
    this.tokenDeRefresco = ''
  });

  factory CotizacionCerealRequest.fromJson(Map<String, dynamic> json) => CotizacionCerealRequest(
    tokenDeRefresco: json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco": tokenDeRefresco,
  };

}

//*-------------------------------------------------------------------------------------------- CotizacionCerealesYMonedasResponse
class CotizacionCerealesYMonedasResponse {

  List<CotizacionCereal> listaCotizacionCereal;
  List<CotizacionMoneda> listaCotizacionMoneda;

  CotizacionCerealesYMonedasResponse({
    this.listaCotizacionCereal = const [],
    this.listaCotizacionMoneda = const [],
  });

  factory CotizacionCerealesYMonedasResponse.fromJson(Map<String, dynamic> json) => CotizacionCerealesYMonedasResponse(
    listaCotizacionCereal: List<CotizacionCereal>.from(json["listaCotizacionCereal"].map((x) => CotizacionCereal.fromJson(x))),
    listaCotizacionMoneda: List<CotizacionMoneda>.from(json["listaCotizacionMoneda"].map((x) => CotizacionMoneda.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaCotizacionCereal": List<CotizacionCereal>.from(listaCotizacionCereal.map((x) => x.toJson())),
    "listaCotizacionMoneda": List<CotizacionMoneda>.from(listaCotizacionMoneda.map((x) => x.toJson())),
  };

}