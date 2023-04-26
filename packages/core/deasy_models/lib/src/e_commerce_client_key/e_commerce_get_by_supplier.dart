
import 'dart:convert';

ECommerceClientKeyBySupplierResponse eCommerceClientKeyBySupplierResponseFromJson(String str) => ECommerceClientKeyBySupplierResponse.fromJson(json.decode(str));

String eCommerceClientKeyBySupplierResponseToJson(ECommerceClientKeyBySupplierResponse data) => json.encode(data.toJson());

class ECommerceClientKeyBySupplierResponse {
  ECommerceClientKeyBySupplierResponse({
    this.message,
    this.data,
  });

  String? message;
  EcommerceClientSupplierData? data;

  factory ECommerceClientKeyBySupplierResponse.fromJson(Map<String, dynamic> json) => ECommerceClientKeyBySupplierResponse(
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : EcommerceClientSupplierData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class EcommerceClientSupplierData {
  EcommerceClientSupplierData({
    this.merchantId,
    this.merchantName,
    this.key,
    this.name,
    this.callbackUrlSignature,
    this.callbackUrlStatus,
    this.callbackUrlOrder,
  });

  String? merchantId;
  String? merchantName;
  String? key;
  String? name;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? callbackUrlOrder;

  factory EcommerceClientSupplierData.fromJson(Map<String, dynamic> json) => EcommerceClientSupplierData(
    merchantId: json["merchant_id"] == null ? null : json["merchant_id"],
    merchantName: json["merchant_name"] == null ? null : json["merchant_name"],
    key: json["key"] == null ? null : json["key"],
    name: json["name"] == null ? null : json["name"],
    callbackUrlSignature: json["callback_url_signature"] == null ? null : json["callback_url_signature"],
    callbackUrlStatus: json["callback_url_status"] == null ? null : json["callback_url_status"],
    callbackUrlOrder: json["callback_url_order"] == null ? null : json["callback_url_order"],
  );

  Map<String, dynamic> toJson() => {
    "merchant_id": merchantId == null ? null : merchantId,
    "merchant_name": merchantName == null ? null : merchantName,
    "key": key == null ? null : key,
    "name": name == null ? null : name,
    "callback_url_signature": callbackUrlSignature == null ? null : callbackUrlSignature,
    "callback_url_status": callbackUrlStatus == null ? null : callbackUrlStatus,
    "callback_url_order": callbackUrlOrder == null ? null : callbackUrlOrder,
  };
}
