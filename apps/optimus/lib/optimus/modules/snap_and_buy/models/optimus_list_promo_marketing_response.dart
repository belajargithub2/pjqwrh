import 'dart:convert';

enum LimitType { BLUE, GOLD, PLATINUM }

ListPromoMarketingResponse listPromoMarketingResponseFromJson(String str) =>
    ListPromoMarketingResponse.fromJson(json.decode(str));

String listPromoMarketingResponseToJson(ListPromoMarketingResponse data) =>
    json.encode(data.toJson());

class ListPromoMarketingResponse {
  ListPromoMarketingResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory ListPromoMarketingResponse.fromJson(Map<String, dynamic> json) =>
      ListPromoMarketingResponse(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.customerStatus,
    this.programs,
  });

  CustomerStatus? customerStatus;
  List<Program>? programs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        customerStatus: json["customer_status"] == null
            ? null
            : CustomerStatus.fromJson(json["customer_status"]),
        programs: json["programs"] == null
            ? null
            : List<Program>.from(
                json["programs"].map((x) => Program.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "customer_status":
            customerStatus == null ? null : customerStatus!.toJson(),
        "programs": programs == null
            ? null
            : List<dynamic>.from(programs!.map((x) => x.toJson())),
      };
}

class CustomerStatus {
  CustomerStatus({
    this.customerId,
    this.customerRegisterStatus,
    this.isRegisteredKreditmu,
    this.limitStatus,
    this.verificationLimitStatus,
    this.dataVerification,
    this.faceVerification,
    this.limitCategory,
  });

  int? customerId;
  String? customerRegisterStatus;
  bool? isRegisteredKreditmu;
  String? limitStatus;
  String? verificationLimitStatus;
  bool? dataVerification;
  bool? faceVerification;
  LimitType? limitCategory;

  factory CustomerStatus.fromJson(Map<String, dynamic> json) => CustomerStatus(
        customerId: json["customer_id"] == null ? null : json["customer_id"],
        customerRegisterStatus: json["customer_register_status"] == null
            ? null
            : json["customer_register_status"],
        isRegisteredKreditmu: json["is_registered_kreditmu"] == null
            ? null
            : json["is_registered_kreditmu"],
        limitStatus: json["limit_status"] == null ? null : json["limit_status"],
        verificationLimitStatus: json["verification_limit_status"] == null
            ? null
            : json["verification_limit_status"],
        dataVerification: json["data_verification"] == null
            ? null
            : json["data_verification"],
        faceVerification: json["face_verification"] == null
            ? null
            : json["face_verification"],
        limitCategory: json["limit_category"] != ""
            ? LimitType.values.byName(json["limit_category"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId == null ? null : customerId,
        "customer_register_status":
            customerRegisterStatus == null ? null : customerRegisterStatus,
        "is_registered_kreditmu":
            isRegisteredKreditmu == null ? null : isRegisteredKreditmu,
        "limit_status": limitStatus == null ? null : limitStatus,
        "verification_limit_status":
            verificationLimitStatus == null ? null : verificationLimitStatus,
        "data_verification": dataVerification == null ? null : dataVerification,
        "face_verification": faceVerification == null ? null : faceVerification,
        "limit_category": limitCategory == null ? null : limitCategory,
      };
}

class Program {
  Program({
    this.programId,
    this.programName,
    this.miNumber,
    this.description,
    this.periodStart,
    this.periodEnd,
    this.specialFeature,
    this.installmentType,
    this.minimumDpMethod,
    this.minimumDpAmount,
    this.minimumDpPercentage,
    this.totalOtr,
  });

  String? programId;
  String? programName;
  int? miNumber;
  String? description;
  DateTime? periodStart;
  DateTime? periodEnd;
  String? specialFeature;
  String? installmentType;
  String? minimumDpMethod;
  int? minimumDpAmount;
  double? minimumDpPercentage;
  int? totalOtr;

  factory Program.fromJson(Map<String, dynamic> json) => Program(
        programId: json["program_id"] == null ? null : json["program_id"],
        programName: json["program_name"] == null ? null : json["program_name"],
        miNumber: json["mi_number"] == null ? null : json["mi_number"],
        description: json["description"] == null ? null : json["description"],
        periodStart: json["period_start"] == null
            ? null
            : DateTime.parse(json["period_start"]),
        periodEnd: json["period_end"] == null
            ? null
            : DateTime.parse(json["period_end"]),
        specialFeature:
            json["special_feature"] == null ? null : json["special_feature"],
        installmentType:
            json["installment_type"] == null ? null : json["installment_type"],
        minimumDpMethod: json["minimum_dp_method"] == null
            ? null
            : json["minimum_dp_method"],
        minimumDpAmount: json["minimum_dp_amount"] == null
            ? null
            : json["minimum_dp_amount"],
        minimumDpPercentage: json["minimum_dp_percentage"] == null
            ? null
            : json["minimum_dp_percentage"].toDouble(),
        totalOtr: json["total_otr"] == null ? null : json["total_otr"],
      );

  Map<String, dynamic> toJson() => {
        "program_id": programId == null ? null : programId,
        "program_name": programName == null ? null : programName,
        "mi_number": miNumber == null ? null : miNumber,
        "description": description == null ? null : description,
        "period_start":
            periodStart == null ? null : periodStart!.toIso8601String(),
        "period_end": periodEnd == null ? null : periodEnd!.toIso8601String(),
        "special_feature": specialFeature == null ? null : specialFeature,
        "installment_type": installmentType == null ? null : installmentType,
        "minimum_dp_method": minimumDpMethod == null ? null : minimumDpMethod,
        "minimum_dp_amount": minimumDpAmount == null ? null : minimumDpAmount,
        "minimum_dp_percentage":
            minimumDpPercentage == null ? null : minimumDpPercentage,
        "total_otr": totalOtr == null ? null : totalOtr,
      };
}
