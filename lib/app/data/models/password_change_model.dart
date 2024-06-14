import 'dart:convert';
import 'package:flutter/material.dart';


//!-------------------------------------------------------------- ResponseGeneral
class PasswordChangeResponse {
  
    PasswordChangeResponse({
        @required this.tokenDeAcceso,
        @required this.tokenDeRefresco,
        @required this.cambiarPassword,
    });

    
    final String? tokenDeAcceso;
    final String? tokenDeRefresco;
    final bool? cambiarPassword;

    factory PasswordChangeResponse.fromRawJson(String str) => PasswordChangeResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PasswordChangeResponse.fromJson(Map<String, dynamic> json) => PasswordChangeResponse(
        cambiarPassword : json["cambiarPassword"], 
        tokenDeAcceso   : json["tokenDeAcceso"],
        tokenDeRefresco : json["tokenDeRefresco"],
    );

    Map<String, dynamic> toJson() => {
        "cambiarPassword" : cambiarPassword,
        "tokenDeAcceso"   : tokenDeAcceso,
        "tokenDeRefresco" : tokenDeRefresco,
    };
}
