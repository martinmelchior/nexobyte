import 'package:flutter/foundation.dart';
import 'package:money2/money2.dart';

enum FormMode {
  none,
  update,
  insert,
}

enum Roles {
  // ignore: constant_identifier_names
  SUPERADMINISTRADOR,
  // ignore: constant_identifier_names
  ADMINISTRADOR_CLIENTE,
  // ignore: constant_identifier_names
  CLIENTES,
  // ignore: constant_identifier_names
}

extension RolesEx on Roles {
  String toText() => describeEnum(this);
}

class Constants {
  static String appLicenseName = "NEXOBYTE";
  static bool usaLicenciamiento = true;
  static String urlApiLicenseControl = "https://vendomas.store/api/v1/";

  /* -------------------------------------------------------------------------------*/
  /* -ACA-          MODIFICAR CUANDO PASE DE TESTING A PRODUCCION                   */
  /* -------------------------------------------------------------------------------*/
  static String urlBase = "http://200.114.108.84:8090/"; //!-- PRODUCCION
  //static String urlBase = "http://peperina.ddns.net/MobileApiRest/"; //*-- TESTING

  static bool isTesting = false;
  static String urlBaseVersion = urlBase + 'api/v1';

  //* Si encontramos esta constante en urlBase se muestra un BANNER TESTING
  static String kUrlContaintTesting = 'conveyor';

  static String andoridId = "ar.com.nexobyte";
  static String urlSite = "http://nexobyte.com.ar/";

  static String kLogoLogin = 'assets/img/logo_login.png';
  static String kLogoEmpresa = 'assets/img/nexoLogo.png';
  static String kLogoEmpresaIcon = 'assets/img/logoEmpresaIcon.png';
  static String kLogoDrawer = 'assets/img/logo_drawer.png';
  static String kLogoWhatsapp = 'assets/img/logo-whatsapp.png';
  static String telWhatsapp = "0";

  static String kImgCtaCte = 'assets/img/ctacte.png';
  //-- ADD 2.2
  static String kImgCtaCteDolar = 'assets/img/ctactedolar.png';
  static String kImgCtaCteGranos = 'assets/img/ctacteGranos.png';
  static String kImgMisClientesVEN = 'assets/img/clientes.png';
  static String kImgTambos = 'assets/img/lch-face.png';
  static String kImgOLA = 'assets/img/OLA.png';
  static String kImgPOS = 'assets/img/POS.png';
  static String kImgIOL = 'assets/img/IOL.png';
  static String kImgOLNew = 'assets/img/OL_NEW.png';
  static String kImgOLView = 'assets/img/OL_VIEW.png';
  static String kImgRain = 'assets/img/RAIN.png';
  static String kImgMovimInterno = 'assets/img/silo.png';
  static String kImgFeedback = 'assets/img/feedback.png';
  static String kImgAnuncio = 'assets/img/anuncio.png';
  static String kImgAnalisisMani = 'assets/img/mani.png';
  static String kImgAfla = 'assets/img/aflatoxina.png';
  static String kImgPDF = 'assets/img/pdf.png';
  //-- v4.0 BEGIN
  static String kImgCompPendientes = 'assets/img/docs_pendientes.png';
  static String kImgArtiPendientes = 'assets/img/articulos.png';
  //-- v4.0 END
  //-- v4.1
  static String kImgUbicacion = 'assets/img/point.png';
  //-- v4.5
  static String kRemitosPendientes = 'assets/img/remito_pendientes.png'; 

  static String kEmailSoporte = 'martin.melchior@gmail.com';

  //* Datos para testing
  static String kEmailTesting = 'martin.melchior@gmail.com';
  static String kPassTesting = '159263';

  static String urlDesarrolladoPor = "http://nexobyte.com.ar";

  //--- https://money2.noojee.dev/formatting/formatting-patterns
  static Currency monedaAR = Currency.create('PES', 2,
      invertSeparators: true,
      pattern: 'S #.###,00',
      country: 'Argentina',
      unit: 'Pesos',
      name: 'Pesos Argentinos');

  static Currency monedaUSD = Currency.create('USD', 2,
      symbol: "USD",
      invertSeparators: true,
      pattern: 'S #.###,00',
      country: 'United State',
      unit: 'Dolares',
      name: 'Dolar USA');

  static Currency monedaARN0 = Currency.create('PES', 2,
      invertSeparators: true,
      pattern: 'S #.###',
      country: 'Argentina',
      unit: 'Pesos',
      name: 'Pesos Argentinos');
}
