import 'dart:convert';

import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_add_recipients_request.dart';

AutomailUpdateRecipientsRequest automailUpdateRecipientsRequestFromJson(
        String str) =>
    AutomailUpdateRecipientsRequest.fromJson(json.decode(str));

String automailUpdateRecipientsRequestToJson(
        AutomailUpdateRecipientsRequest data) =>
    json.encode(data.toJson());

class AutomailUpdateRecipientsRequest {
  AutomailUpdateRecipientsRequest({
    required this.id,
    required this.supplierId,
    required this.recipientType,
    required this.receipts,
  });

  int id;
  String supplierId;
  String recipientType;
  List<RecipientRequest> receipts;

  factory AutomailUpdateRecipientsRequest.fromJson(Map<String, dynamic> json) =>
      AutomailUpdateRecipientsRequest(
        id: json["id"],
        supplierId: json["supplier_id"],
        recipientType: json["recipient_type"],
        receipts: List<RecipientRequest>.from(
            json["recipients"].map((x) => RecipientRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "recipient_type": recipientType,
        "recipients": List<dynamic>.from(receipts.map((x) => x.toJson())),
      };
}

// class Recipients {
//   Recipients({
//     required this.email,
//   });
//
//   String email;
//
//   factory Recipients.fromJson(Map<String, dynamic> json) => Recipients(
//         email: json["email"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "email": email,
//       };
// }
