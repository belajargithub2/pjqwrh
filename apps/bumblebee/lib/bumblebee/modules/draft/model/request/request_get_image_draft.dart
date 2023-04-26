import 'dart:convert';

RequestGetImageDraft requestGetImageDraftFromJson(String str) => RequestGetImageDraft.fromJson(json.decode(str));

String requestGetImageDraftToJson(RequestGetImageDraft data) => json.encode(data.toJson());

class RequestGetImageDraft {
  RequestGetImageDraft({
    this.prospectId,
    this.documentType,
    this.photoUrl,
  });

  String? prospectId;
  String? documentType;
  String? photoUrl;

  factory RequestGetImageDraft.fromJson(Map<String, dynamic> json) => RequestGetImageDraft(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    documentType: json["document_type"] == null ? null : json["document_type"],
    photoUrl: json["photo_url"] == null ? null : json["photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "document_type": documentType == null ? null : documentType,
    "photo_url": photoUrl == null ? null : photoUrl,
  };
}
