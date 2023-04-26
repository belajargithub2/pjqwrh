import 'dart:convert';

ResponseGenerateProspectIdAgent responseGenerateProspectIdAgentFromJson(String str) => ResponseGenerateProspectIdAgent.fromJson(json.decode(str));

String responseGenerateProspectIdAgentToJson(ResponseGenerateProspectIdAgent data) => json.encode(data.toJson());

class ResponseGenerateProspectIdAgent {
  ResponseGenerateProspectIdAgent({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  DataProspectIdAgent? data;

  factory ResponseGenerateProspectIdAgent.fromJson(Map<String, dynamic> json) => ResponseGenerateProspectIdAgent(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DataProspectIdAgent.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class DataProspectIdAgent {
  DataProspectIdAgent({
    this.prospectId,
    this.createdAt,
  });

  String? prospectId;
  DateTime? createdAt;

  factory DataProspectIdAgent.fromJson(Map<String, dynamic> json) => DataProspectIdAgent(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}
