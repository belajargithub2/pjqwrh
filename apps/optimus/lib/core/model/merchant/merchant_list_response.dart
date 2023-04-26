import 'dart:convert';

import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';

MerchantListResponse merchantListResponseFromJson(String str) => MerchantListResponse.fromJson(json.decode(str));

String merchantListResponseToJson(MerchantListResponse data) => json.encode(data.toJson());

class MerchantListResponse {
  MerchantListResponse({
    this.merchantData,
    this.message,
    this.pageInfo
  });

  List<MerchantData>? merchantData;
  String? message;
  PageInfo? pageInfo;

  factory MerchantListResponse.fromJson(Map<String, dynamic> json) => MerchantListResponse(
    message: json["message"] == null ? null : json["message"],
    merchantData: json["data"] == null ? List<MerchantData>.empty() :
      List<MerchantData>.from(json["data"].map((x) => MerchantData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": merchantData == null ? null : List<dynamic>.from(merchantData!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class MerchantData {
  MerchantData({
    this.supplierId,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.rt,
    this.rw,
    this.kelurahan,
    this.kecamatan,
    this.city,
    this.province,
    this.zipCode,
    this.isActive,
    this.isAwb,
    this.useKpx,
    this.useSnb,
    this.useEform,
    this.groupName,
    this.channel,
    this.branchId,
    this.branchName,
    this.croId,
    this.branchEmployee,
    this.sourceApplications,
    this.confirmationMethods,
    this.createdAt,
    this.updatedAt,
  });

  String? supplierId;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? rt;
  String? rw;
  String? kelurahan;
  String? kecamatan;
  String? city;
  String? province;
  String? zipCode;
  bool? isActive;
  bool? isAwb;
  bool? useKpx;
  bool? useSnb;
  bool? useEform;
  String? groupName;
  String? channel;
  String? branchId;
  String? branchName;
  BranchEmployee? branchEmployee;
  String? croId;
  List<SourceAppData>? sourceApplications;
  List<ConfirmationMethodData>? confirmationMethods;
  String? createdAt;
  String? updatedAt;

  factory MerchantData.fromJson(Map<String, dynamic> json) => MerchantData(
    supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    address: json["address"] == null ? null : json["address"],
    rt: json["rt"] == null ? null : json["rt"],
    rw: json["rw"] == null ? null : json["rw"],
    kelurahan: json["kelurahan"] == null ? null : json["kelurahan"],
    kecamatan: json["kecamatan"] == null ? null : json["kecamatan"],
    city: json["city"] == null ? null : json["city"],
    province: json["province"] == null ? null : json["province"],
    zipCode: json["zip_code"] == null ? null : json["zip_code"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    isAwb: json["is_awb"] == null ? null : json["is_awb"],
    useKpx: json["use_kpx"] == null ? null : json["use_kpx"],
    useSnb: json["use_snb"] == null ? null : json["use_snb"],
    useEform: json["use_eform"] == null ? null : json["use_eform"],
    groupName: json["group_name"] == null ? null : json["group_name"],
    channel: json["channel"] == null ? null : json["channel"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    branchName: json["branch_name"] == null ? null : json["branch_name"],
    branchEmployee: json["branch_employee"] == null ? null : BranchEmployee.fromJson(json["branch_employee"]),
    croId: json["cro_id"] == null ? null : json["cro_id"],
    sourceApplications: json["source_applications"] == null ? List<SourceAppData>.empty() :
      List<SourceAppData>.from(json["source_applications"].map((x) => SourceAppData.fromJson(x))),
    confirmationMethods: json["confirmation_methods"] == null ? List<ConfirmationMethodData>.empty() :
      List<ConfirmationMethodData>.from(json["confirmation_methods"].map((x) => ConfirmationMethodData.fromJson(x))),
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "supplier_id": supplierId== null ? null : supplierId,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "address": address == null ? null : address,
    "rt": rt == null ? null : rt,
    "rw": rw == null ? null : rw,
    "kelurahan": kelurahan == null ? null : kelurahan,
    "kecamatan": kecamatan == null ? null : kecamatan,
    "city": city == null ? null : city,
    "province": province == null ? null : province,
    "zip_code": zipCode == null ? null : zipCode,
    "is_active": isActive == null ? null : isActive,
    "is_awb": isAwb == null ? null : isAwb,
    "use_kpx": useKpx == null ? null : useKpx,
    "use_snb": useSnb == null ? null : useSnb,
    "use_eform": useEform == null ? null : useEform,
    "group_name": groupName == null ? null : groupName,
    "channel": channel == null ? null : channel,
    "branch_id": branchId == null ? null : branchId,
    "branch_name": branchName == null ? null : branchName,
    "branch_employee": branchEmployee == null ? null : branchEmployee,
    "cro_id": croId == null ? null : croId,
    "source_applications": sourceApplications == null ? null :
      List<dynamic>.from(sourceApplications!.map((x) => x.toJson())),
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}

class BranchEmployee {
  BranchEmployee({
    this.branchId,
    this.croId,
    this.employeeName,
    this.employeePosition,
    this.aoSalesStatus,
    this.isFpd,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  String? branchId;
  String? croId;
  String? employeeName;
  String? employeePosition;
  String? aoSalesStatus;
  bool? isFpd;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  factory BranchEmployee.fromJson(Map<String, dynamic> json) => BranchEmployee(
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    croId: json["cro_id"] == null ? null : json["cro_id"],
    employeeName: json["employee_name"] == null ? null : json["employee_name"],
    employeePosition: json["employee_position"] == null ? null : json["employee_position"],
    aoSalesStatus: json["ao_sales_status"] == null ? null : json["ao_sales_status"],
    isFpd: json["is_fpd"] == null ? null : json["is_fpd"],
    isActive: json["is_active"] == null ? null : json["is_active"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId == null ? null : branchId,
    "cro_id": croId == null ? null : croId,
    "employee_name": employeeName,
    "employee_position": employeePosition,
    "ao_sales_status": aoSalesStatus,
    "is_fpd": isFpd == null ? null : isFpd,
    "is_active": isActive == null ? null : isActive,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "deleted_at": deletedAt == null ? null : deletedAt!.toIso8601String(),
  };
}


class PageInfo {
  PageInfo({
    this.totalRecord,
    this.totalPage,
    this.offset,
    this.limit,
    this.page,
    this.prevPage,
    this.nextPage,
  });

  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  int? prevPage;
  int? nextPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalRecord: json["total_record"] == null ? null : json["total_record"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    offset: json["offset"] == null ? null : json["offset"],
    limit: json["limit"] == null ? null : json["limit"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"] == null ? null : json["prev_page"],
    nextPage: json["next_page"] == null ? null : json["next_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_record": totalRecord == null ? null : totalRecord,
    "total_page": totalPage == null ? null : totalPage,
    "offset": offset == null ? null : offset,
    "limit": limit == null ? null : limit,
    "page": page == null ? null : page,
    "prev_page": prevPage == null ? null : prevPage,
    "next_page": nextPage == null ? null : nextPage,
  };
}

class ConfirmationMethodData {
  ConfirmationMethodData({
    this.merchantSupplierId,
    this.confirmationMethod,
  });

  String? merchantSupplierId;
  String? confirmationMethod;

  factory ConfirmationMethodData.fromJson(Map<String, dynamic> json) => ConfirmationMethodData(
    merchantSupplierId: json["merchant_supplier_id"] == null ? null : json["merchant_supplier_id"],
    confirmationMethod: json["confirmation_method"] == null ? null : json["confirmation_method"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_supplier_id": merchantSupplierId == null ? null : merchantSupplierId,
    "confirmation_method": confirmationMethod == null ? null : confirmationMethod,
  };
}