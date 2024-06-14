//-- v4.0
//*-------------------------------------------------------------- FileDataXlsPdfResponse
class FileDataXlsPdfResponse {
  
  String? link;
  String? fileName;
  String? linkPdf;
  String? fileNamePdf;

  FileDataXlsPdfResponse({
    this.link,
    this.fileName,
    this.linkPdf,
    this.fileNamePdf,
  });

  factory FileDataXlsPdfResponse.fromJson(Map json) => FileDataXlsPdfResponse(
    link:         json["link"] ?? '',
    fileName:     json["fileName"] ?? '',
    linkPdf:      json["linkPdf"] ?? '',
    fileNamePdf:  json["fileNamePdf"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "link":           link,
    "fileName":       fileName,
    "linkPdf":        linkPdf,
    "fileNamePdf":    fileNamePdf,
  };
}