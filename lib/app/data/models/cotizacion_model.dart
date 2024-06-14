
//!-------------------------------------------------------------- CtaCteResumenDeSaldosItem


class Cotizacion {
  
  DateTime fecha;
  double cotizacion;

  Cotizacion({
    required this.fecha,
    required this.cotizacion,
  });

  factory Cotizacion.fromJson(Map json) => Cotizacion(
    fecha:        DateTime.parse(json["fecha"]),
    cotizacion:   json["cotizacion"].toDouble(),
    
  );

   Map<String, dynamic> toJson() => {
      "fecha":        fecha,
      "cotizacion":   cotizacion,
    };
}