//!-------------------------------------------------------------- TyCRequest
class TyCRequest {

    TyCRequest({
        this.tokenDeRefresco
    });

    String? tokenDeRefresco;
    
    factory TyCRequest.fromJson(Map<String, dynamic> json) => TyCRequest(
      tokenDeRefresco     : json["tokenDeRefresco"],
    );

    Map<String, dynamic> toJson() => {
      "tokenDeRefresco"   : tokenDeRefresco,
    };
}


//!-------------------------------------------------------------- TyCResponse
class TyCResponse {
  
    final String? terminosYCondiciones;

    TyCResponse({
      this.terminosYCondiciones,
    });

    factory TyCResponse.fromJson(Map<String, dynamic> json) => TyCResponse(
      terminosYCondiciones     : json["terminosYCondiciones"],
    );

    Map<String, dynamic> toJson() => {
      "terminosYCondiciones"   : terminosYCondiciones,
    };
}

//!-------------------------------------------------------------- AceptoTyCResponse
class AceptoTyCResponse {
  
    final bool aceptoTyC;

    AceptoTyCResponse({
      this.aceptoTyC = true,
    });

    factory AceptoTyCResponse.fromJson(Map<String, dynamic> json) => AceptoTyCResponse(
      aceptoTyC     : json["aceptoTyC"],
    );

    Map<String, dynamic> toJson() => {
      "aceptoTyC"   : aceptoTyC,
    };
}