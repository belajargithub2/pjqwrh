import 'dart:convert';

HumanVerificationResponse humanVerificationResponseFromJson(String str) => HumanVerificationResponse.fromJson(json.decode(str));

String humanVerificationResponseToJson(HumanVerificationResponse data) => json.encode(data.toJson());

class HumanVerificationResponse {
  HumanVerificationResponse({
    this.messages,
    this.data,
    this.errors,
    this.code,
  });

  String? messages;
  Data? data;
  dynamic errors;
  int? code;

  factory HumanVerificationResponse.fromJson(Map<String, dynamic> json) => HumanVerificationResponse(
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
    this.customerId,
    this.requestId,
    this.result,
    this.reason,
  });

  int? customerId;
  String? requestId;
  String? result;
  String? reason;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerId: json["customer_id"],
    requestId: json["request_id"],
    result: json["result"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "customer_id": customerId,
    "request_id": requestId,
    "result": result,
    "reason": reason,
  };
}
