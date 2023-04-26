
import 'dart:convert';

AutomailRecipientType automailrecipientTypeFromJson(String str) => AutomailRecipientType.fromJson(json.decode(str));

String automailrecipientTypeToJson(AutomailRecipientType data) => json.encode(data.toJson());

class AutomailRecipientType {
  AutomailRecipientType({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  List<RecipentType> data;

  factory AutomailRecipientType.fromJson(Map<String, dynamic> json) => AutomailRecipientType(
    code: json["code"],
    message: json["message"],
    data: List<RecipentType>.from(json["data"].map((x) => RecipentType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class RecipentType {
  RecipentType({
    required this.id,
    required this.text,
  });

  String id;
  String text;

  factory RecipentType.fromJson(Map<String, dynamic> json) => RecipentType(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };
}
