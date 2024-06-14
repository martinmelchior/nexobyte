import 'package:flutter/material.dart';
import 'package:nexobyte/app/constants.dart';

const kTLightPrimaryColor = Color(0xFF838383);
const kTLightPrimaryColor1 = Color.fromARGB(255, 231, 231, 231);
const kTLightPrimaryColor2 = Color.fromARGB(255, 211, 211, 211);
const kTLightPrimaryColor3 = Color(0xFFF0F0F0);

//*-- PANTALLA DE LOGIN Y RECUPERO DE CONTRASEÑA
//-------------------------------------------------------------------
const kTBackgroundColorBtnIngresarLogin = Color.fromARGB(255, 145, 196, 37);
const kTLabelColorBtnIngresarLogin = Colors.white70;
const kTIconColorTextBoxLogin = Color.fromARGB(255, 255, 255, 255);
const kTLoginTextFieldErrorStyle = TextStyle(color: Color(0xFFE07A5F), fontWeight: FontWeight.bold);
const kTLabelTextBoxLogin = Color.fromARGB(255, 76, 107, 8);

//*-- DETERMINA EL COLOR DE FONDO DE LAS CAJAS DE TEXTO DEL LOGIN
//-------------------------------------------------------------------
final kTBoxDecorationStyle = BoxDecoration(
  color: const Color.fromARGB(255, 185, 185, 185),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 4.0,
      offset: Offset(0, 2),
    ),
  ],
);

const kTHintTextStyle = TextStyle(
  color: Colors.white,
);

const kTAllLabelsColor = Color.fromARGB(255, 61, 52, 0);
const kTColorsTabsAnalisis = Color.fromARGB(19, 0, 54, 74);
const kTClientesLabelsColor = Color.fromARGB(221, 48, 47, 47);

const kTScaffoldBackColor = Color(0xFFeaeaea);
const kTScaffoldBackColorHome = Color.fromARGB(255, 27, 5, 5);

//*-- LISTVIEW
//-------------------------------------------------------------------
const kTItemBackGroundColor = Color(0xFFeeeeee);

//*-- CALENDAR
//-------------------------------------------------------------------
const kTDatePickerPrimary = kTLightPrimaryColor;
const kTDatePickerOnPrimary = Colors.white70;
const kTDatePickerOnSurface = Colors.white;
const kTDatePickerButtons = Colors.white;

//*-- DRAWER
//-------------------------------------------------------------------
const kTDrawerLabelColor = Color.fromARGB(255, 16, 29, 59);
const kTDrawerIconColor = Color.fromARGB(255, 16, 29, 59);

const kTIconColor = Color.fromARGB(255, 16, 29, 59);
const kTAppBarTextColor = Color.fromARGB(255, 16, 29, 59);

//*-- Progress indicator colors
//-------------------------------------------------------------------
const kTColorProgressIndicator = kTLightPrimaryColor2;
const kTBackgroundColorProgressIndicator = kTLightPrimaryColor1;
const kTLabelColorProgressIndicator = kTLabelColorBtnIngresarLogin;

//*-- Home
//-------------------------------------------------------------------
const kTLabelBtnHome = kTIconColor;
const kTLabelResumenHome = kTIconColor;
const kTLabelEspecieResumenHome = Color.fromARGB(255, 95, 83, 3);
const kTBackgroundBtnHome = Color.fromARGB(153, 255, 253, 245);


//*-- Compartir
//-------------------------------------------------------------------
const kTCompartirBorderCircle = Color.fromARGB(117, 241, 146, 3);
const kTCompartirIcono = Color.fromARGB(255, 241, 146, 3);

//*-- Carrousel - Cereales y dolares
//-------------------------------------------------------------------
const kTLabelEspecieCarrousel = kTLabelEspecieResumenHome;
const kTLabelEspeciePuerto = Colors.white38;
const kTLabelEspeciePrecio = Color.fromARGB(255, 75, 151, 59);
const kTLabelDolar = kTLabelEspecieResumenHome;
const kTLabelDolarCotizacion = Color.fromARGB(255, 75, 151, 59);

//*-- Colores estados OL
//-------------------------------------------------------------------
const kOlColorEstadoFacturada = Color(0xFF6b9ae0);
const kOlColorEstadoAnulada = Color(0xFF000000);
const kOlColorEstadoCerrada = Color(0xFF74b72E);
const kOlColorEstadoRealizada = Color(0xFF74cc44);
const kOlColorEstadoPendiente = Color(0xFFFF2400);
const kOlColorEstadoCreada = Colors.white54;
const kOlColorEstadoRemitado = Color(0xFFFF8800);


//*-- Pills
//-------------------------------------------------------------------
const kTPillsBackColor = kTLightPrimaryColor;
const kTPillsSelectedColor = kTLightPrimaryColor3;



//*-- Background del avatar de los granos
//-------------------------------------------------------------------
const kTCircleAvatarBackgroundColor = Colors.white70;

//*-- Errores por campos vacíos
//-------------------------------------------------------------------
const kErrorBackColor = kTRedColor;
const kErrorTextColor = Colors.black54;

const kTRedColor = Color.fromARGB(255, 233, 74, 71);

//*-- Importes
//-------------------------------------------------------------------
const kTImporteAFavor = Color(0xFF74b700);
const kTImporteEnContra = Color(0xFFbf212f);

const kSemaforoR = Color(0xFFFF2400);
const kSemaforoA = Color(0xFFFFFF00);
const kSemaforoV = Color(0xFF74b72E);

// ignore: constant_identifier_names
const kTNo_Libre = Color(0xFFFF2400);
// ignore: constant_identifier_names
const kTEn_Saneamiento = Color(0xFFFFFF00);
const kTLibre = Color(0xFF74b72E);

const kTLogoHeight = 80.0;

const kTShadowImporteAFavor =
    Shadow(offset: Offset(1.0, 1.0), blurRadius: 10.0, color: Colors.black54);

const kTShadowImporteEnContra =
    Shadow(offset: Offset(1.0, 1.0), blurRadius: 10.0, color: Colors.white54);

const kTCpi = CircularProgressIndicator(color: kTColorProgressIndicator, backgroundColor: kTBackgroundColorProgressIndicator);
const kTLpi = LinearProgressIndicator(color: kTColorProgressIndicator, backgroundColor: kTBackgroundColorProgressIndicator, minHeight: 8);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: kTLightPrimaryColor,
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: kTLightPrimaryColor,
      ),
  dialogTheme: const DialogTheme(
    backgroundColor: kTLightPrimaryColor2,
    titleTextStyle: TextStyle(
        color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14.0),
    contentTextStyle: TextStyle(color: Colors.white70, fontSize: 15.0),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: kTLightPrimaryColor,
    selectionColor: kTLightPrimaryColor,
    selectionHandleColor: kTLightPrimaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: kTLightPrimaryColor)),
  canvasColor: kTLightPrimaryColor,
  fontFamily: 'Sora', 
);

Widget kTBackgroundContainer = Container(
  height: double.infinity,
  width: double.infinity,
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        kTLightPrimaryColor1,
        kTLightPrimaryColor2,
        kTLightPrimaryColor1,
        //kTLightPrimaryColor,
      ],
      stops: [0.0, 0.3, 1.0],
    ),
  ),
);

Widget kTflexibleSpace = Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[kTLightPrimaryColor1, kTLightPrimaryColor3])));

Image kTappLogo = Image(
    image: ExactAssetImage(Constants.kLogoEmpresa),
    width: 100.0,
    alignment: FractionalOffset.center);



const kTLoginLabelStyle = TextStyle(
  color: kTLabelTextBoxLogin,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);



final kTButtonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.white),
    backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor));


