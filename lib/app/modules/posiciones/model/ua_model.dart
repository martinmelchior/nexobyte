
//*--------------------------------------------------------------------------- MOVIMIENTO STOCK UA
class UAMovimientoStockRequest {
  String tokenDeRefresco;
  UAUsuarioDetalleItem? uaUsuarioResumenItemMovStock;
  int pageNro;
  int pageSize;
  
  UAMovimientoStockRequest({
    this.tokenDeRefresco = '',
    this.uaUsuarioResumenItemMovStock,
    this.pageNro = 1,
    this.pageSize = 500,
  });
}

class UAMovimientoStockResponse {

  List<UAMovimientoStockItem> listaUAMovimientosDeStock;

  UAMovimientoStockResponse({
    this.listaUAMovimientosDeStock = const []
  });

  factory UAMovimientoStockResponse.fromJson(Map<String, dynamic> json) => UAMovimientoStockResponse(
    listaUAMovimientosDeStock: List<UAMovimientoStockItem>.from(json["listaUAMovimientosDeStock"].map((x) => UAMovimientoStockItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaUAMovimientosDeStock": List<UAMovimientoStockItem>.from(listaUAMovimientosDeStock.map((x) => x.toJson())),
  };
}

class UAMovimientoStockItem {

  String gEconomicoId;
  String empresaId;
  String empresa;
  int uaId;
  String ua;
  //--
  int articuloId;
  String articulo;
  int codigo;
  String comprobante;
  DateTime fecha;
  double entrada;
  double salida;
  double saldo;

  UAMovimientoStockItem({
      required this.gEconomicoId,
      required this.empresaId,
      required this.empresa,
      required this.uaId,
      required this.ua,
      //-- 
      required this.articuloId,
      required this.articulo,
      required this.codigo,
      required this.comprobante,
      required this.fecha,
      required this.entrada,
      required this.salida,
      required this.saldo,
    });

  factory UAMovimientoStockItem.fromJson(Map json) => UAMovimientoStockItem(
    gEconomicoId:   json["gEconomicoId"],
    empresaId:      json["empresaId"],
    empresa:        json["empresa"],
    uaId:           json["uaId"],
    ua:             json["ua"],
    //--
    articuloId:     json["articuloId"]  ?? 0,
    articulo:       json["articulo"],
    codigo:         json["codigo"]      ?? 0,
    comprobante:    json["comprobante"],
    fecha:          DateTime.parse(json["fecha"]),
    entrada:        json["entrada"]     ?? 0,
    salida:         json["salida"]      ?? 0,
    saldo:          json["saldo"]       ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId":   gEconomicoId,
    "empresaId":      empresaId,
    "empresa":        empresa,
    "uaId":           uaId,
    "ua":             ua,
    //--
    "articuloId":     articuloId,
    "articulo":       articulo,
    "codigo":         codigo,
    "comprobante":    comprobante,
    "fecha":          fecha,
    "entrada":        entrada,
    "salida":         salida,
    "saldo":          saldo,
  };
}



//*--------------------------------------------------------------------------- UA DETALLE ITEM
class UAUsuarioDetalleRequest {
  String tokenDeRefresco;
  UAUsuarioResumenItem? uaResumenItem;
  int pageNro;
  int pageSize;
  
  UAUsuarioDetalleRequest({
    this.tokenDeRefresco = '',
    this.uaResumenItem,
    this.pageNro = 1,
    this.pageSize = 200,
  });
}

class UAUsuarioDetalleResponse {

  List<UAUsuarioDetalleItem> listaUAUsuarioDetalleItem;

  UAUsuarioDetalleResponse({
    this.listaUAUsuarioDetalleItem = const []
  });

  factory UAUsuarioDetalleResponse.fromJson(Map<String, dynamic> json) => UAUsuarioDetalleResponse(
    listaUAUsuarioDetalleItem: List<UAUsuarioDetalleItem>.from(json["listaUAUsuarioDetalleItem"].map((x) => UAUsuarioDetalleItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaUAUsuarioDetalleItem": List<UAUsuarioDetalleItem>.from(listaUAUsuarioDetalleItem.map((x) => x.toJson())),
  };
}

class UAUsuarioDetalleItem {

  String gEconomicoId;
  String empresaId;
  String empresa;
  int uaId;
  String ua;
  //--
  double entrada;
  double salida;
  double stock;
  int articuloId;
  String articulo;
  int codigo;
  double precio;
  double valorizado;
  String unidad;
  String seccion;
  String linea;
  String rubro;
  String unidadNegocio;
  bool existeMov;


  UAUsuarioDetalleItem({
      required this.gEconomicoId,
      required this.empresaId,
      required this.empresa,
      required this.uaId,
      required this.ua,
      //-- 
      required this.entrada,
      required this.salida,
      required this.stock,
      required this.articuloId,
      required this.articulo,
      required this.codigo,
      required this.precio,
      required this.valorizado,
      required this.unidad,
      required this.seccion,
      required this.linea,
      required this.rubro,
      required this.unidadNegocio,
      required this.existeMov,
    });

  factory UAUsuarioDetalleItem.fromJson(Map json) => UAUsuarioDetalleItem(
    gEconomicoId:   json["gEconomicoId"],
    empresaId:      json["empresaId"],
    empresa:        json["empresa"],
    uaId:           json["uaId"],
    ua:             json["ua"],
    //--
    entrada :       json["entrada"]     ?? 0,
    salida :        json["salida"]      ?? 0,
    stock :         json["stock"]       ?? 0,
    articuloId :    json["articuloId"]  ?? 0,
    articulo :      json["articulo"],
    codigo :        json["codigo"]      ?? 0,
    precio :        json["precio"]      ?? 0,
    valorizado :    json["valorizado"]  ?? 0,
    unidad :        json["unidad"],
    seccion :       json["seccion"],
    linea :         json["linea"],
    rubro :         json["rubro"],
    unidadNegocio : json["unidadNegocio"],
    existeMov :     json["existeMov"]   ?? false,
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId":   gEconomicoId,
    "empresaId":      empresaId,
    "empresa":        empresa,
    "uaId":           uaId,
    "ua":             ua,
    //--
    "entrada" :       entrada,
    "salida" :        salida,
    "stock" :         stock,
    "articuloId" :    articuloId,
    "articulo" :      articulo,
    "codigo" :        codigo,
    "precio" :        precio,
    "valorizado" :    valorizado,
    "unidad" :        unidad,
    "seccion" :       seccion,
    "linea" :         linea,
    "rubro" :         rubro,
    "unidadNegocio" : unidadNegocio,
    "existeMov" :     existeMov,
  };
}



//*--------------------------------------------------------------------------- UA RESUMEN ITEM
class UAUsuarioResumenItem {

  String gEconomicoId;
  String empresaId;
  String empresa;
  int uaId;
  String ua;
  int cantArticulos;

  UAUsuarioResumenItem({
      required this.gEconomicoId,
      required this.empresaId,
      required this.empresa,
      required this.uaId,
      required this.ua,
      required this.cantArticulos,
    });

  factory UAUsuarioResumenItem.fromJson(Map json) => UAUsuarioResumenItem(
    gEconomicoId: json["gEconomicoId"],
    empresaId: json["empresaId"],
    empresa: json["empresa"],
    uaId: json["uaId"],
    ua: json["ua"],
    cantArticulos: json["cantArticulos"],
  );

  Map<String, dynamic> toJson() => {
    "gEconomicoId": gEconomicoId,
    "empresaId": empresaId,
    "empresa": empresa,
    "uaId": uaId,
    "ua": ua,
    "cantArticulos": cantArticulos,
  };
}

//*--------------------------------------------------------------------------- UA RESUMEN RESPONSE
class UAUsuarioResumenResponse {

  List<UAUsuarioResumenItem> listaUAUsuarioResumenItem;

  UAUsuarioResumenResponse({
    this.listaUAUsuarioResumenItem = const []
  });

  factory UAUsuarioResumenResponse.fromJson(Map<String, dynamic> json) => UAUsuarioResumenResponse(
    listaUAUsuarioResumenItem: List<UAUsuarioResumenItem>.from(json["listaUAUsuarioResumenItem"].map((x) => UAUsuarioResumenItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaUAUsuarioResumenItem": List<UAUsuarioResumenItem>.from(listaUAUsuarioResumenItem.map((x) => x.toJson())),
  };
}

//*--------------------------------------------------------------------------- YA RESUMEN REQUEST
class UAUsuarioResumenRequest {
  String tokenDeRefresco;
 
  UAUsuarioResumenRequest({
    this.tokenDeRefresco = '',
  });
}

