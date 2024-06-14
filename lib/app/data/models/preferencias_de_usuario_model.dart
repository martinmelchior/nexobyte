import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class PreferenciasUsuario {
  PreferenciasUsuario({
    this.apellido,
    this.nombre,
    this.email,
    this.cambiarPassword,
    this.rol,
    this.tokenDeAcceso,
    this.tokenDeRefresco,
    this.tokenMobile,
    this.abrirNotificaciones,
    this.showServicioCtaCte,
    this.showServicioCtaCteGranaria,
    this.showServicioEA,
    this.lastError,
    this.latitud,
    this.longitud,
    this.localidad,
    this.cp,
    this.pais,
    this.isFirstTime,
    this.aceptoTYC = false,
    this.showSolicitudDeAdelantos = false,
    //-- v4.0 
    this.verTodasLasCCEnComprobantesPendientes = false,
    this.showColDolaresEnRepCompPendientes = false,   
    //-- v4.1
    this.enviarUbicacion = false, 

  });

  String? apellido;
  String? nombre;
  String? email;
  String? rol;
  String? tokenDeAcceso;
  String? tokenDeRefresco;
  String? tokenMobile;
  bool? abrirNotificaciones;
  bool? cambiarPassword;
  bool? showServicioCtaCte;
  bool? showServicioCtaCteGranaria;
  bool? showServicioEA;
  String? lastError;
  double? latitud;
  double? longitud;
  String? localidad;
  String? cp;
  String? pais;
  bool? isFirstTime;
  bool aceptoTYC;
  bool showSolicitudDeAdelantos;
  //-- v4.0 
  bool verTodasLasCCEnComprobantesPendientes;   
  bool showColDolaresEnRepCompPendientes;  
  //-- v4.1
  bool enviarUbicacion;   

  factory PreferenciasUsuario.fromRawJson(String str) =>
      PreferenciasUsuario.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PreferenciasUsuario.fromJson(Map<String, dynamic> json) =>
      PreferenciasUsuario(
        apellido:                     json["apellido"] ?? '',
        nombre:                       json["nombre"] ?? '',
        email:                        json["email"] ?? '',
        rol:                          json["rol"] ?? '',
        tokenDeAcceso:                json["tokenDeAcceso"] ?? '',
        tokenDeRefresco:              json["tokenDeRefresco"] ?? '',
        tokenMobile:                  json["tokenMobile"] ?? '',
        abrirNotificaciones:          json["abrirNotificaciones"] ?? false,
        cambiarPassword:              json["cambiarPassword"] ?? false,
        showServicioCtaCte:           json["showServicioCtaCte"] ?? false,
        showServicioCtaCteGranaria:   json["showServicioCtaCteGranaria"] ?? false,
        showServicioEA:               json["showServicioEA"] ?? false,
        lastError:                    json["lastError"] ?? '',
        latitud:                      json["latitud"] ?? 0,
        longitud:                     json["longitud"] ?? 0,
        localidad:                    json["localidad"] ?? '',
        cp:                           json["cp"] ?? '',
        pais:                         json["pais"] ?? '',
        isFirstTime:                  json["isFirstTime"] ?? true,
        aceptoTYC:                    json["aceptoTYC"] ?? false,
        showSolicitudDeAdelantos:     json["showSolicitudDeAdelantos"] ?? false,
        //-- v4.0 
        verTodasLasCCEnComprobantesPendientes: json["verTodasLasCCEnComprobantesPendientes"] ?? false,
        showColDolaresEnRepCompPendientes:     json["showColDolaresEnRepCompPendientes"] ?? false,        
        //-- v4.1
        enviarUbicacion:              json["enviarUbicacion"] ?? false,        
      );

  Map<String, dynamic> toJson() => {
        "apellido":                   apellido ?? '',
        "nombre":                     nombre ?? '',
        "email":                      email ?? '',
        "rol":                        rol ?? '',
        "tokenDeAcceso":              tokenDeAcceso ?? '',
        "tokenDeRefresco":            tokenDeRefresco ?? '',
        "tokenMobile":                tokenMobile ?? '',
        "abrirNotificaciones":        abrirNotificaciones ?? false,
        "cambiarPassword":            cambiarPassword ?? false,
        "showServicioCtaCte":         showServicioCtaCte ?? false,
        "showServicioCtaCteGranaria": showServicioCtaCteGranaria ?? false,
        "showServicioEA":             showServicioEA ?? false,
        "lastError":                  lastError ?? '',
        "latitud":                    latitud ?? 0,
        "longitud":                   longitud ?? 0,
        "localidad":                  localidad ?? '',
        "cp":                         cp ?? '',
        "pais":                       pais ?? '',
        "isFirstTime":                isFirstTime ?? true,
        "aceptoTYC":                  aceptoTYC,
        "showSolicitudDeAdelantos":   showSolicitudDeAdelantos,
        //-- v4.0 
        "verTodasLasCCEnComprobantesPendientes": verTodasLasCCEnComprobantesPendientes,
        "showColDolaresEnRepCompPendientes":     showColDolaresEnRepCompPendientes,       
        //-- v4.1
        "enviarUbicacion":      enviarUbicacion, 
      };
}

class PreferenciasDeUsuarioStorage {
  //-- almacenamiento en el dispositivo
  static final GetStorage _box = GetStorage();

  //-- GET Y SET del apellido
  static String get apellido => _box.read<String>('apellido') ?? '';
  static set apellido(String value) => _box.write('apellido', value);
  
  //-- GET Y SET del nombre
  static String get nombre => _box.read<String>('nombre') ?? '';
  static set nombre(String value) => _box.write('nombre', value);
  
  //-- GET Y SET del email
  static String get email => _box.read<String>('email') ?? '';
  static set email(String value) => _box.write('email', value);
  
  //-- GET Y SET del ROL
  static String get rol => _box.read<String>('rol') ?? '';
  static set rol(String value) => _box.write('rol', value);
  
  //-- GET Y SET del tokenDeAcceso
  static String get tokenDeAcceso => _box.read<String>('tokenDeAcceso') ?? '';
  static set tokenDeAcceso(String value) =>  _box.write('tokenDeAcceso', value);
  
  //-- GET Y SET del tokenDeRefresco
  static String get tokenDeRefresco => _box.read<String>('tokenDeRefresco') ?? '';
  static set tokenDeRefresco(String value) => _box.write('tokenDeRefresco', value);

  //-- GET Y SET del tokenDeRefresco
  static String get tokenMobile => _box.read<String>('tokenMobile') ?? '';
  static set tokenMobile(String value) => _box.write('tokenMobile', value);
  
  //-- GET Y SET del cambiarPassword
  static bool get cambiarPassword => _box.read<bool>('cambiarPassword') ?? false;
  static set cambiarPassword(bool value) => _box.write('cambiarPassword', value);

  //-- GET Y SET del abrirNotificaciones
  static bool get abrirNotificaciones => _box.read<bool>('abrirNotificaciones') ?? false;
  static set abrirNotificaciones(bool value) => _box.write('abrirNotificaciones', value);

  //-- GET Y SET del lastError
  static String get lastError => _box.read<String>('lastError') ?? '';
  static set lastError(String value) => _box.write('lastError', value);

  //-- GET Y SET del latitud
  static double get latitud => _box.read<double>('latitud') ?? 0;
  static set latitud(double value) => _box.write('latitud', value);

  //-- GET Y SET del longitud
  static double get longitud => _box.read<double>('longitud') ?? 0;
  static set longitud(double value) => _box.write('longitud', value);

  //-- GET Y SET del localidad
  static String get localidad => _box.read<String>('localidad') ?? '';
  static set localidad(String value) => _box.write('localidad', value);

  //-- GET Y SET del cp
  static String get cp => _box.read<String>('cp') ?? '';
  static set cp(String value) => _box.write('cp', value);

  //-- GET Y SET del pais
  static String get pais => _box.read<String>('pais') ?? '';
  static set pais(String value) => _box.write('pais', value);
  
  //-- GET Y SET del isFirstTime
  static bool get isFirstTime => _box.read<bool>('isFirstTime') ?? true;
  static set isFirstTime(bool value) => _box.write('isFirstTime', value);
  
  //-- GET Y SET del aceptoTYC
  static bool get aceptoTYC => _box.read<bool>('aceptoTYC') ?? false;
  static set aceptoTYC(bool value) => _box.write('aceptoTYC', value);

  //-- GET Y SET del solicitudDeAdelanto
  static bool get showSolicitudDeAdelantos => _box.read<bool>('showSolicitudDeAdelantos') ?? false;
  static set showSolicitudDeAdelantos(bool value) => _box.write('showSolicitudDeAdelantos', value);

  //-- v4.0 
  //-- GET Y SET del verTodasLasCCEnComprobantesPendientes
  static bool get verTodasLasCCEnComprobantesPendientes => _box.read<bool>('verTodasLasCCEnComprobantesPendientes') ?? false;
  static set verTodasLasCCEnComprobantesPendientes(bool value) => _box.write('verTodasLasCCEnComprobantesPendientes', value);
  
  //-- GET Y SET del showColDolaresEnRepCompPendientes
  static bool get showColDolaresEnRepCompPendientes => _box.read<bool>('showColDolaresEnRepCompPendientes') ?? false;
  static set showColDolaresEnRepCompPendientes(bool value) => _box.write('showColDolaresEnRepCompPendientes', value);

  //-- v4.1
  //-- GET Y SET del enviarUbicacion
  static bool get enviarUbicacion => _box.read<bool>('enviarUbicacion') ?? false;
  static set enviarUbicacion(bool value) => _box.write('enviarUbicacion', value);
  
  static PreferenciasUsuario getData() {
    return PreferenciasUsuario(
      apellido: apellido,
      nombre: nombre,
      email: email,
      rol: rol,
      //-- Seguridad
      tokenDeAcceso: tokenDeAcceso,
      tokenDeRefresco: tokenDeRefresco,
      cambiarPassword: cambiarPassword,
      //-- Push
      tokenMobile: tokenMobile,
      abrirNotificaciones: abrirNotificaciones,
      //-- Last Error
      lastError: lastError,
      latitud: latitud,
      longitud: longitud,
      localidad: localidad,
      cp: cp,
      pais: pais,
      showSolicitudDeAdelantos: showSolicitudDeAdelantos, 
    );
  }

  static saveData(Map<String, dynamic> pref) {
    /*
      SI EL MAPA TRAE MAS PROPIEDADES LAS IGNORA YA QUE PISA 
      SOLO LAS PROPIEDADES DE LA CLASE PreferenciasUsuario
    */
    Map<String, dynamic> template = PreferenciasUsuario().toJson();

    pref.forEach((key, value) {
      if (template.containsKey(key)) {
        //print('${key.toString()} - ${value.toString()}');
        _box.write(key, value);
      }
    });
  }

  static inicializar(Map<String, dynamic> pref) async {
    await GetStorage.init();

    //! CREO LAS PROPIEDADES A ALMACENAR SI NO EXISTEN
    pref.forEach((key, value) {
      _box.writeIfNull(key, value);
    });
  }
}
