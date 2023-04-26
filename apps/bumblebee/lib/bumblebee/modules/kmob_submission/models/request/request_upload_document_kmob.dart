import 'dart:convert';

RequestUplaodDocumentKmob requestUplaodDocumentKmobFromJson(String str) => RequestUplaodDocumentKmob.fromJson(json.decode(str));

String requestUplaodDocumentKmobToJson(RequestUplaodDocumentKmob data) => json.encode(data.toJson());

class RequestUplaodDocumentKmob {
  RequestUplaodDocumentKmob({
    this.prospectId,
    this.documentType,
  });

  String? prospectId;
  String? documentType;

  factory RequestUplaodDocumentKmob.fromJson(Map<String, dynamic> json) => RequestUplaodDocumentKmob(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    documentType: json["document_type"] == null ? null : json["document_type"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "document_type": documentType == null ? null : documentType,
  };
}
