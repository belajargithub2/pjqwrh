import 'dart:convert';

GenerateProspectIdResponse generateProspectIdResponseFromJson(String str) => GenerateProspectIdResponse.fromJson(json.decode(str));

String generateProspectIdResponseToJson(GenerateProspectIdResponse data) => json.encode(data.toJson());

class GenerateProspectIdResponse {
  GenerateProspectIdResponse({
    this.messages,
    this.data,
    this.errors,
    this.code,
  });

  String? messages;
  Data? data;
  dynamic errors;
  String? code;

  factory GenerateProspectIdResponse.fromJson(Map<String, dynamic> json) => GenerateProspectIdResponse(
    messages: json["messages"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
    "data": data?.toJson(),
    "errors": errors,
    "code": code,
  };
}

class Data {
  Data({
    this.orderId,
  });

  String? orderId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
