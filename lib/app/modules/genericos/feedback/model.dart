
//*---------------------------------------------------------------------------  SaveFeedbackRequest
class EnviarFeedbackRequest {
  
  String tokenDeRefresco;
  String tipo;
  String mensaje;
 
  EnviarFeedbackRequest({
    this.tokenDeRefresco = '',
    this.tipo = '',
    this.mensaje = '',
  });
}

//*---------------------------------------------------------------------------  EAResourcesResponse
class EnviarFeedbackResponse {
  
  String tokenDeRefresco;
 
  EnviarFeedbackResponse({
    this.tokenDeRefresco = '',
  });

  factory EnviarFeedbackResponse.fromJson(Map json) => EnviarFeedbackResponse(
    tokenDeRefresco:  json["tokenDeRefresco"],
  );

  Map<String, dynamic> toJson() => {
    "tokenDeRefresco":  tokenDeRefresco,
  };
}