

class NotificacionItem {
  
  int notificacionId;
  String gEconomicoId;
  String gEconomico;
  String empresaId;
  String empresa;
  String userName;
  String tipo;
  String titulo;
  String mensaje;
  String servicioCodigo;
  DateTime? fecha;
  bool wasRead;
  String tabla;
  String campo;
  String valor;
  String icon;


  NotificacionItem({
    this.notificacionId = 0,
    this.gEconomicoId   = '',
    this.gEconomico     = '',
    this.empresaId      = '',
    this.empresa        = '',
    this.userName       = '',
    this.tipo           = '',
    this.titulo         = '',
    this.mensaje        = '',
    this.servicioCodigo = '',
    this.fecha,
    this.wasRead        = false,
    this.tabla          = '',
    this.campo          = '',
    this.valor          = '',
    this.icon           = '',
  });

  factory NotificacionItem.fromJson(Map json) => NotificacionItem(
    notificacionId: json["notificacionId"] ?? -1,
    gEconomicoId:   json["gEconomicoId"],
    gEconomico:     json["gEconomico"],
    empresaId:      json["empresaId"],
    empresa:        json["empresa"],
    userName:       json["userName"],
    tipo:           json["tipo"],
    titulo:         json["titulo"],
    mensaje:        json["mensaje"],
    servicioCodigo: json["servicioCodigo"],
    fecha:          DateTime.parse(json["fecha"]),
    wasRead:        json["wasRead"],
    tabla:          json["tabla"],
    campo:          json["campo"],
    valor:          json["valor"],
    icon:           json["icon"],
  );

   Map<String, dynamic> toJson() => {
      "notificacionId": notificacionId,
      "gEconomicoId":   gEconomicoId,
      "gEconomico":     gEconomico,
      "empresaId":      empresaId,
      "empresa":        empresa,
      "userName":       userName,
      "tipo":           tipo,
      "titulo":         titulo,
      "mensaje":        mensaje,
      "servicioCodigo": servicioCodigo,
      "fecha":          fecha,
      "wasRead":        wasRead,
      "tabla":          tabla,
      "campo":          campo,
      "valor":          valor,
      "icon":           icon,
    };
}

class NotificacionesListaResponse {

  String tokenDeAcceso;
  List<NotificacionItem> listaDeNotificaciones;
  

  NotificacionesListaResponse({
    this.tokenDeAcceso = '',
    this.listaDeNotificaciones = const [],
  });

  factory NotificacionesListaResponse.fromJson(Map<String, dynamic> json) => NotificacionesListaResponse(
    tokenDeAcceso: json["tokenDeAcceso"],
    listaDeNotificaciones: List<NotificacionItem>.from(json["listaDeNotificaciones"].map((x) => NotificacionItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tokenDeAcceso": tokenDeAcceso,
    "listaNotificacionItem": List<NotificacionItem>.from(listaDeNotificaciones.map((x) => x.toJson())),
  };

}

class NotificacionesListaRequest {

  String? tokenDeRefresco;
  int pageSize;
  int pageNro;

  NotificacionesListaRequest({
    this.tokenDeRefresco,
    this.pageSize = 100,
    this.pageNro = 1,
  });

  factory NotificacionesListaRequest.fromJson(Map<String, dynamic> json) => NotificacionesListaRequest(
    tokenDeRefresco:            json["tokenDeRefresco"],
    pageSize:                   json["pageSize"],
    pageNro:                    json["pageNro"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco":            tokenDeRefresco,
    "pageSize":                   pageSize,
    "pageNro":                    pageNro,
  };

}