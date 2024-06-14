

//!-------------------------------------------------------------- GetVersionsResponse
//-- ADD 2.1
class GetVersionsResponse {
  
    final String? versionAndroid;
    final String? urlGooglePlay;
    final String? versionIos;
    final String? urlAppleStore;

    GetVersionsResponse({
      this.versionAndroid,
      this.urlGooglePlay,
      this.versionIos,
      this.urlAppleStore,
    });

    factory GetVersionsResponse.fromJson(Map<String, dynamic> json) => GetVersionsResponse(
      versionAndroid:   json["versionAndroid"] ?? '1.0.0',
      urlGooglePlay:    json["urlGooglePlay"] ?? '',
      versionIos:       json["versionIos"] ?? '1.0.0',
      urlAppleStore:    json["urlAppleStore"] ?? '',
    );

    Map<String, dynamic> toJson() => {
      "versionAndroid":   versionAndroid,
      "urlGooglePlay":    urlGooglePlay,
      "versionIos":       versionIos,
      "urlAppleStore":    urlAppleStore,
    };
}
