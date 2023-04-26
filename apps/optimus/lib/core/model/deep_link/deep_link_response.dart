import 'dart:convert';

DeepLinkResponse deepLinkResponseFromJson(String str) => DeepLinkResponse.fromJson(json.decode(str));

String deepLinkResponseToJson(DeepLinkResponse data) => json.encode(data.toJson());

class DeepLinkResponse {
  DeepLinkResponse({
    this.shortLink,
    this.warning,
    this.previewLink,
  });

  String? shortLink;
  List<Warning>? warning;
  String? previewLink;

  factory DeepLinkResponse.fromJson(Map<String, dynamic> json) => DeepLinkResponse(
    shortLink: json["shortLink"] == null ? null : json["shortLink"],
    warning: json["warning"] == null ? null : List<Warning>.from(json["warning"].map((x) => Warning.fromJson(x))),
    previewLink: json["previewLink"] == null ? null : json["previewLink"],
  );

  Map<String, dynamic> toJson() => {
    "shortLink": shortLink == null ? null : shortLink,
    "warning": warning == null ? null : List<dynamic>.from(warning!.map((x) => x.toJson())),
    "previewLink": previewLink == null ? null : previewLink,
  };
}

class Warning {
  Warning({
    this.warningCode,
    this.warningMessage,
  });

  String? warningCode;
  String? warningMessage;

  factory Warning.fromJson(Map<String, dynamic> json) => Warning(
    warningCode: json["warningCode"] == null ? null : json["warningCode"],
    warningMessage: json["warningMessage"] == null ? null : json["warningMessage"],
  );

  Map<String, dynamic> toJson() => {
    "warningCode": warningCode == null ? null : warningCode,
    "warningMessage": warningMessage == null ? null : warningMessage,
  };
}
