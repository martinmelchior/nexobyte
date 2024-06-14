
import 'dart:convert';

//!-------------------------------------------------------------- UbicacionRequest
class UbicacionRequest {

    final String tokenDeRefresco;
    final String latitud;
    final String longitud;

    UbicacionRequest({
        required this.tokenDeRefresco,
        required this.latitud,
        required this.longitud,
    });

    factory UbicacionRequest.fromJson(Map<String, dynamic> json) => UbicacionRequest(
      tokenDeRefresco:  json["tokenDeRefresco"],
      latitud:          json["latitud"],
      longitud:         json["longitud"],
    );

    Map<String, dynamic> toJson() => {
      "tokenDeRefresco":  tokenDeRefresco,
      "latitud":          latitud,
      "longitud":         longitud,
    };
}


//!-------------------------------------------------------------- UbicacionResponse
class UbicacionResponse {
  
    final bool result;

    UbicacionResponse({
      this.result = false,
    });

    factory UbicacionResponse.fromRawJson(String str) => UbicacionResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UbicacionResponse.fromJson(Map<String, dynamic> json) => UbicacionResponse(
      result: json["result"] ?? false,   
    );

    Map<String, dynamic> toJson() => {
      "result": result,
    };
}
