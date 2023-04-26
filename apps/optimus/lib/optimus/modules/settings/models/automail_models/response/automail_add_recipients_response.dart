
import 'dart:convert';

AutomailAddRecipientsResponse automailAddRecipientsResponseFromJson(String str) => AutomailAddRecipientsResponse.fromJson(json.decode(str));

String automailAddRecipientsResponseToJson(AutomailAddRecipientsResponse data) => json.encode(data.toJson());

class AutomailAddRecipientsResponse {
  AutomailAddRecipientsResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory AutomailAddRecipientsResponse.fromJson(Map<String, dynamic> json) => AutomailAddRecipientsResponse(
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
    required this.settingId,
    required this.supplierId,
    required this.recipientType,
    required this.createdBy,
    required this.isEnable,
    required this.createdAt,
    required this.updatedAt,
    required this.receipts,
  });

  int id;
  int settingId;
  String supplierId;
  String recipientType;
  String createdBy;
  bool isEnable;
  DateTime createdAt;
  DateTime updatedAt;
  List<Receipt> receipts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    settingId: json["setting_id"],
    supplierId: json["supplier_id"],
    recipientType: json["recipient_type"],
    createdBy: json["created_by"],
    isEnable: json["is_enable"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    receipts: List<Receipt>.from(json["recipients"].map((x) => Receipt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "setting_id": settingId,
    "supplier_id": supplierId,
    "recipient_type": recipientType,
    "created_by": createdBy,
    "is_enable": isEnable,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "recipients": List<dynamic>.from(receipts.map((x) => x.toJson())),
  };
}

class Receipt {
  Receipt({
    required this.id,
    required this.settingAutoMailId,
    required this.email,
    required this.createdBy,
    required this.isEnable,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int settingAutoMailId;
  String email;
  String createdBy;
  bool isEnable;
  DateTime createdAt;
  DateTime updatedAt;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    id: json["id"],
    settingAutoMailId: json["setting_auto_mail_id"],
    email: json["email"],
    createdBy: json["created_by"],
    isEnable: json["is_enable"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "setting_auto_mail_id": settingAutoMailId,
    "email": email,
    "created_by": createdBy,
    "is_enable": isEnable,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
