
import 'dart:convert';

//!-------------------------------------------------------------- LoginRequest
class LoginRequest {

    LoginRequest({
        this.email,
        this.password
    });

    String? email;
    String? password;

    factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
      email     : json["email"],
      password  : json["password"],
    );

    Map<String, dynamic> toJson() => {
      "email"   : email,
      "password": password,
    };
}


//!-------------------------------------------------------------- LoginResponse
class LoginResponse {
  
    final String? apellido;
    final String? nombre;
    final String? email;
    final String? rol;
    final bool? cambiarPassword;
    final String? tokenDeAcceso;
    final String? tokenDeRefresco;

    LoginResponse({
      this.apellido,
      this.nombre,
      this.email,
      this.rol,
      this.cambiarPassword,
      this.tokenDeAcceso,
      this.tokenDeRefresco,
    });

    factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      apellido                    : json["apellido"],
      nombre                      : json["nombre"],
      email                       : json["email"],
      rol                         : json["rol"],
      cambiarPassword             : json["cambiarPassword"], 
      tokenDeAcceso               : json["tokenDeAcceso"],
      tokenDeRefresco             : json["tokenDeRefresco"],
    );

    Map<String, dynamic> toJson() => {
      "apellido"                    : apellido,
      "nombre"                      : nombre,
      "email"                       : email,
      "rol"                         : rol,
      "cambiarPassword"             : cambiarPassword,
      "tokenDeAcceso"               : tokenDeAcceso,
      "tokenDeRefresco"             : tokenDeRefresco,
    };
}
