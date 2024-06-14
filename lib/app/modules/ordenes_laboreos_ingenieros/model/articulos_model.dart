

//*---------------------------------------------------------------------------  Articulo
class Articulo {
  
  String? nombre;
  String codigo;
  double preUnitario;
  double preBase;
  double pbCotizacion;
  int pbMonedaId;
  int articuloFacId;
  int unidadId;
  double entrada;
  double salida;
  double stockOrdenesLaboreo;
  double stockOrdenesTraslado;
  double ppp;
  double pppCotizacion;
  int pppMonedaId;
  bool seleccionable;
  double stockFisico;
  double stockDisponible;
  String abreviatura;
  String umDestino;
  String umDestinoCorto;
  String umOrigen;
  String umOrigenCorto;
  double equivalencia;
  int idUnico;
  
  Articulo({
    this.nombre = '',
    this.codigo = '',
    this.preUnitario = 0.0,
    this.preBase = 0.0,
    this.pbCotizacion = 0.0,
    this.pbMonedaId = 0,
    this.articuloFacId = 0,
    this.unidadId = 0,
    this.entrada = 0.0,
    this.salida = 0.0,
    this.stockOrdenesLaboreo = 0.0,
    this.stockOrdenesTraslado = 0.0,
    this.ppp = 0.0,
    this.pppCotizacion = 0.0,
    this.pppMonedaId = 0,
    this.seleccionable = false,
    this.stockFisico = 0.0,
    this.stockDisponible = 0.0,
    this.abreviatura = '',
    this.umDestino = '',
    this.umDestinoCorto = '',
    this.umOrigen = '',
    this.umOrigenCorto = '',
    this.equivalencia = 1.0,
    this.idUnico = 0,
  });

  factory Articulo.fromJson(Map json) => Articulo(
    nombre: json["nombre"] ?? '',
    codigo: json["codigo"] ?? '',
    preUnitario: json["preUnitario"] ?? 0.0,
    preBase: json["preBase"] ?? 0.0,
    pbCotizacion: json["pbCotizacion"] ?? 0.0,
    pbMonedaId: json["pbMonedaId"] ?? 0,
    articuloFacId: json["articuloFacId"] ?? 0,
    unidadId: json["unidadId"] ?? 0,
    entrada: json["entrada"] ?? 0.0,
    salida: json["salida"] ?? 0.0,
    stockOrdenesLaboreo: json["stockOrdenesLaboreo"] ?? 0.0,
    stockOrdenesTraslado: json["stockOrdenesTraslado"] ?? 0.0,
    ppp: json["ppp"] ?? 0.0,
    pppCotizacion: json["pppCotizacion"] ?? 0.0,
    pppMonedaId: json["pppMonedaId"] ?? 0,
    seleccionable: json["seleccionable"] ?? false,
    stockFisico: json["stockFisico"] ?? 0.0,
    stockDisponible: json["stockDisponible"] ?? 0.0,
    abreviatura: json["abreviatura"] ?? '',
    umDestino: json["umDestino"] ?? '',
    umDestinoCorto: json["umDestinoCorto"] ?? '',
    umOrigen: json["umOrigen"] ?? '',
    umOrigenCorto: json["umOrigenCorto"] ?? '',
    equivalencia: json["equivalencia"] ?? 1.0,
    idUnico: json["idUnico"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "codigo": codigo,
    "preUnitario": preUnitario,
    "preBase": preBase,
    "pbCotizacion": pbCotizacion,
    "pbMonedaId": pbMonedaId,
    "articuloFacId": articuloFacId,
    "unidadId": unidadId,
    "entrada": entrada,
    "salida": salida,
    "stockOrdenesLaboreo": stockOrdenesLaboreo,
    "stockOrdenesTraslado": stockOrdenesTraslado,
    "ppp": ppp,
    "pppCotizacion": pppCotizacion,
    "pppMonedaId": pppMonedaId,
    "seleccionable": seleccionable,
    "stockFisico": stockFisico,
    "stockDisponible": stockDisponible,
    "abreviatura": abreviatura,
    "umDestino": umDestino,
    "umDestinoCorto": umDestinoCorto,
    "umOrigen": umOrigen,
    "umOrigenCorto": umOrigenCorto,
    "equivalencia": equivalencia,
    "idUnico": idUnico,
  };

}


//*---------------------------------------------------------------------------  ArticulosRequest
class FindArticulosRequest {
  
  String gEconomicoId;
  String empresaId;
  String tokenDeRefresco;
  int pageNro;
  int pageSize;
  double precioDolar;
  int uaOrigenId;
  String findArticulo;
 
  FindArticulosRequest({
    this.gEconomicoId = '',
    this.empresaId = '',
    this.tokenDeRefresco = '',
    this.pageNro = 1,
    this.pageSize = 100,
    this.precioDolar = 1.0,
    this.uaOrigenId = 0,
    this.findArticulo = ''
  });

  factory FindArticulosRequest.fromJson(Map json) => FindArticulosRequest(
    tokenDeRefresco: json["tokenDeRefresco"],
    gEconomicoId: json["gEconomicoId"],
    empresaId: json["empresaId"],
    pageNro: json["pageNro"],
    pageSize: json["pageSize"],
    precioDolar: json["precioDolar"],
    uaOrigenId: json["uaOrigenId"],
    findArticulo: json["findArticulo"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco": tokenDeRefresco,
    "gEconomicoId": gEconomicoId,
    "empresaId": empresaId,
    "pageNro": pageNro,
    "pageSize": pageSize,
    "precioDolar": precioDolar,
    "uaOrigenId": uaOrigenId,
    "findArticulo": findArticulo,
  };
}


//*---------------------------------------------------------------------------  ArticulosResponse
class FindArticulosResponse {
  
  String tokenDeAcceso;
  List<Articulo> articulos;
 
  FindArticulosResponse({
    this.tokenDeAcceso = '',
    this.articulos = const [],
  });

  factory FindArticulosResponse.fromJson(Map json) => FindArticulosResponse(
    tokenDeAcceso:  json["tokenDeAcceso"],
    articulos:      List<Articulo>.from(json["articulos"].map((x) => Articulo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso":  tokenDeAcceso,
    "articulos":      List<Articulo>.from(articulos.map((x) => x.toJson())),
  };
}