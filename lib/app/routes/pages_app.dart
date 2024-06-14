import 'package:nexobyte/app/modules/remitos_sin_factura/remitos_sin_factura_cliente/remitos_sin_factura_clientes_binding.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/modules/adelantos/adelanto_item/adelanto_item_binding.dart';
import 'package:nexobyte/app/modules/adelantos/adelanto_item/adelanto_item_page.dart';
import 'package:nexobyte/app/modules/adelantos/adelanto_lista/adelanto_lista_binding.dart';
import 'package:nexobyte/app/modules/adelantos/adelanto_lista/adelanto_lista_page.dart';
import 'package:nexobyte/app/modules/adelantos/agenda_cbu_item/agenda_cbu_item_binding.dart';
import 'package:nexobyte/app/modules/adelantos/agenda_cbu_item/agenda_cbu_item_page.dart';
import 'package:nexobyte/app/modules/adelantos/agenda_cbu_lista/agenda_cbu_lista_binding.dart';
import 'package:nexobyte/app/modules/adelantos/agenda_cbu_lista/agenda_cbu_lista_page.dart';
import 'package:nexobyte/app/modules/adelantos/cheque_item/cheque_item_binding.dart';
import 'package:nexobyte/app/modules/adelantos/cheque_item/cheque_item_page.dart';
import 'package:nexobyte/app/modules/adelantos/efectivo_item/efectivo_item_binding.dart';
import 'package:nexobyte/app/modules/adelantos/efectivo_item/efectivo_item_page.dart';
import 'package:nexobyte/app/modules/adelantos/transferencia_item/transferencia_item_binding.dart';
import 'package:nexobyte/app/modules/adelantos/transferencia_item/transferencia_item_page.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/item/analisis_item_binding.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/item/analisis_item_page.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/lista/analisis_lista_binding.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/lista/analisis_lista_page.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/resumen/analisis_de_mani_resumen_binding.dart';
import 'package:nexobyte/app/modules/analisis_de_mani/resumen/analisis_de_mani_resumen_page.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_detalle/ctacte_detalle_binding.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_detalle/ctacte_detalle_page.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_resumen/ctacte_resumen_binding.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_resumen/ctacte_resumen_page.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_resumen_xls/ctacte_resumen_xls_binding.dart';
import 'package:nexobyte/app/modules/cta_cte/ctacte_resumen_xls/ctacte_resumen_xls_page.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/ctacte_granaria_resumen_xls/ctacte_granaria_resumen_xls_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/ctacte_granaria_resumen_xls/ctacte_granaria_resumen_xls_page.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/especie_cosecha/ctacte_granos_productor_especie_cosecha_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/especie_cosecha/ctacte_granos_productor_especie_cosecha_page.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/movimientos/movimientos_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_granaria/movimientos/movimientos_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/charts/estadisticas/estadisticas_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/charts/estadisticas/estadisticas_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/cta_cte_leche_resumen/cta_cte_leche_resumen_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/cta_cte_leche_resumen/cta_cte_leche_resumen_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/detalle_tambos/detalle_entregas_leche_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/detalle_tambos/detalle_entregas_leche_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/liquidaciones_lista/liquidaciones_lista_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/liquidaciones_lista/liquidaciones_lista_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/upload_certificados/paso1/upload_certificados_paso_1_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/upload_certificados/paso1/upload_certificados_paso_1_page.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/upload_certificados/paso2/upload_certificados_paso_2_binding.dart';
import 'package:nexobyte/app/modules/cta_cte_leche/upload_certificados/paso2/upload_certificados_paso_2_page.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/pages/mov_interno_item/mov_interno_binding.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/pages/mov_interno_item/mov_interno_page.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/pages/mov_interno_list/mov_interno_list_binding.dart';
import 'package:nexobyte/app/modules/ea_mov_interno/pages/mov_interno_list/mov_interno_list_page.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_cliente/facturas_reserva_clientes_binding.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_cliente/facturas_reserva_clientes_page.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_download/facturas_reserva_download_binding.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_download/facturas_reserva_download_page.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_filtro/facturas_reserva_filtro_binding.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_filtro/facturas_reserva_filtro_page.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_reporte/facturas_reserva_reporte_binding.dart';
import 'package:nexobyte/app/modules/facturas_reserva/facturas_reserva_reporte/facturas_reserva_reporte_page.dart';
import 'package:nexobyte/app/modules/genericos/app_version_info/app_version_info_binding.dart';
import 'package:nexobyte/app/modules/genericos/app_version_info/app_version_info_page.dart';
import 'package:nexobyte/app/modules/genericos/close_session/close_session_binding.dart';
import 'package:nexobyte/app/modules/genericos/close_session/close_session_page.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/ver_comprobante/ver_comprobante_binding.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/ver_comprobante/ver_comprobante_page.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/ver_comprobante_sin_apirest/ver_comprobante_sin_apirest_binding.dart';
import 'package:nexobyte/app/modules/genericos/comprobantes/ver_comprobante_sin_apirest/ver_comprobante_sin_apirest_page.dart';
import 'package:nexobyte/app/modules/genericos/enviar123456/enviar123456_binding.dart';
import 'package:nexobyte/app/modules/genericos/enviar123456/enviar123456_page.dart';
import 'package:nexobyte/app/modules/genericos/feedback/enviar_feedback_binding.dart';
import 'package:nexobyte/app/modules/genericos/feedback/enviar_feedback_page.dart';
import 'package:nexobyte/app/modules/genericos/home/home_binding.dart';
import 'package:nexobyte/app/modules/genericos/home/home_page.dart';
import 'package:nexobyte/app/modules/genericos/login/login_binding.dart';
import 'package:nexobyte/app/modules/genericos/login/login_page.dart';
import 'package:nexobyte/app/modules/genericos/mantenimiento/mantenimiento_binding.dart';
import 'package:nexobyte/app/modules/genericos/mantenimiento/mantenimiento_page.dart';
import 'package:nexobyte/app/modules/genericos/notificaciones/notificaciones_lista_binding.dart';
import 'package:nexobyte/app/modules/genericos/notificaciones/notificaciones_lista_page.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/pages/ol_generica_detalle/ol_generica_detalle_binding.dart';
import 'package:nexobyte/app/modules/genericos/orden_laboreo_generica/pages/ol_generica_detalle/ol_generica_detalle_page.dart';
import 'package:nexobyte/app/modules/genericos/password_change/password_change_binding.dart';
import 'package:nexobyte/app/modules/genericos/password_change/password_change_page.dart';
import 'package:nexobyte/app/modules/genericos/password_recovery/password_recovery_binding.dart';
import 'package:nexobyte/app/modules/genericos/password_recovery/password_recovery_page.dart';
import 'package:nexobyte/app/modules/genericos/redirect/redirect_binding.dart';
import 'package:nexobyte/app/modules/genericos/redirect/redirect_page.dart';
import 'package:nexobyte/app/modules/genericos/terminos_y_condiciones/tyc_binding.dart';
import 'package:nexobyte/app/modules/genericos/terminos_y_condiciones/tyc_page.dart';
import 'package:nexobyte/app/modules/genericos/updater/updater_binding.dart';
import 'package:nexobyte/app/modules/genericos/updater/updater_page.dart';
import 'package:nexobyte/app/modules/lluvias/pages/lluvias_item/lluvias_item_binding.dart';
import 'package:nexobyte/app/modules/lluvias/pages/lluvias_item/lluvias_item_page.dart';
import 'package:nexobyte/app/modules/lluvias/pages/lluvias_list/lluvias_list_binding.dart';
import 'package:nexobyte/app/modules/lluvias/pages/lluvias_list/lluvias_list_page.dart';
import 'package:nexobyte/app/modules/operarios/resumen_ols/resumen_operario_ols_binding.dart';
import 'package:nexobyte/app/modules/operarios/resumen_ols/resumen_operario_ols_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/menu/menu_contratista_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/menu/menu_contratista_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_detalle/orden_laboreo_contratista_detalle_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_detalle/orden_laboreo_contratista_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_filtros/orden_laboreo_filtros_con_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_filtros/orden_laboreo_filtros_con_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_lista/ordenes_laboreo_lista_contratista_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/orden_laboreo_lista/ordenes_laboreo_lista_contratista_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/resumen/ordenes_laboreo_contratista_resumen_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_contratistas/pages/resumen/ordenes_laboreo_contratista_resumen_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/agregar_articulo/agregar_articulo_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/agregar_articulo/agregar_articulo_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/agregar_articulo_a_lotes/agregar_articulo_a_lotes_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/agregar_articulo_a_lotes/agregar_articulo_a_lotes_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/cant_hectareas/cant_hectareas_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/find_articulos/find_articulos_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/find_articulos/find_articulos_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/menu/menu_ingenieros_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/orden_laboreo_asientos/orden_laboreo_asientos_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/orden_laboreo_asientos/orden_laboreo_asientos_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/orden_laboreo_detalle/orden_laboreo_ingeniero_detalle_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/orden_laboreo_detalle/ordenes_laboreo_ingeniero_detalle_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_filtros/ordenes_laboreo_filtros_ing_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_filtros/ordenes_laboreo_filtros_ing_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_1_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_2_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_2_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_3_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_item/orden_laboreo_item_paso_3_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_lista/ordenes_laboreo_lista_ingeniero_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_lista/ordenes_laboreo_lista_ingeniero_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_remitar/ordenes_laboreo_remitar_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_remitar/ordenes_laboreo_remitar_page.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_resumen/ordenes_laboreo_ingeniero_resumen_binding.dart';
import 'package:nexobyte/app/modules/ordenes_laboreos_ingenieros/pages/ordenes_laboreo_resumen/ordenes_laboreo_ingeniero_resumen_page.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_detalle/ua_detalle_binding.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_detalle/ua_detalle_page.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_movim_stock/ua_movim_stock_binding.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_movim_stock/ua_movim_stock_page.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_resumen/ua_resumen_binding.dart';
import 'package:nexobyte/app/modules/posiciones/pages/ua_resumen/ua_resumen_page.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_cliente/comp_pendientes_clientes_binding.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_cliente/comp_pendientes_clientes_page.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_download/comp_pendientes_download_binding.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_download/comp_pendientes_download_page.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_filtro/comp_pendientes_filtro_binding.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_filtro/comp_pendientes_filtro_page.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_reporte/comp_pendientes_reporte_binding.dart';
import 'package:nexobyte/app/modules/tesoreria/comp_pendientes_reporte/comp_pendientes_reporte_page.dart';
import 'package:nexobyte/app/modules/vendedor/ctacte_detalle/ctacte_detalle_cliente_vendedor_binding.dart';
import 'package:nexobyte/app/modules/vendedor/ctacte_detalle/ctacte_detalle_cliente_vendedor_page.dart';
import 'package:nexobyte/app/modules/vendedor/ctacte_resumen/ctacte_resumen_cliente_vendedor_binding.dart';
import 'package:nexobyte/app/modules/vendedor/ctacte_resumen/ctacte_resumen_cliente_vendedor_page.dart';
import '../modules/remitos_sin_factura/remitos_sin_factura_cliente/remitos_sin_factura_clientes_page.dart';
import '../modules/remitos_sin_factura/remitos_sin_factura_lista/remitos_sin_factura_lista_binding.dart';
import '../modules/remitos_sin_factura/remitos_sin_factura_lista/remitos_sin_factura_lista_page.dart';
import 'routes_app.dart';


class AppPages {

  static final List<GetPage> pages = [
    
    //*  Clientes
    GetPage(name: AppRoutes.rHomeCliente,             page: () => const HomePage(),                           binding: HomeBinding()),
    
    //*  Clientes CC
    GetPage(name: AppRoutes.rCtacteClienteDetalle,    page: () => CtaCteDetallePage(),                        binding: CtaCteDetalleBinding()),
    GetPage(name: AppRoutes.rCtacteResumenCliente,    page: () => CtaCteResumenDeSaldosPage(),                binding: CtaCteResumenDeSaldosBinding()),

    //*  Clientes GRANOS
    GetPage(name: AppRoutes.rCtacteGranariaResumenPEC,page: () => CtaCteProductorGranosEspecieCosechaPage(),  binding: CtaCteProductorEspecieCosechaBinding()),
    GetPage(name: AppRoutes.rCtacteGranariaDetalleMOV,page: () => const MovimientosPage(),                    binding: MovimientosBinding()),

    //*  Clientes ENTREGAS DE LECHE
    GetPage(name: AppRoutes.rResumenEntregasDeLeche,  page: () => const CtaCteLecheResumenPage(),             binding: CtaCteLecheResumenPageBinding()),
    GetPage(name: AppRoutes.rDetalleEntregasDeLeche,  page: () => DetalleEntregasLechePage(),                 binding: DetalleEntregasLecheBinding()),

    //*  Vendedor
    GetPage(name: AppRoutes.rCtacteResumenClienteVEN, page: () => CtaCteResumenDeSaldosClientesVendedorPage(),binding: CtaCteResumenDeSaldosClientesVendedorBinding()),
    GetPage(name: AppRoutes.rCtacteDetalleClienteVEN, page: () => CtaCteDetalleClienteVendedorPage(),         binding: CtaCteDetalleClienteVendedorBinding()),

    //*  Contratista
    GetPage(name: AppRoutes.rMenuContratista,         page: () => MenuContratistaPage(),                      binding: MenuContratistaBinding()),
    GetPage(name: AppRoutes.rResumenOLContratista,    page: () => OrdenesLaboreosResumenDeContratistaPage(),  binding: OrdenesLaboreosResumenDeContratistaBinding()),
    GetPage(name: AppRoutes.rListaDeOLsContratista,   page: () => OrdenesLaboreoContratistaListaPage(),       binding: OrdenesLaboreoContratistaBinding()),
    GetPage(name: AppRoutes.rOlDetalleContratista,    page: () => OrdenLaboreContratistaDetallePage(),        binding: OrdenLaboreoContratistaDetalleBinding()),
    
    //*  OL
    GetPage(name: AppRoutes.rOlPaso1,                 page: () => OrdenLaboreoItemPaso1(),            binding: OrdenLaboreoItemPaso1Binding()),
    GetPage(name: AppRoutes.rOlPaso2,                 page: () => OrdenLaboreoItemPaso2(),            binding: OrdenLaboreoItemPaso2Binding()),
    GetPage(name: AppRoutes.rOlPaso3,                 page: () => OrdenLaboreoItemPaso3(),            binding: OrdenLaboreoItemPaso3Binding()),
    
    //*  MOVIMIENTO INTERNO
    GetPage(name: AppRoutes.rMovInternoList,          page: () => MovInternoListPage(),               binding: MovInternoListBinding()),
    GetPage(name: AppRoutes.rMovInternoItem,          page: () => MovInternoItemPage(),               binding: MovInternoItemBinding()),
    
    //*  Posiciones
    GetPage(name: AppRoutes.rPOSUsuarioResumen,       page: () => UAUsuarioResumenPage(),      binding: UAUsuarioResumenBinding()),
    GetPage(name: AppRoutes.rPOSUsuarioDetalle,       page: () => UAUsuarioDetalleListaPage(), binding: UAUsuarioDetalleBinding()),
    GetPage(name: AppRoutes.rPOSMovStock,             page: () => UAMovimientoStockListaPage(), binding: UAMovimientoStockBinding()),

    //*  Updater
    GetPage(name: AppRoutes.rUpdater,                  page: () => UpdaterPage(),              binding: UpdaterBinding()),
    GetPage(name: AppRoutes.rRedirect,                 page: () => RedirectPage(),             binding: RedirectBinding()),
    GetPage(name: AppRoutes.rLogin,                    page: () => LoginPage(),                binding: LoginBinding()),
    GetPage(name: AppRoutes.rCerrarSesion,             page: () => CloseSessionPage(),         binding: CloseSessionBinding()),
    GetPage(name: AppRoutes.rPasswordRecovery,         page: () => PasswordRecoveryPage(),     binding: PasswordRecoveryBinding()),
    GetPage(name: AppRoutes.rPasswordChange,           page: () => PasswordChangePage(),       binding: PasswordChangeBinding()),
    GetPage(name: AppRoutes.rEnviar123456,             page: () => Enviar123456Page(),         binding: Enviar123456Binding()),

    //*  Utils
    GetPage(name: AppRoutes.rAppVersion,               page: () => AppVersionInfoPage(),       binding: AppVersionInfoBinding()),
    GetPage(name: AppRoutes.rMantenimiento,            page: () => const MantenimientoPage(),  binding: MantenimientoBinding()),
    GetPage(name: AppRoutes.rEnviarFeedback,           page: () => EnviarFeedBackPage(),       binding: EnviarFeedbackBinding()),
    GetPage(name: AppRoutes.rAceptarTyC,               page: () => const TyCPage(),            binding: TyCBinding()),

    //*  Ingenieros
    GetPage(name: AppRoutes.rResumenOLIngenieros,     page: () => OrdenesLaboreosResumenDeIngenieroPage(),  binding: OrdenesLaboreosResumenDeIngenieroBinding()),
    GetPage(name: AppRoutes.rMenuIngenieros,          page: () => MenuIngenieroPage(),                      binding: MenuIngenierosBinding()),
    GetPage(name: AppRoutes.rListaDeOLsIngeniero,     page: () => OrdenesLaboreoListaIngenieroPage(),       binding: OrdenesLaboreoListaIngenieroBinding()),
    GetPage(name: AppRoutes.rOlDetalleIngeniero,      page: () => OrdenLaboreoDetalleIngenieroPage(),       binding: OrdenLaboreoDetalleIngenieroBinding()),
    GetPage(name: AppRoutes.rOlRemitarIngeniero,      page: () => OrdenesLaboreoRemitarPage(),              binding: OrdenesLaboreoRemitarBinding()),

    //*  Notificaciones
    GetPage(name: AppRoutes.rNotificaciones,          page: () => NotificacionesListaPage(),          binding: NotificacionesListaBinding()),

    //*  OL Generica
    GetPage(name: AppRoutes.rOLGenerica,              page: () => OrdenLaboreoGenericaDetallePage(),  binding: OrdenLaboreoGenericaDetalleBinding()),

    //*  Filtros OLS ingenieros y contratistas
    GetPage(name: AppRoutes.rFiltrosOLsIng,           page: () => OrdenesLaboreoFiltrosIngPage(),     binding: OrdenesLaboreoFiltrosIngBinding()),
    GetPage(name: AppRoutes.rFiltrosOLsCon,           page: () => OrdenLaboreoFiltrosConPage(),       binding: OrdenLaboreoFiltrosConBinding()),

    //*  LUVIAS
    GetPage(name: AppRoutes.rLluviasList,             page: () => LluviasListPage(),                  binding: LluviasListBinding()),
    GetPage(name: AppRoutes.rLluviasItem,             page: () => LluviasItemPage(),                  binding: LluviasItemBinding()),

    //*  OL HAS TRABAJADAS
    GetPage(name: AppRoutes.rOlHasTrabajadas,           page: () => const CantHectareasPage()),
    GetPage(name: AppRoutes.rOlArticulos,               page: () => FindArticulosPage(),              binding: FindArticulosBinding()),
    GetPage(name: AppRoutes.rAgregarArticuloDosis,      page: () => AgregarArticuloPage(),            binding: AgregarArticuloBinding()),
    GetPage(name: AppRoutes.rAgregarArticuloDosisATodos,page: () => AgregarArticuloALotesPage(),      binding: AgregarArticuloALotesBinding()),

    //*  RESUMEN OPERARIO OL    - Add 2.7
    GetPage(name: AppRoutes.rResumenOperarioOls,        page: () => ResumenOperariosOlsPage(),        binding: ResumenOperarioOlsBinding()),
    //*  ASIENTOS CONTABLES OL  - Add 2.9
    GetPage(name: AppRoutes.rAsientosContablesOl,       page: () => const OrdenLaboreoAsientosPage(), binding: OrdenLaboreoAsientosBinding()),
    
    //*  DESCARGAR RESUMEN DE CTA CTE - Add 3.0
    GetPage(name: AppRoutes.rCtaCteResumenXls,          page: () => const CtaCteResumenXlsPage(),         binding: CtaCteResumenXlsBinding()),
    GetPage(name: AppRoutes.rCtaCteGranariaResumenXls,  page: () => const CtaCteGranariaResumenXlsPage(), binding: CtaCteGranariaResumenXlsBinding()),

    //*  Add 3.2
    GetPage(name: AppRoutes.rSolicitudAdelantoLista,      page: () => AdelantoListaPage(),      binding: AdelantoListaBinding()),
    GetPage(name: AppRoutes.rSolicitudAdelantoItem,       page: () => AdelantoItemPage(),       binding: AdelantoItemBinding()),
    GetPage(name: AppRoutes.rSolicitudEfectivoItem,       page: () => EfectivoItemPage(),       binding: EfectivoItemBinding()),
    GetPage(name: AppRoutes.rSolicitudChequeItem,         page: () => ChequeItemPage(),         binding: ChequeItemBinding()),
    GetPage(name: AppRoutes.rAgendaCbuLista,              page: () => AgendaCbuListPage(),      binding: AgendaCbuListBinding()),
    GetPage(name: AppRoutes.rAgendaCbuItem,               page: () => AgendaCbuItemPage(),      binding: AgendaCbuItemBinding()),
    GetPage(name: AppRoutes.rSolicitudTransferenciaItem,  page: () => TransferenciaItemPage(),  binding: TransferenciaItemBinding()),    

    //*  Add 3.4
    GetPage(name: AppRoutes.rResumenAnalisisLista,        page: () => AnalisisDeManiResumenPage(),  binding: AnalisisDeManiResumenBinding()),
    GetPage(name: AppRoutes.rAnalisisLista,               page: () => AnalisisListaPage(),          binding: AnalisisListaBinding()),
    GetPage(name: AppRoutes.rAnalisisDeManiItem,          page: () => const AnalisisItemPage(),     binding: AnalisisItemBinding()),

    //*  Add Comprobantes
    GetPage(name: AppRoutes.rVerComprobante,              page: () => const VerComprobantePage(),           binding: VerComprobanteBinding()),
    GetPage(name: AppRoutes.rVerComprobanteSinApiRest,    page: () => const VerComprobanteSinApiRestPage(), binding: VerComprobanteSinApiRestBinding()),

    //*  Estadísticas Leche
    GetPage(name: AppRoutes.rEstadisticasLeche,           page: () => const EstadisticasPage(),          binding: EstadisticasBinding()),
    
    //*  Upload Certificados
    GetPage(name: AppRoutes.rUploadCertPaso1,             page: () => const UploadCertificadosPaso1Page(), binding: UploadCertificadosPaso1Binding()),
    GetPage(name: AppRoutes.rUploadCertPaso2,             page: () => const UploadCertificadosPaso2Page(), binding: UploadCertificadosPaso2Binding()),

    //*  Liquidaciones LECHE
    GetPage(name: AppRoutes.rLiquidacionesLecheLista,     page: () => LiquidacionesListaPage(), binding: LiquidacionesListaBinding()),    

    //-- v4.0 BEGIN
    GetPage(name: AppRoutes.rCompPendFiltroClientes,      page: () => CompPendientesFiltroPage(),     binding: CompPendientesFiltroBinding()),
    GetPage(name: AppRoutes.rCompPendClientes,            page: () => CompPendientesClientesPage(),   binding: CompPendientesClientesBinding()),
    GetPage(name: AppRoutes.rCompPendReporte,             page: () => CompPendientesReportePage(),    binding: CompPendientesReporteBinding()),
    GetPage(name: AppRoutes.rCompPendDownload,            page: () => const CompPendientesDownloadPage(),   binding: CompPendientesDownloadBinding()),

    GetPage(name: AppRoutes.rFacturaReservaFiltroClientes,page: () => FacturasReservaFiltroPage(),     binding: FacturasReservaFiltroBinding()),
    GetPage(name: AppRoutes.rFacturaReservaClientes,      page: () => FacturasReservaClientesPage(),   binding: FacturasReservaClientesBinding()),
    GetPage(name: AppRoutes.rFacturaReservaReporte,       page: () => FacturasReservaReportePage(),    binding: FacturasReservaReporteBinding()),
    GetPage(name: AppRoutes.rFacturaReservaDownload,      page: () => const FacturasReservaDownloadPage(),   binding: FacturasReservaDownloadBinding()),
    //-- v4.0 END

    //-- v4.5 BEGIN
    GetPage(name: AppRoutes.rRemitosSinFacturaFiltroClientes,      page: () => RemitosSinFacturaFiltroClientesPage(), binding: RemitosSinFacturaFiltroClientesBinding()),
    GetPage(name: AppRoutes.rRemitosSinFacturaListaPage,           page: () => RemitosSinFacturaListaPage(),          binding: RemitosSinFacturaListaBinding()),
    //-- v4.5 END
    
  ];
}

