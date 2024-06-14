
//!-------------------------------------------------------------- PasswordRecoveryRequest
class PasswordRecoveryRequest {

    PasswordRecoveryRequest({
        this.email
    });

    String? email;

    factory PasswordRecoveryRequest.fromJson(Map<String, dynamic> json) => PasswordRecoveryRequest(
      email: json["email"]
    );

    Map<String, dynamic> toJson() => {
      "email": email,
    };
}


//!-------------------------------------------------------------- PasswordRecoveryResponse
class PasswordRecoveryResponse {
  
    PasswordRecoveryResponse({
        this.mensaje = '',
    });

    final String mensaje;

    factory PasswordRecoveryResponse.fromJson(Map<String, dynamic> json) => PasswordRecoveryResponse(
        mensaje: json["mensaje"],
    );

    Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
    };
}
