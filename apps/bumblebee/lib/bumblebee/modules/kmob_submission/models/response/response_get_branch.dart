// To parse this JSON data, do
//
//     final responseGetBranch = responseGetBranchFromJson(jsonString);

import 'dart:convert';

ResponseGetBranch responseGetBranchFromJson(String str) => ResponseGetBranch.fromJson(json.decode(str));

String responseGetBranchToJson(ResponseGetBranch data) => json.encode(data.toJson());

class ResponseGetBranch {
  ResponseGetBranch({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<BranchData>? data;

  factory ResponseGetBranch.fromJson(Map<String, dynamic> json) => ResponseGetBranch(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<BranchData>.from(json["data"].map((x) => BranchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BranchData {
  BranchData({
    this.branchId,
    this.branchFullName,
    this.moId,
    this.moName,
    this.agentIdConfins,
  });

  String? branchId;
  String? branchFullName;
  String? moId;
  String? moName;
  String? agentIdConfins;

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchFullName: json["branch_full_name"] == null ? null : json["branch_full_name"],
    moId: json["mo_id"] == null ? null : json["mo_id"],
    moName: json["mo_name"] == null ? null : json["mo_name"],
    agentIdConfins: json["agent_id_confins"] == null ? null : json["agent_id_confins"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId == null ? null : branchId,
    "branch_full_name": branchFullName == null ? null : branchFullName,
    "mo_id": moId == null ? null : moId,
    "mo_name": moName == null ? null : moName,
    "agent_id_confins": agentIdConfins == null ? null : agentIdConfins,
  };
}
