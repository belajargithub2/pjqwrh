import 'dart:convert';

SubmitOrderRequest submitOrderRequestFromJson(String str) => SubmitOrderRequest.fromJson(json.decode(str));

String submitOrderRequestToJson(SubmitOrderRequest data) => json.encode(data.toJson());

class SubmitOrderRequest {
  SubmitOrderRequest({
    this.prospectId,
    this.groupCategoryId,
    this.groupCategoryCode,
    this.groupCategoryName,
    this.assets,
    this.croId,
    this.croName,
    this.supplierId,
    this.supplierName,
    this.supplierAddress,
    this.supplierKey,
    this.customerId,
    this.customerName,
    this.customerLimitCategory,
    this.customerMobilePhone,
    this.latitude,
    this.longitude,
    this.sourceApplication,
    this.branchId,
    this.isNewWg,
    this.isNearCustomer,
  });

  String? prospectId;
  int? groupCategoryId;
  String? groupCategoryCode;
  String? groupCategoryName;
  List<Asset>? assets;
  String? croId;
  String? croName;
  String? supplierId;
  String? supplierName;
  String? supplierAddress;
  String? supplierKey;
  String? customerId;
  String? customerName;
  String? customerLimitCategory;
  String? customerMobilePhone;
  String? latitude;
  String? longitude;
  String? sourceApplication;
  String? branchId;
  bool? isNewWg;
  bool? isNearCustomer;

  factory SubmitOrderRequest.fromJson(Map<String, dynamic> json) => SubmitOrderRequest(
    prospectId: json["prospect_id"],
    groupCategoryId: json["group_category_id"],
    groupCategoryCode: json["group_category_code"],
    groupCategoryName: json["group_category_name"],
    assets: json["assets"] == null ? [] : List<Asset>.from(json["assets"]!.map((x) => Asset.fromJson(x))),
    croId: json["cro_id"],
    croName: json["cro_name"],
    supplierId: json["supplier_id"],
    supplierName: json["supplier_name"],
    supplierAddress: json["supplier_address"],
    supplierKey: json["supplier_key"],
    customerId: json["customer_id"],
    customerName: json["customer_name"],
    customerLimitCategory: json["customer_limit_category"],
    customerMobilePhone: json["customer_mobile_phone"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    sourceApplication: json["source_application"],
    branchId: json["branch_id"],
    isNewWg: json["is_new_wg"],
    isNearCustomer: json["is_near_customer"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId,
    "group_category_id": groupCategoryId,
    "group_category_code": groupCategoryCode,
    "group_category_name": groupCategoryName,
    "assets": assets == null ? [] : List<dynamic>.from(assets!.map((x) => x.toJson())),
    "cro_id": croId,
    "cro_name": croName,
    "supplier_id": supplierId,
    "supplier_name": supplierName,
    "supplier_address": supplierAddress,
    "supplier_key": supplierKey,
    "customer_id": customerId,
    "customer_name": customerName,
    "customer_limit_category": customerLimitCategory,
    "customer_mobile_phone": customerMobilePhone,
    "latitude": latitude,
    "longitude": longitude,
    "source_application": sourceApplication,
    "branch_id": branchId,
    "is_new_wg": isNewWg,
    "is_near_customer": isNearCustomer,
  };
}

class Asset {
  Asset({
    this.code,
    this.description,
    this.categoryId,
    this.categoryName,
    this.otr,
    this.qty,
  });

  String? code;
  String? description;
  String? categoryId;
  String? categoryName;
  int? otr;
  int? qty;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    code: json["code"],
    description: json["description"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    otr: json["otr"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "category_id": categoryId,
    "category_name": categoryName,
    "otr": otr,
    "qty": qty,
  };
}
