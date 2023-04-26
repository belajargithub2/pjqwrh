import 'dart:convert';

AutomailEnableResponse automailRecipientsEnablerResponseFromJson(String str) =>
    AutomailEnableResponse.fromJson(json.decode(str));

String automailRecipientsEnablerResponseToJson(AutomailEnableResponse data) =>
    json.encode(data.toJson());

class AutomailEnableResponse {
  AutomailEnableResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory AutomailEnableResponse.fromJson(Map<String, dynamic> json) =>
      AutomailEnableResponse(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.recipientType,
    required this.supplierId,
    required this.isEnable,
  });

  int id;
  String recipientType;
  String? supplierId;
  bool isEnable;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        recipientType: json["recipient_type"],
        supplierId: json["supplier_id"] ?? '',
        isEnable: json["is_enable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipient_type": recipientType,
        "supplier_id": supplierId,
        "is_enable": isEnable,
      };
}
