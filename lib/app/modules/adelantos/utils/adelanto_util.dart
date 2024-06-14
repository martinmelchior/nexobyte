import 'package:flutter/material.dart';



class AdelantoUtils {

  static Color getBackColorEstadoAdelanto(String estado) {

    Color returnValue = Colors.black;
    if (estado.toUpperCase() == "PENDIENTE") {
      returnValue = const Color(0xFF2dcebd);
    } else if (estado.toUpperCase() == "RECHAZADA") {
      returnValue = const Color(0xFFdc3545);
    } else if (estado.toUpperCase() == "APROBADA") {
      returnValue = const Color(0xFF3baa47);
    } else if (estado.toUpperCase() == "REALIZADA") {
      returnValue = const Color(0xff6887b4);
    }
    else
    {
      returnValue = Colors.black;
    }
    return returnValue;
  }

  
}

