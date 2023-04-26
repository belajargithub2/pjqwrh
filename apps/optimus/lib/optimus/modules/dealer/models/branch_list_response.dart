import 'dart:convert';

BranchListResponse branchListResponseFromJson(String str) => BranchListResponse.fromJson(json.decode(str));

String branchListResponseToJson(BranchListResponse data) => json.encode(data.toJson());

class BranchListResponse {
  BranchListResponse({
    this.message,
    this.listBranchData,
  });

  String? message;
  List<BranchData>? listBranchData;

  factory BranchListResponse.fromJson(Map<String, dynamic> json) => BranchListResponse(
    message: json["message"] == null ? null : json["message"],
    listBranchData: json["data"] == null ? null :
      List<BranchData>.from(json["data"].map((x) => BranchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": listBranchData == null ? null : List<dynamic>.from(listBranchData!.map((x) => x.toJson())),
  };
}

class BranchData {
  BranchData({
    this.branchId,
    this.branchFullname,
    this.branchAddress,
  });

  String? branchId;
  String? branchFullname;
  String? branchAddress;

  factory BranchData.fromJson(Map<String, dynamic> json) => BranchData(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchFullname: json["branch_name"] == null ? null : json["branch_name"],
    branchAddress: json["branch_address"] == null ? null : json["branch_address"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId == null ? null : branchId,
    "branch_name": branchFullname == null ? null : branchFullname,
    "branch_address": branchAddress == null ? null : branchAddress,
  };
}