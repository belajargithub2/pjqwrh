import 'dart:convert';

RequestGenerateProspectIdAgent requestGenerateProspectIdAgentFromJson(String str) => RequestGenerateProspectIdAgent.fromJson(json.decode(str));

String requestGenerateProspectIdAgentToJson(RequestGenerateProspectIdAgent data) => json.encode(data.toJson());

class RequestGenerateProspectIdAgent {
  RequestGenerateProspectIdAgent({
    this.branchId,
    this.lobType,
  });

  String? branchId;
  String? lobType;

  factory RequestGenerateProspectIdAgent.fromJson(Map<String, dynamic> json) => RequestGenerateProspectIdAgent(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    lobType: json["lob_type"] == null ? null : json["lob_type"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId == null ? null : branchId,
    "lob_type": lobType == null ? null : lobType,
  };
}
