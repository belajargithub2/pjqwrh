import 'dart:convert';

AutomailAddRecipientsRequest automailAddRecipientsRequestFromJson(String str) =>
    AutomailAddRecipientsRequest.fromJson(json.decode(str));

String automailAddRecipientsRequestToJson(AutomailAddRecipientsRequest data) =>
    json.encode(data.toJson());

class AutomailAddRecipientsRequest {
  AutomailAddRecipientsRequest({
    required this.supplierId,
    required this.recipientType,
    required this.receipts,
  });

  String supplierId;
  String recipientType;
  List<RecipientRequest> receipts;

  factory AutomailAddRecipientsRequest.fromJson(Map<String, dynamic> json) =>
      AutomailAddRecipientsRequest(
        supplierId: json["supplier_id"],
        recipientType: json["recipient_type"],
        receipts: List<RecipientRequest>.from(
            json["recipients"].map((x) => RecipientRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "supplier_id": supplierId,
        "recipient_type": recipientType,
        "recipients": List<dynamic>.from(receipts.map((x) => x.toJson())),
      };
}

class RecipientRequest {
  RecipientRequest({
    required this.email,
  });

  String email;

  factory RecipientRequest.fromJson(Map<String, dynamic> json) => RecipientRequest(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
