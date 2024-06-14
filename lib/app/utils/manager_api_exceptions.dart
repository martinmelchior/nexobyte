import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexobyte/app/constants.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';
import 'package:nexobyte/app/theme/app_theme.dart';

class ApiExceptions {
  static void procesarError(dynamic error, [bool showInDialog = true]) async {
    final String intentoConEmail =
        "\n\nIntente nuevamente en algunos segundos, si el error persiste envíenos un email a " +
            Constants.kEmailSoporte;

    String _networkExceptions = '';

    //* Dejo guardado el ultimo error para ver si me ayuda a saber lo que pasa mas alla del error normal que mostramos
    PreferenciasDeUsuarioStorage.lastError = error.toString();

    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              _networkExceptions = "Requerimiento cancelado!" + intentoConEmail;
              break;
            case DioErrorType.connectTimeout:
              _networkExceptions =
                  "Error de tiempo de espera del servidor!" + intentoConEmail;
              break;
            case DioErrorType.other:
              _networkExceptions =
                  "Por favor verifique si tiene conexión a internet!";
              break;
            case DioErrorType.receiveTimeout:
              _networkExceptions =
                  "Error de tiempo de espera del servidor!" + intentoConEmail;
              break;
            case DioErrorType.response:
              try {
                //! Si es un 404 por ejemplo no viene un map y esta linea da error
                //! con los errores devueltos de la API si viene un MAP
                Map mapError = json.decode(error.response.toString());
                _networkExceptions = mapError["Message"];
              } catch (e) {}

              if (_networkExceptions == '') {
                switch (error.response?.statusCode) {
                  case 400:
                  case 401:
                  case 403:
                    _networkExceptions = "No autorizado!";
                    break;
                  case 404:
                    _networkExceptions =
                        "Recurso no encontrado!" + intentoConEmail;
                    break;
                  case 409:
                    _networkExceptions =
                        "Error de conflicto!" + intentoConEmail;
                    break;
                  case 408:
                    _networkExceptions =
                        "Error de tiempo de espera del servidor!" +
                            intentoConEmail;
                    break;
                  case 500:
                  case 503:
                    //* PASA CUANDO NO ESTA LEVANTADO EL SITIO!
                    //* TAMBIEN CUANDO EL TELEFONO NO TIENE INTERNET O ESTA EN MODO AVION
                    _networkExceptions =
                        "Servidor no disponible. Por favor verifique su conexión a internet e intente nuevamente!";
                    break;
                  default:
                    var responseCode = error.response?.statusCode;
                    _networkExceptions =
                        "Código de error inválido ($responseCode)!" +
                            intentoConEmail;
                }
              }
              break;
            case DioErrorType.sendTimeout:
              _networkExceptions =
                  "Error de tiempo de espera de API!" + intentoConEmail;
              break;
          }
        } else if (error is SocketException) {
          _networkExceptions =
              "Por favor verifique si tiene conexión a internet!";
        } else {
          _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
        }
      } on FormatException {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      } catch (_) {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        _networkExceptions = "No es posible procesar su requerimiento!";
      } else {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      }
    }

    String titulo = 'ERROR ';
    String er = '';

    //! Pasa por aca por ejemplo si al urlApi esta vacía !!
    if (error.response != null) {
      er = error.response.toString();
    }
    if (Constants.isTesting && er != '') {
      titulo += error.response.statusCode.toString();
    }

    List<Widget> lActions = [];
    //if (_networkExceptions.contains("(E10)")) lActions.add(TextButton(child: Text("Olvidé mi Contraseña"), onPressed: () { Get.offAllNamed(AppRoutes.RECOVERY_PASSWORD); }));
    //if (_networkExceptions.contains("(E22)")) lActions.add(TextButton(child: Text("Cambiar mi Contraseña"), onPressed: () { Get.offAllNamed(AppRoutes.CHANGE_PASSWORD); }));
    //if (_networkExceptions.contains("(E99)")) lActions.add(TextButton(child: Text("Ingresar nuevamente"), onPressed: () { Get.offAllNamed(AppRoutes.LOGIN); }));

    lActions.add(TextButton(
        child: const Text("Cerrar"),
        onPressed: () {
          Get.back();
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(kTLightPrimaryColor),
        )));

    if (showInDialog) {
      await Get.dialog(
        AlertDialog(
          title: Text(titulo, style: const TextStyle(color: kTRedColor)),
          content: Text(_networkExceptions, style: const TextStyle(color: kErrorTextColor)),
          actions: lActions,
        ),
        barrierDismissible: false,
        //useRootNavigator: true,
      );
    } else {
      Get.snackbar(
        titulo,
        _networkExceptions,
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        icon: const Icon(Icons.error, color: kErrorTextColor),
        backgroundColor: kErrorBackColor,
        colorText: kErrorTextColor,
        borderRadius: 0.0,
        margin: const EdgeInsets.all(0),
        isDismissible: false,
      );
    }
  }

  static String getCustomError(dynamic error) {
    final String intentoConEmail =
        "\n\nIntente nuevamente, si el error persiste envíenos un email a " +
            Constants.kEmailSoporte;

    String _networkExceptions = 'Ooops, ocurrió un error !';

    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              _networkExceptions = "Requerimiento cancelado!" + intentoConEmail;
              break;
            case DioErrorType.connectTimeout:
              _networkExceptions =
                  "Error de tiempo de espera del servidor!" + intentoConEmail;
              break;
            case DioErrorType.other:
              _networkExceptions =
                  "Por favor verifique si tiene conexión a internet!";
              break;
            case DioErrorType.receiveTimeout:
              _networkExceptions =
                  "Error de tiempo de espera del servidor!" + intentoConEmail;
              break;
            case DioErrorType.response:
              try {
                //! Si es un 404 por ejemplo no viene un map y esta linea da error
                //! con los errores devueltos de la API si viene un MAP
                Map mapError = json.decode(error.response.toString());
                _networkExceptions = mapError["Message"];
              } catch (e) {}

              if (_networkExceptions == '') {
                switch (error.response?.statusCode) {
                  case 400:
                  case 401:
                  case 403:
                    _networkExceptions = "No autorizado!";
                    break;
                  case 404:
                    _networkExceptions =
                        "Recurso no encontrado!" + intentoConEmail;
                    break;
                  case 409:
                    _networkExceptions =
                        "Error de conflicto!" + intentoConEmail;
                    break;
                  case 408:
                    _networkExceptions =
                        "Error de tiempo de espera del servidor!" +
                            intentoConEmail;
                    break;
                  case 500:
                  case 503:
                    //* PASA CUANDO NO ESTA LEVANTADO EL SITIO!
                    //* TAMBIEN CUANDO EL TELEFONO NO TIENE INTERNET O ESTA EN MODO AVION
                    _networkExceptions =
                        "Servidor no disponible. Por favor verifique su conexión a internet e intente nuevamente!";
                    break;
                  default:
                    var responseCode = error.response?.statusCode;
                    _networkExceptions =
                        "Código de error inválido ($responseCode)!" +
                            intentoConEmail;
                }
              }
              break;
            case DioErrorType.sendTimeout:
              _networkExceptions =
                  "Error de tiempo de espera de API!" + intentoConEmail;
              break;
          }
        } else if (error is SocketException) {
          _networkExceptions =
              "Por favor verifique si tiene conexión a internet!";
        } else {
          _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
        }
      } on FormatException {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      } catch (_) {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        _networkExceptions = "No es posible procesar su requerimiento!";
      } else {
        _networkExceptions = "Ocurrió un error inesperado!" + intentoConEmail;
      }
    }

    return _networkExceptions;
  }
}
