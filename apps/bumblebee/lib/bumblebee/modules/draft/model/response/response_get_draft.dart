import 'dart:convert';

ResponseGetDrafts responseGetListDraftFromJson(String str) => ResponseGetDrafts.fromJson(json.decode(str));

String responseGetListDraftToJson(ResponseGetDrafts data) => json.encode(data.toJson());

class ResponseGetDrafts {
  ResponseGetDrafts({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<DataDraft>? data;

  factory ResponseGetDrafts.fromJson(Map<String, dynamic> json) => ResponseGetDrafts(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DataDraft>.from(json["data"].map((x) => DataDraft.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataDraft {
  DataDraft({
    this.prospectId,
    this.customerName,
    this.orderDate,
    this.legalName,
    this.agentId,
    this.orderStatus,
  });

  String? prospectId;
  String? customerName;
  DateTime? orderDate;
  String? legalName;
  int? agentId;
  String? orderStatus;

  factory DataDraft.fromJson(Map<String, dynamic> json) => DataDraft(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    legalName: json["legal_name"] == null ? null : json["legal_name"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    orderStatus: json["order_status"] == null ? null : json["order_status"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "customer_name": customerName == null ? null : customerName,
    "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
    "legal_name": legalName == null ? null : legalName,
    "agent_id": agentId == null ? null : agentId,
    "order_status": orderStatus == null ? null : orderStatus,
  };
}
