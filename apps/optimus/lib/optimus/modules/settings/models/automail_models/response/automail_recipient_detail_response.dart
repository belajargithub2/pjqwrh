
import 'dart:convert';

AutomailRecipientDetailResponse automailReceiptDetailResponseFromJson(String str) => AutomailRecipientDetailResponse.fromJson(json.decode(str));

String automailReceiptDetailResponseToJson(AutomailRecipientDetailResponse data) => json.encode(data.toJson());

class AutomailRecipientDetailResponse {
  AutomailRecipientDetailResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  int code;
  String message;
  Data data;

  factory AutomailRecipientDetailResponse.fromJson(Map<String, dynamic> json) => AutomailRecipientDetailResponse(
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
    required this.isEnable,
    required this.recipients,
  });


  int id;
  int settingId;
  dynamic supplierId;
  String recipientType;
  bool isEnable;
  List<Receipt> recipients;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    settingId: json["setting_id"],
    supplierId: json["supplier_id"] ==  null ? '' : json["supplier_id"] ,
    recipientType: json["recipient_type"],
    isEnable: json["is_enable"],
    recipients: List<Receipt>.from(json["recipients"].map((x) => Receipt.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "setting_id": settingId,
    "supplier_id": supplierId,
    "recipient_type": recipientType,
    "is_enable": isEnable,
    "recipients": List<dynamic>.from(recipients.map((x) => x.toJson())),
  };
}

class Receipt {
  Receipt({
    required this.id,
    required this.email,
    required this.isEnable,
  });

  int id;
  String email;
  bool isEnable;

  factory Receipt.fromJson(Map<String, dynamic> json) => Receipt(
    id: json["id"],
    email: json["email"],
    isEnable: json["is_enable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "is_enable": isEnable,
  };
}
