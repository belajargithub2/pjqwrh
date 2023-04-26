
import 'dart:convert';

AutomailEnableRequest automailEnableRequestFromJson(String str) => AutomailEnableRequest.fromJson(json.decode(str));

String automailEnableRequestToJson(AutomailEnableRequest data) => json.encode(data.toJson());

class AutomailEnableRequest {
  AutomailEnableRequest({
    required this.id,
    required this.isEnable,
  });

  int id;
  bool isEnable;

  factory AutomailEnableRequest.fromJson(Map<String, dynamic> json) => AutomailEnableRequest(
    id: json["id"],
    isEnable: json["is_enable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_enable": isEnable,
  };
}
