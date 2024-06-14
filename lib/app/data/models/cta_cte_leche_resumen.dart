class DetalleEntregasLecheRequest {
  String tokenDeRefresco;
  String empresaId;
  int clienteId;
  int clienteTamboId;
  DateTime fechaConsulta; //!-- Vamos a pasar el primer dia del mes/año para cortar por mes
  int top;

  DetalleEntregasLecheRequest({
    required this.tokenDeRefresco,
    required this.empresaId,
    required this.clienteId,
    required this.clienteTamboId,
    required this.fechaConsulta,
    this.top = 60   //!-- Default 60
  });
}

class DetalleEntregasLecheResponse {
  List<EntregaLecheItem> listaEntregasLeche;

  DetalleEntregasLecheResponse({this.listaEntregasLeche = const []});

  factory DetalleEntregasLecheResponse.fromJson(Map<String, dynamic> json) =>
      DetalleEntregasLecheResponse(
        listaEntregasLeche: List<EntregaLecheItem>.from(
            json["listaEntregasLeche"]
                .map((x) => EntregaLecheItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listaEntregasLeche": List<EntregaLecheItem>.from(
            listaEntregasLeche.map((x) => x.toJson())),
      };
}

class EntregaLecheItem {
  int tamboId;
  String tambo;
  DateTime fecha;
  String mes;
  double grasaButirosa;
  String grasaButirosaAlerta;
  double proteinas;
  String proteinasAlerta;
  double ufc;
  String ufcAlerta;
  double rcs;
  String rcsAlerta;
  double temperatura;
  String temperaturaAlerta;
  double temperaturaRef;
  String inhibidores;
  String inhibidoresAlerta;
  double crioscopia;
  String crioscopiaAlerta;
  double totalLeche;
  bool esOficial;
  double saldo;
  String custom;

  EntregaLecheItem({
    required this.tamboId,
    required this.tambo,
    required this.fecha,
    required this.mes,
    required this.grasaButirosa,
    required this.grasaButirosaAlerta,
    required this.proteinas,
    required this.proteinasAlerta,
    required this.ufc,
    required this.ufcAlerta,
    required this.rcs,
    required this.rcsAlerta,
    required this.temperatura,
    required this.temperaturaAlerta,
    this.temperaturaRef = 5.0,
    required this.inhibidores,
    required this.inhibidoresAlerta,
    required this.crioscopia,
    required this.crioscopiaAlerta,
    required this.totalLeche,
    required this.esOficial,
    required this.saldo,
    this.custom = '',
  });

  factory EntregaLecheItem.fromJson(Map json) => EntregaLecheItem(
        tamboId: json["tamboId"],
        tambo: json["tambo"],
        fecha: DateTime.parse(json["fecha"]),
        mes: json["mes"],
        grasaButirosa: json["grasaButirosa"],
        grasaButirosaAlerta: json["grasaButirosaAlerta"],
        proteinas: json["proteinas"],
        proteinasAlerta: json["proteinasAlerta"],
        ufc: json["ufc"],
        ufcAlerta: json["ufcAlerta"],
        rcs: json["rcs"],
        rcsAlerta: json["rcsAlerta"],
        temperatura: json["temperatura"],
        temperaturaAlerta: json["temperaturaAlerta"],
        temperaturaRef: json["temperaturaRef"] ?? 5.0,
        inhibidores: json["inhibidores"],
        inhibidoresAlerta: json["inhibidoresAlerta"],
        crioscopia: json["crioscopia"],
        crioscopiaAlerta: json["crioscopiaAlerta"],
        totalLeche: json["totalLeche"],
        esOficial: json["esOficial"],
        saldo: json["saldo"],
        custom: json["custom"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tamboId": tamboId,
        "tambo": tambo,
        "fecha": fecha,
        "mes": mes,
        "grasaButirosa": grasaButirosa,
        "grasaButirosaAlerta": grasaButirosaAlerta,
        "proteinas": proteinas,
        "proteinasAlerta": proteinasAlerta,
        "ufc": ufc,
        "ufcAlerta": ufcAlerta,
        "rcs": rcs,
        "rcsAlerta": rcsAlerta,
        "temperatura": temperatura,
        "temperaturaAlerta": temperaturaAlerta,
        "temperaturaRef": temperaturaRef,
        "inhibidores": inhibidores,
        "inhibidoresAlerta": inhibidoresAlerta,
        "crioscopia": crioscopia,
        "crioscopiaAlerta": crioscopiaAlerta,
        "totalLeche": totalLeche,
        "esOficial": esOficial,
        "saldo": saldo,
        "custom": custom,
      };
}

class AlertaAnalisisOficialItem {
  int tamboId;
  String tambo;
  DateTime fecha;
  String mes;
  String mmAA;
  double grasaButirosa;
  double grasaButirosaMin;
  double grasaButirosaRef;
  String grasaButirosaAlerta;
  double proteinas;
  double proteinasMin;
  double proteinasRef;
  String proteinasAlerta;
  double ufc;
  double ufcMin;
  double ufcRef;
  String ufcAlerta;
  double rcs;
  double rcsMin;
  double rcsRef;
  String rcsAlerta;
  double temperatura;
  String temperaturaAlerta;
  String inhibidores;
  String inhibidoresAlerta;
  double crioscopia;
  String crioscopiaAlerta;

  AlertaAnalisisOficialItem({
    required this.tamboId,
    required this.tambo,
    required this.fecha,
    required this.mes,
    required this.mmAA,
    required this.grasaButirosa,
    required this.grasaButirosaMin,
    required this.grasaButirosaRef,
    required this.grasaButirosaAlerta,
    required this.proteinas,
    required this.proteinasMin,
    required this.proteinasRef,
    required this.proteinasAlerta,
    required this.ufc,
    required this.ufcMin,
    required this.ufcRef,
    required this.ufcAlerta,
    required this.rcs,
    required this.rcsMin,
    required this.rcsRef,
    required this.rcsAlerta,
    required this.temperatura,
    required this.temperaturaAlerta,
    required this.inhibidores,
    required this.inhibidoresAlerta,
    required this.crioscopia,
    required this.crioscopiaAlerta,
  });

  factory AlertaAnalisisOficialItem.fromJson(Map json) =>
      AlertaAnalisisOficialItem(
        tamboId: json["tamboId"],
        tambo: json["tambo"],
        fecha: DateTime.parse(json["fecha"]),
        mes: json["mes"],
        mmAA: json["mmAA"] ?? '',
        grasaButirosa: json["grasaButirosa"],
        grasaButirosaMin: json["grasaButirosaMin"],
        grasaButirosaRef: json["grasaButirosaRef"],
        grasaButirosaAlerta: json["grasaButirosaAlerta"],
        proteinas: json["proteinas"],
        proteinasMin: json["proteinasMin"],
        proteinasRef: json["proteinasRef"],
        proteinasAlerta: json["proteinasAlerta"],
        ufc: json["ufc"],
        ufcMin: json["ufcMin"],
        ufcRef: json["ufcRef"],
        ufcAlerta: json["ufcAlerta"],
        rcs: json["rcs"],
        rcsMin: json["rcsMin"],
        rcsRef: json["rcsRef"],
        rcsAlerta: json["rcsAlerta"],
        temperatura: json["temperatura"],
        temperaturaAlerta: json["temperaturaAlerta"],
        inhibidores: json["inhibidores"],
        inhibidoresAlerta: json["inhibidoresAlerta"],
        crioscopia: json["crioscopia"],
        crioscopiaAlerta: json["crioscopiaAlerta"],
      );

  Map<String, dynamic> toJson() => {
        "tamboId": tamboId,
        "tambo": tambo,
        "fecha": fecha,
        "mes": mes,
        "mmAA": mmAA,
        "grasaButirosa": grasaButirosa,
        "grasaButirosaMin": grasaButirosaMin,
        "grasaButirosaRef": grasaButirosaRef,
        "grasaButirosaAlerta": grasaButirosaAlerta,
        "proteinas": proteinas,
        "proteinasMin": proteinasMin,
        "proteinasRef": proteinasRef,
        "proteinasAlerta": proteinasAlerta,
        "ufc": ufc,
        "ufcMin": ufcMin,
        "ufcRef": ufcRef,
        "ufcAlerta": ufcAlerta,
        "rcs": rcs,
        "rcsMin": rcsMin,
        "rcsRef": rcsRef,
        "rcsAlerta": rcsAlerta,
        "temperatura": temperatura,
        "temperaturaAlerta": temperaturaAlerta,
        "inhibidores": inhibidores,
        "inhibidoresAlerta": inhibidoresAlerta,
        "crioscopia": crioscopia,
        "crioscopiaAlerta": crioscopiaAlerta,
      };
}

//!-------------------------------------------------------------- EstadisticasMensualesTambo
class EstadisticaMensualTamboItem {
  int tamboId;
  String tambo;
  int anio;
  int mes;
  DateTime dia;
  double totalLitros;

  EstadisticaMensualTamboItem({
    required this.tamboId,
    required this.tambo,
    required this.anio,
    required this.mes,
    required this.dia,
    required this.totalLitros,
  });

  factory EstadisticaMensualTamboItem.fromJson(Map json) =>
      EstadisticaMensualTamboItem(
        tamboId: json["tamboId"],
        tambo: json["tambo"],
        anio: json["anio"],
        mes: json["mes"],
        dia: DateTime.parse(json["dia"]),
        totalLitros: json["totalLitros"],
      );

  Map<String, dynamic> toJson() => {
        "tamboId": tamboId,
        "tambo": tambo,
        "anio": anio,
        "mes": mes,
        "dia": dia,
        "totalLitros": totalLitros,
      };
}

//!-------------------------------------------------------------- CtaCteLecheResumenDeLitrosMesItem
class CtaCteLecheResumenDeLitrosMesItem {
  //-- ADD liquidacion
  String gEconomicoId;
  String empresaId;
  String empresa;
  int clienteId;
  String cliente;
  int tamboId;
  String tambo;
  DateTime fecha;
  String mes;
  double totalLeche;
  bool tieneAlertas;
  String brucelosis;
  String tuberculosis;
  String alertaCertBru;
  String alertaCertTub;
  List<AlertaAnalisisOficialItem> listaDeAlertasAnalisisOficiales;
  List<EstadisticaMensualTamboItem> listaDeEstadisticasMensuales;

  CtaCteLecheResumenDeLitrosMesItem({
    //-- ADD liquidacion
    required this.gEconomicoId,
    required this.empresaId,
    required this.empresa,
    required this.clienteId,
    required this.cliente,
    required this.tamboId,
    required this.tambo,
    required this.fecha,
    required this.mes,
    required this.totalLeche,
    required this.tieneAlertas,
    required this.brucelosis,
    required this.tuberculosis,
    required this.alertaCertBru,
    required this.alertaCertTub,
    this.listaDeAlertasAnalisisOficiales = const [],
    this.listaDeEstadisticasMensuales = const [],
  });

  factory CtaCteLecheResumenDeLitrosMesItem.fromJson(Map json) =>
      CtaCteLecheResumenDeLitrosMesItem(
        //-- ADD liquidacion
        gEconomicoId: json["gEconomicoId"],
        empresaId: json["empresaId"],
        empresa: json["empresa"],
        clienteId: json["clienteId"],
        cliente: json["cliente"],
        tamboId: json["tamboId"],
        tambo: json["tambo"],
        fecha: DateTime.parse(json["fecha"]),
        mes: json["mes"],
        totalLeche: json["totalLeche"],
        tieneAlertas: json["tieneAlertas"],
        brucelosis: json["brucelosis"],
        tuberculosis: json["tuberculosis"],
        alertaCertBru: json["alertaCertBru"],
        alertaCertTub: json["alertaCertTub"],
        listaDeAlertasAnalisisOficiales: List<AlertaAnalisisOficialItem>.from(json["listaDeAlertasAnalisisOficiales"].map((x) => AlertaAnalisisOficialItem.fromJson(x))),
        listaDeEstadisticasMensuales: List<EstadisticaMensualTamboItem>.from(json["listaDeEstadisticasMensuales"].map((x) => EstadisticaMensualTamboItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        //-- ADD liquidacion
        "gEconomicoId": gEconomicoId,
        "empresaId": empresaId,
        "empresa": empresa,
        "clienteId": clienteId,
        "cliente": cliente,
        "tamboId": tamboId,
        "tambo": tambo,
        "fecha": fecha,
        "mes": mes,
        "totalLeche": totalLeche,
        "tieneAlertas": tieneAlertas,
        "brucelosis": brucelosis,
        "tuberculosis": tuberculosis,
        "alertaCertBru": alertaCertBru,
        "alertaCertTub": alertaCertTub,
        "listaDeAlertasAnalisisOficiales": List<AlertaAnalisisOficialItem>.from(listaDeAlertasAnalisisOficiales.map((x) => x.toJson())),
        "listaDeEstadisticasMensuales": List<EstadisticaMensualTamboItem>.from(listaDeEstadisticasMensuales.map((x) => x.toJson())),
      };
}

class CtaCteLecheResumenDeLitrosMesResponse {

  List<CtaCteLecheResumenDeLitrosMesItem> listaDeResumenDeLitrosItem;

  CtaCteLecheResumenDeLitrosMesResponse({this.listaDeResumenDeLitrosItem = const []});

  factory CtaCteLecheResumenDeLitrosMesResponse.fromJson(Map<String, dynamic> json) =>
      CtaCteLecheResumenDeLitrosMesResponse(
        listaDeResumenDeLitrosItem: List<CtaCteLecheResumenDeLitrosMesItem>.from(json["listaDeResumenDeLitrosItem"].map((x) => CtaCteLecheResumenDeLitrosMesItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "listaDeResumenDeLitrosItem": List<CtaCteLecheResumenDeLitrosMesItem>.from(listaDeResumenDeLitrosItem.map((x) => x.toJson())),
  };
}

