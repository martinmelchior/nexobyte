

//!-------------------------------------------------------------- ServiciosActivos
import 'dart:convert';

class ServiciosActivos {
  
    ServiciosActivos({
        required this.grupoEconomico,
        required this.empresa,
        required this.servicioCodigo,
        required this.empresaActiva,
        required this.servicioActivo,
        required this.visibleWeb,
        required this.activarConsultaCtaCteCliente,
        required this.activarConsultaCtaCteClienteGranaria,
    });

    
    final String grupoEconomico;
    final String empresa;
    final String servicioCodigo;
    final bool empresaActiva;
    final bool servicioActivo;
    final bool visibleWeb;
    final bool activarConsultaCtaCteCliente;
    final bool activarConsultaCtaCteClienteGranaria;

    factory ServiciosActivos.fromRawJson(String str) => ServiciosActivos.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ServiciosActivos.fromJson(Map<String, dynamic> json) => ServiciosActivos(
        grupoEconomico                        : json["grupoEconomico"], 
        empresa                               : json["empresa"],
        servicioCodigo                        : json["servicioCodigo"],
        empresaActiva                         : json["empresaActiva"],
        servicioActivo                        : json["servicioActivo"],
        visibleWeb                            : json["visibleWeb"],
        activarConsultaCtaCteCliente          : json["activarConsultaCtaCteCliente"],
        activarConsultaCtaCteClienteGranaria  : json["activarConsultaCtaCteClienteGranaria"],
    );

    Map<String, dynamic> toJson() => {
        "grupoEconomico"                        : grupoEconomico,
        "empresa"                               : empresa,
        "servicioCodigo"                        : servicioCodigo,
        "empresaActiva"                         : empresaActiva,
        "servicioActivo"                        : servicioActivo,
        "visibleWeb"                            : visibleWeb,
        "activarConsultaCtaCteCliente"          : activarConsultaCtaCteCliente,
        "activarConsultaCtaCteClienteGranaria"  : activarConsultaCtaCteClienteGranaria,
        
    };
}