import 'dart:convert';

ConfirmationMethodListResponse merchantListResponseFromJson(String str) => ConfirmationMethodListResponse.fromJson(json.decode(str));

String merchantListResponseToJson(ConfirmationMethodListResponse data) => json.encode(data.toJson());

class ConfirmationMethodListResponse {
  ConfirmationMethodListResponse({
    this.confirmationMethods,
    this.message
  });

  List<ConfirmationMethodsData>? confirmationMethods;
  String? message;

  factory ConfirmationMethodListResponse.fromJson(Map<String, dynamic> json) => ConfirmationMethodListResponse(
    message: json["message"] == null ? null : json["message"],
    confirmationMethods: json["data"] == null ? null :
      List<ConfirmationMethodsData>.from(json["data"].map((x) => ConfirmationMethodsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": confirmationMethods == null ? null : List<dynamic>.from(confirmationMethods!.map((x) => x.toJson())),
  };
}

class ConfirmationMethodsData {
  ConfirmationMethodsData({
    this.id,
    this.text,
  });

  String? id;
  String? text;

  factory ConfirmationMethodsData.fromJson(Map<String, dynamic> json) => ConfirmationMethodsData(
    id: json["id"] == null ? null : json["id"],
    text: json["text"] == null ? null : json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "text": text == null ? null : text,
  };
}