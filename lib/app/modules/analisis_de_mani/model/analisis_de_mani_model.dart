//!-------------------------------------------------------------- ResumenAnalisisItem
class ResumenAnalisisItem {
  
  String gEconomicoId;
  String empresaId;
  String empresa;
  int clienteId;
  String clienteProductor;
  int cantidad;
  int pageSize;
  int pageNro;

  ResumenAnalisisItem({
    required this.gEconomicoId,
    required this.empresaId,
    required this.empresa,
    required this.clienteId,
    required this.clienteProductor,
    required this.cantidad,
    this.pageSize = 100,
    this.pageNro = 1,
  });

  factory ResumenAnalisisItem.fromJson(Map json) => ResumenAnalisisItem(
    gEconomicoId:             json["gEconomicoId"] ?? '',
    empresaId:                json["empresaId"] ?? '',
    empresa:                  json["empresa"] ?? '',
    clienteId:                json["clienteId"] ?? 0,
    clienteProductor:         json["clienteProductor"] ?? '',
    cantidad:                 json["cantidad"] ?? 0,
    pageSize:                 json["pageSize"] ?? 100,
    pageNro:                  json["pageNro"] ?? 1,
  );

   Map<String, dynamic> toJson() => {
      "gEconomicoId":           gEconomicoId,
      "empresaId":              empresaId,
      "empresa":                empresa,
      "clienteId":              clienteId,
      "clienteProductor":       clienteProductor,
      "cantidad":               cantidad,
      "pageSize":               pageSize,
      "pageNro":                pageNro,
    };
}



//!-------------------------------------------------------------- ResumenAnalisisItemResponse
class ResumenAnalisisItemResponse {

  List<ResumenAnalisisItem> listaResumenAnalisisItem;

  ResumenAnalisisItemResponse({
    required this.listaResumenAnalisisItem
  });

  factory ResumenAnalisisItemResponse.fromJson(Map<String, dynamic> json) => ResumenAnalisisItemResponse(
    listaResumenAnalisisItem: List<ResumenAnalisisItem>.from(json["listaResumenAnalisisItem"].map((x) => ResumenAnalisisItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaResumenAnalisisItem": List<ResumenAnalisisItem>.from(listaResumenAnalisisItem.map((x) => x.toJson())),
  };

}

//!-------------------------------------------------------------- AnalisisDeMani
class AnalisisDeMani {
  
  int? analisisManiEnCajaId;
  DateTime? fecha;
  String? ctg;
  String? cartaPorteNro;
  int? cartaPorteId;
  String? responsable;
  DateTime? fechaEmisionCPE;
  DateTime? fechaDescargaCPE;
  double? kilosDescargadosCPE;
  String? productor;
  String? chofer;
  //*-- MUESTRA SUCIA
  double? pesoMuestraSucia;
  double? cuerposExtranios;
  double? cuerposExtraniosPorcentaje;
  double? tierra;
  double? tierraPorcentaje;
  double? piedra;
  double? piedraPorcentaje;
  double? granosSueltos;
  double? granosSueltosPorcentaje;
  double? chala;
  double? chalaPorcentaje;
  double? manipuleoMuestraSucia;
  double? manipuleoMuestraSuciaPorcentaje;
  //*-- MUESTRA LIMPIA
  double? pesoMuestraLimpia;
  double? humedad;
  double? humedadPorcentaje;
  double? humedadCoeficiente;
  double? cajaGrano;
  double? cajaGranoPorcentaje;
  double? zarandeo3842;
  double? zarandeo3842Porcentaje;
  double? zarandeo4050;
  double? zarandeo4050Porcentaje;
  double? zarandeo5060;
  double? zarandeo5060Porcentaje;
  double? zarandeo6070;
  double? zarandeo6070Porcentaje;
  double? partido;
  double? partidoPorcentaje;
  double? industria;
  double? industriaPorcentaje;
  //*-- MERMAS
  double? brotado;
  double? brotadoPorcentaje;
  double? ardido;
  double? ardidoPorcentaje;
  double? manchados;
  double? manchadosPorcentaje;
  double? helado;
  double? heladoPorcentaje;
  double? mohoInterno;
  double? mohoInternoPorcentaje;
  double? mohoExterno;
  double? mohoExternoPorcentaje;
  double? carbon;
  double? carbonPorcentaje;
  double? insectos;
  double? insectosPorcentaje;
  double? descompuesto;
  double? descompuestoPorcentaje;
  double? manipuleoMuestraLimpia;
  double? manipuleoMuestraLimpiaPorcentaje;
  //*--
  String? aflatoxinas;
  bool? tieneAfla;
  double? valorAfla;
  String? observaciones; 
  String? explotacion; 
  bool? agroquimicosPresentes;
  //*--
  double? pesoMuestraLimpiaTeorico;
  double? pesoMuestraLimpiaTeoricoPorcentaje;
  double? industriaTeorico;
  double? industriaTeoricoPorcentaje;

  AnalisisDeMani({
    this.analisisManiEnCajaId,
    this.fecha,
    this.ctg,
    this.cartaPorteNro,
    this.cartaPorteId,
    this.responsable,
    this.fechaEmisionCPE,
    this.fechaDescargaCPE,
    this.kilosDescargadosCPE,
    this.productor,
    this.chofer,
    //*-- MUESTRA SUCIA
    this.pesoMuestraSucia,
    this.cuerposExtranios,
    this.cuerposExtraniosPorcentaje,
    this.tierra,
    this.tierraPorcentaje,
    this.piedra,
    this.piedraPorcentaje,
    this.granosSueltos,
    this.granosSueltosPorcentaje,
    this.chala,
    this.chalaPorcentaje,
    this.manipuleoMuestraSucia,
    this.manipuleoMuestraSuciaPorcentaje,
    //*-- MUESTRA LIMPIA
    this.pesoMuestraLimpia,
    this.humedad,
    this.humedadPorcentaje,
    this.humedadCoeficiente,
    this.cajaGrano,
    this.cajaGranoPorcentaje,
    this.zarandeo3842,
    this.zarandeo3842Porcentaje,
    this.zarandeo4050,
    this.zarandeo4050Porcentaje,
    this.zarandeo5060,
    this.zarandeo5060Porcentaje,
    this.zarandeo6070,
    this.zarandeo6070Porcentaje,
    this.partido,
    this.partidoPorcentaje,
    this.industria,
    this.industriaPorcentaje,
    //*-- MERMAS
    this.brotado,
    this.brotadoPorcentaje,
    this.ardido,
    this.ardidoPorcentaje,
    this.manchados,
    this.manchadosPorcentaje,
    this.helado,
    this.heladoPorcentaje,
    this.mohoInterno,
    this.mohoInternoPorcentaje,
    this.mohoExterno,
    this.mohoExternoPorcentaje,
    this.carbon,
    this.carbonPorcentaje,
    this.insectos,
    this.insectosPorcentaje,
    this.descompuesto,
    this.descompuestoPorcentaje,
    this.manipuleoMuestraLimpia,
    this.manipuleoMuestraLimpiaPorcentaje,
    //*--
    this.aflatoxinas,
    this.tieneAfla,
    this.observaciones,
    this.valorAfla,
    this.explotacion,
    this.agroquimicosPresentes,
    //*--
    this.pesoMuestraLimpiaTeorico,
    this.pesoMuestraLimpiaTeoricoPorcentaje,
    this.industriaTeorico,
    this.industriaTeoricoPorcentaje,
  }); 

  factory AnalisisDeMani.fromJson(Map json) => AnalisisDeMani(
    analisisManiEnCajaId:                 json["analisisManiEnCajaId"] ?? 0,
    fecha:                                DateTime.parse(json["fecha"]),
    ctg:                                  json["ctg"] ?? '',
    cartaPorteNro:                        json["cartaPorteNro"] ?? '',
    cartaPorteId:                         json["cartaPorteId"] ?? 0,
    responsable:                          json["responsable"] ?? '',
    fechaEmisionCPE:                      DateTime.parse(json["fechaEmisionCPE"]),
    fechaDescargaCPE:                     DateTime.parse(json["fechaDescargaCPE"]),
    kilosDescargadosCPE:                  json["kilosDescargadosCPE"] ?? 0,
    productor:                            json["productor"] ?? '',
    chofer:                               json["chofer"] ?? '',
    //*-- MUESTRA SUCIA     
    pesoMuestraSucia:                     json["pesoMuestraSucia"] ?? 0.0,
    cuerposExtranios:                     json["cuerposExtranios"] ?? 0.0,
    cuerposExtraniosPorcentaje:           json["cuerposExtraniosPorcentaje"] ?? 0.0,
    tierra:                               json["tierra"] ?? 0.0,
    tierraPorcentaje:                     json["tierraPorcentaje"] ?? 0.0,
    piedra:                               json["piedra"] ?? 0.0,
    piedraPorcentaje:                     json["piedraPorcentaje"] ?? 0.0,
    granosSueltos:                        json["granosSueltos"] ?? 0.0,
    granosSueltosPorcentaje:              json["granosSueltosPorcentaje"] ?? 0.0,
    chala:                                json["chala"] ?? 0.0,
    chalaPorcentaje:                      json["chalaPorcentaje"] ?? 0.0,
    manipuleoMuestraSucia:                json["manipuleoMuestraSucia"] ?? 0.0,
    manipuleoMuestraSuciaPorcentaje:      json["manipuleoMuestraSuciaPorcentaje"] ?? 0.0,
    //*-- MUESTRA LIMPIA
    pesoMuestraLimpia:                    json["pesoMuestraLimpia"] ?? 0.0,
    humedad:                              json["humedad"] ?? 0.0,
    humedadPorcentaje:                    json["humedadPorcentaje"] ?? 0.0,
    humedadCoeficiente:                   json["humedadCoeficiente"] ?? 0.0,
    cajaGrano:                            json["cajaGrano"] ?? 0.0,
    cajaGranoPorcentaje:                  json["cajaGranoPorcentaje"] ?? 0.0,
    zarandeo3842:                         json["zarandeo3842"] ?? 0.0,
    zarandeo3842Porcentaje:               json["zarandeo3842Porcentaje"] ?? 0.0,
    zarandeo4050:                         json["zarandeo4050"] ?? 0.0,
    zarandeo4050Porcentaje:               json["zarandeo4050Porcentaje"] ?? 0.0,
    zarandeo5060:                         json["zarandeo5060"] ?? 0.0,
    zarandeo5060Porcentaje:               json["zarandeo5060Porcentaje"] ?? 0.0,
    zarandeo6070:                         json["zarandeo6070"] ?? 0.0,
    zarandeo6070Porcentaje:               json["zarandeo6070Porcentaje"] ?? 0.0,
    partido:                              json["partido"] ?? 0.0,
    partidoPorcentaje:                    json["partidoPorcentaje"] ?? 0.0,
    industria:                            json["industria"] ?? 0.0,
    industriaPorcentaje:                  json["industriaPorcentaje"] ?? 0.0,
    //*-- MERMAS
    brotado:                              json["brotado"] ?? 0.0,
    brotadoPorcentaje:                    json["brotadoPorcentaje"] ?? 0.0,
    ardido:                               json["ardido"] ?? 0.0,
    ardidoPorcentaje:                     json["ardidoPorcentaje"] ?? 0.0,
    manchados:                            json["manchados"] ?? 0.0,
    manchadosPorcentaje:                  json["manchadosPorcentaje"] ?? 0.0,
    helado:                               json["helado"] ?? 0.0,
    heladoPorcentaje:                     json["heladoPorcentaje"] ?? 0.0,
    mohoInterno:                          json["mohoInterno"] ?? 0.0,
    mohoInternoPorcentaje:                json["mohoInternoPorcentaje"] ?? 0.0,
    mohoExterno:                          json["mohoExterno"] ?? 0.0,
    mohoExternoPorcentaje:                json["mohoExternoPorcentaje"] ?? 0.0,
    carbon:                               json["carbon"] ?? 0.0,
    carbonPorcentaje:                     json["carbonPorcentaje"] ?? 0.0,
    insectos:                             json["insectos"] ?? 0.0,
    insectosPorcentaje:                   json["insectosPorcentaje"] ?? 0.0,
    descompuesto:                         json["descompuesto"] ?? 0.0,
    descompuestoPorcentaje:               json["descompuestoPorcentaje"] ?? 0.0,
    manipuleoMuestraLimpia:               json["manipuleoMuestraLimpia"] ?? 0.0,
    manipuleoMuestraLimpiaPorcentaje:     json["manipuleoMuestraLimpiaPorcentaje"] ?? 0.0,
    //*--
    aflatoxinas:                          json["aflatoxinas"] ?? '',
    tieneAfla:                            json["tieneAfla"] ?? false,
    observaciones:                        json["observaciones"] ?? '',
    valorAfla:                            json["valorAfla"] ?? 0.0,
    explotacion:                          json["explotacion"] ?? '',
    agroquimicosPresentes:                json["agroquimicosPresentes"] ?? '',
    //*--
    pesoMuestraLimpiaTeorico:             json["pesoMuestraLimpiaTeorico"] ?? 0.0,
    pesoMuestraLimpiaTeoricoPorcentaje:   json["pesoMuestraLimpiaTeoricoPorcentaje"] ?? 0.0,
    industriaTeorico:                     json["industriaTeorico"] ?? 0.0,
    industriaTeoricoPorcentaje:           json["industriaTeoricoPorcentaje"] ?? 0.0,
  );

   Map<String, dynamic> toJson() => {
      "analisisManiEnCajaId":             analisisManiEnCajaId,
      "fecha":                            fecha,
      "ctg":                              ctg,
      "cartaPorteNro":                    cartaPorteNro,
      "cartaPorteId":                     cartaPorteId,
      "responsable":                      responsable,
      "fechaEmisionCPE":                  fechaEmisionCPE,
      "fechaDescargaCPE":                 fechaDescargaCPE,
      "kilosDescargadosCPE":              kilosDescargadosCPE,
      "productor":                        productor,
      "chofer":                           chofer,
      //*-- MUESTRA SUCIA
      "pesoMuestraSucia":                 pesoMuestraSucia,
      "cuerposExtranios":                 cuerposExtranios,
      "cuerposExtraniosPorcentaje":       cuerposExtraniosPorcentaje,
      "tierra":                           tierra,
      "tierraPorcentaje":                 tierraPorcentaje,
      "piedra":                           piedra,
      "piedraPorcentaje":                 piedraPorcentaje,
      "granosSueltos":                    granosSueltos,
      "granosSueltosPorcentaje":          granosSueltosPorcentaje,
      "chala":                            chala,
      "chalaPorcentaje":                  chalaPorcentaje,
      "manipuleoMuestraSucia":            manipuleoMuestraSucia,
      "manipuleoMuestraSuciaPorcentaje":  manipuleoMuestraSuciaPorcentaje,
      //*-- MUESTRA LIMPIA
      "pesoMuestraLimpia":                pesoMuestraLimpia,
      "humedad":                          humedad,
      "humedadPorcentaje":                humedadPorcentaje,
      "humedadCoeficiente":               humedadCoeficiente,
      "cajaGrano":                        cajaGrano,
      "cajaGranoPorcentaje":              cajaGranoPorcentaje,
      "zarandeo3842":                     zarandeo3842,
      "zarandeo3842Porcentaje":           zarandeo3842Porcentaje,
      "zarandeo4050":                     zarandeo4050,
      "zarandeo4050Porcentaje":           zarandeo4050Porcentaje,
      "zarandeo5060":                     zarandeo5060,
      "zarandeo5060Porcentaje":           zarandeo5060Porcentaje,
      "zarandeo6070":                     zarandeo6070,
      "zarandeo6070Porcentaje":           zarandeo6070Porcentaje,
      "partido":                          partido,
      "partidoPorcentaje":                partidoPorcentaje,
      "industria":                        industria,
      "industriaPorcentaje":              industriaPorcentaje,
      //*-- MERMAS
      "brotado":                          brotado,
      "brotadoPorcentaje":                brotadoPorcentaje,
      "ardido":                           ardido,
      "ardidoPorcentaje":                 ardidoPorcentaje,
      "manchados":                        manchados,
      "manchadosPorcentaje":              manchadosPorcentaje,
      "helado":                           helado,
      "heladoPorcentaje":                 heladoPorcentaje,
      "mohoInterno":                      mohoInterno,
      "mohoInternoPorcentaje":            mohoInternoPorcentaje,
      "mohoExterno":                      mohoExterno,
      "mohoExternoPorcentaje":            mohoExternoPorcentaje,
      "carbon":                           carbon,
      "carbonPorcentaje":                 carbonPorcentaje,
      "insectos":                         insectos,
      "insectosPorcentaje":               insectosPorcentaje,
      "descompuesto":                     descompuesto,
      "descompuestoPorcentaje":           descompuestoPorcentaje,
      "manipuleoMuestraLimpia":           manipuleoMuestraLimpia,
      "manipuleoMuestraLimpiaPorcentaje": manipuleoMuestraLimpiaPorcentaje,
      //*--
      "aflatoxinas":                      aflatoxinas,
      "tieneAfla":                        tieneAfla,
      "observaciones":                    observaciones,
      "valorAfla":                        valorAfla,
      "explotacion":                      explotacion,
      "agroquimicosPresentes":            agroquimicosPresentes,
      //*--
      "pesoMuestraLimpiaTeorico":           pesoMuestraLimpiaTeorico,
      "pesoMuestraLimpiaTeoricoPorcentaje": pesoMuestraLimpiaTeoricoPorcentaje,
      "industriaTeorico":                   industriaTeorico,
      "industriaTeoricoPorcentaje":         industriaTeoricoPorcentaje,
    };

}

//!-------------------------------------------------------------- ObtenerAnalisisDeManiListaResponse
class ObtenerAnalisisDeManiListaResponse {

  List<AnalisisDeMani> listaDeAnalisisDeMani;

  ObtenerAnalisisDeManiListaResponse({
    required this.listaDeAnalisisDeMani
  });

  factory ObtenerAnalisisDeManiListaResponse.fromJson(Map<String, dynamic> json) => ObtenerAnalisisDeManiListaResponse(
    listaDeAnalisisDeMani: List<AnalisisDeMani>.from(json["listaDeAnalisisDeMani"].map((x) => AnalisisDeMani.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listaDeAnalisisDeMani": List<AnalisisDeMani>.from(listaDeAnalisisDeMani.map((x) => x.toJson())),
  };

}