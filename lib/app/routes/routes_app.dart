


abstract class AppRoutes {

  static const rHomeCliente              = "/homeCliente";
 
  //! CTA CTE
  static const rCtacteClienteDetalle     = "/ctacteClienteDetalle";
  static const rCtacteResumenCliente     = "/ctacteResumenCliente";

  //! VENDEDOR
  static const rCtacteResumenClienteVEN  = "/ctacteResumenClienteVen";
  static const rCtacteDetalleClienteVEN  = "/ctacteDetalleClienteVen";

  //! CTA CTE GRANOS - PEC = Productor / Especie / Cosecha
  static const rCtacteGranariaResumenPEC = "/ctacteGranariaResumenPEC";     
  static const rCtacteGranariaDetallePEC = "/ctacteGranariaDetallePEC";
  static const rCtacteGranariaDetalleMOV = "/ctacteGranariaDetalleMOV";

  //! ENTREGAS DE LECHE
  static const rResumenEntregasDeLeche   = "/resumenEntregasDeLeche";     
  static const rDetalleEntregasDeLeche   = "/detalleEntregasDeLeche";

  //! CONTRATISTAS
  static const rMenuContratista         = "/rMenuContratista";
  static const rResumenOLContratista    = "/rResumenOLContratista";     
  static const rListaDeOLsContratista   = "/rListaDeOLsContratista";
  static const rOlDetalleContratista    = "/rOlDetalleContratista";     

  //! INGENIEROS
  static const rResumenOLIngenieros     = "/rResumenOLIngenieros";     
  static const rListaDeOLsIngeniero     = "/rListaDeOLsIngeniero";  
  static const rOlDetalleIngeniero      = "/rOlDetalleIngeniero";     
  static const rOlRemitarIngeniero      = "/rOlRemitarIngeniero";     

  //! POSICIONES
  static const rPOSUsuarioResumen       = "/rPOSUsuarioResumen";     
  static const rPOSUsuarioDetalle       = "/rPOSUsuarioDetalle";
  static const rPOSMovStock             = "/rPOSMovStock";

  //! MOVIMIENTOS INTERNOS
  static const rMovInternoList          = "/rMovInternoList";     
  static const rMovInternoItem          = "/rMovInternoItem";     

  //! LLUVIAS
  static const rLluviasList             = "/rLluviasList";     
  static const rLluviasItem             = "/rLluviasItem";     
   
  //! OL
  static const rMenuIngenieros           = "/rMenuIngenieros";
  static const rFiltrosOLsIng            = "/rFiltrosOLsIng";
  static const rFiltrosOLsCon            = "/rFiltrosOLsCon";
  
  //! OL PASOS
  static const rOlPaso1                  = "/rOlPaso1";     
  static const rOlPaso2                  = "/rOlPaso2";
  static const rOlPaso3                  = "/rOlPaso3";

  //! OL HAS
  static const rOlHasTrabajadas          = "/rOlHasTrabajadas";
  
  //! OL articulos
  static const rOlArticulos              = "/rOlArticulos";
  
  static const rUpdater                  = "/updater";
  static const rLogin                    = "/login";
  static const rRedirect                 = "/redirect";
  static const rCerrarSesion             = "/cerrarSesion";
  static const rPasswordRecovery         = "/passwordRecovery";
  static const rPasswordChange           = "/passwordChange";
  static const rEnviar123456             = "/enviar123456";

  //* Utilities
  static const rAppVersion               = "/AppVersion";
  static const rMantenimiento            = "/Mantenimiento";
  static const rAceptarTyC               = "/rAceptarTyC";

  static const rEnviarFeedback            = "/enviarFeedback";

  static const rNotificaciones            = "/rNotificaciones";

  static const rOLGenerica                = "/rOLGenerica";
  static const rAgregarArticuloDosis      = "/rAgregarArticuloDosis";
  static const rAgregarArticuloDosisATodos= "/rAgregarArticuloDosisATodos";

  //!-- Add 2.7
  static const rResumenOperarioOls        = "/rResumenOperarioOls";
  //!-- Add 2.9
  static const rAsientosContablesOl       = "/rAsientosContablesOl";
  //!-- Add 3.0
  static const rCtaCteResumenXls          = "/rCtaCteResumenXls";
  static const rCtaCteGranariaResumenXls  = "/rCtaCteGranariaResumenXls";

  //!-- Add 3.2
  static const rSolicitudAdelantoLista      = "/rSolicitudAdelantoLista";
  static const rSolicitudAdelantoItem       = "/rSolicitudAdelantoItem";
  static const rSolicitudEfectivoItem       = "/rSolicitudEfectivoItem";
  static const rSolicitudChequeItem         = "/rSolicitudChequeItem";
  static const rSolicitudPropiasItem        = "/rSolicitudPropiasItem";
  static const rSolicitudOtrasItem          = "/rSolicitudOtrasItem";
  static const rAgendaCbuLista              = "/rAgendaCbuLista";
  static const rAgendaCbuItem               = "/rAgendaCbuItem";
  static const rSolicitudTransferenciaItem  = "/rSolicitudTransferenciaItem";

  //!-- Add 3.4
  static const rResumenAnalisisLista        = "/rResumenAnalisisLista";
  static const rAnalisisLista               = "/rAnalisisLista";
  static const rAnalisisDeManiItem          = "/rAnalisisDeManiItem";

  //!-- ADD COMPROBANTES
  static const rVerComprobante              = "/rVerComprobante";
  static const rVerComprobanteSinApiRest    = "/rVerComprobanteSinApiRest";

  static const rEstadisticasLeche           = "/rEstadisticasLeche";
  
  //! upload certificados
  static const rUploadCertPaso1          = "/rUploadCertPaso1";
  static const rUploadCertPaso2          = "/rUploadCertPaso2";

  //! liquidaciones LECHE
  static const rLiquidacionesLecheLista   = "/rLiquidacionesLecheLista";
  static const rLiquidacionesLecheItem    = "/rLiquidacionesLecheItem";

  //-- v4.0 BEGIN
  static const rCompPendFiltroClientes      = "/rCompPendFiltroClientes";
  static const rCompPendClientes            = "/rCompPendClientes";
  static const rCompPendReporte             = "/rCompPendReporte";
  static const rCompPendDownload            = "/rCompPendDownload";

  static const rFacturaReservaFiltroClientes= "/rFacturaReservaFiltroClientes";
  static const rFacturaReservaClientes      = "/rFacturaReservaClientes";
  static const rFacturaReservaReporte       = "/rFacturaReservaReporte";
  static const rFacturaReservaDownload      = "/rFacturaReservaDownload";
  //-- v4.0 END

  //-- v4.5 BEGIN
  static const rRemitosSinFacturaFiltroClientes      = "/rRemitosSinFacturaFiltroClientes";
  static const rRemitosSinFacturaListaPage           = "/rRemitosSinFacturaListaPage";
  //-- v4.5
}


