import 'dart:convert';

DetailAgentOrderResponse detailAgentOrderResponseFromJson(String str) => DetailAgentOrderResponse.fromJson(json.decode(str));

class DetailAgentOrderResponse {
  DetailAgentOrderResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory DetailAgentOrderResponse.fromJson(Map<String, dynamic> json) => DetailAgentOrderResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.prospectId,
    this.customerName,
    this.orderDate,
    this.legalName,
    this.disbursedAmount,
    this.agentId,
    this.status,
    this.productOfferingId,
    this.productOfferingName,
    this.feeAgent,
    this.assets,
  });

  String? prospectId;
  String? customerName;
  DateTime? orderDate;
  String? legalName;
  int? disbursedAmount;
  int? agentId;
  String? status;
  String? productOfferingId;
  String? productOfferingName;
  dynamic feeAgent;
  List<Asset>? assets;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    customerName: json["customer_name"] == null ? null : json["customer_name"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    legalName: json["legal_name"] == null ? null : json["legal_name"],
    disbursedAmount: json["disbursed_amount"] == null ? null : json["disbursed_amount"],
    agentId: json["agent_id"] == null ? null : json["agent_id"],
    status: json["status"] == null ? null : json["status"],
    productOfferingId: json["product_offering_id"] == null ? null : json["product_offering_id"],
    productOfferingName: json["product_offering_name"] == null ? null : json["product_offering_name"],
    feeAgent: json["fee_agent"],
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
  );
}

class Asset {
  Asset({
    this.prospectId,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehicleType,
    this.licenseArea,
    this.licenseNumber,
    this.licenseCode,
    this.vehicleYear,
    this.vehicleRegistrationName,
  });

  String? prospectId;
  String? vehicleBrand;
  String? vehicleModel;
  String? vehicleType;
  String? licenseArea;
  String? licenseNumber;
  String? licenseCode;
  int? vehicleYear;
  String? vehicleRegistrationName;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    vehicleBrand: json["vehicle_brand"] == null ? null : json["vehicle_brand"],
    vehicleModel: json["vehicle_model"] == null ? null : json["vehicle_model"],
    vehicleType: json["vehicle_type"] == null ? null : json["vehicle_type"],
    licenseArea: json["license_area"] == null ? null : json["license_area"],
    licenseNumber: json["license_number"] == null ? null : json["license_number"],
    licenseCode: json["license_code"] == null ? null : json["license_code"],
    vehicleYear: json["vehicle_year"] == null ? null : json["vehicle_year"],
    vehicleRegistrationName: json["vehicle_registration_name"] == null ? null : json["vehicle_registration_name"],
  );
}
