import 'dart:convert';

TrackingResponse trackingResponseFromJson(String str) => TrackingResponse.fromJson(json.decode(str));

class TrackingResponse {
  TrackingResponse({
    this.code,
    this.message,
    this.trackingData,
  });

  int? code;
  String? message;
  TrackingData? trackingData;

  factory TrackingResponse.fromJson(Map<String, dynamic> json) => TrackingResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    trackingData: json["data"] == null ? null : TrackingData.fromJson(json["data"]),
  );
}

class TrackingData {
  TrackingData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.stateId,
    this.cityId,
    this.areaId,
    this.townId,
    this.prospectId,
    this.status,
    this.packedTime,
    this.deliveryTime,
    this.destinationTime,
    this.logisticName,
    this.awbNumber,
    this.mobilePhone,
    this.receiverName,
    this.shippingAddress,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? stateId;
  String? cityId;
  dynamic areaId;
  dynamic townId;
  String? prospectId;
  String? status;
  DateTime? packedTime;
  DateTime? deliveryTime;
  DateTime? destinationTime;
  String? logisticName;
  String? awbNumber;
  String? mobilePhone;
  String? receiverName;
  String? shippingAddress;

  factory TrackingData.fromJson(Map<String, dynamic> json) => TrackingData(
    id: json["id"] == null ? null : json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    areaId: json["area_id"],
    townId: json["town_id"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    status: json["status"] == null ? null : json["status"],
    packedTime: json["packed_time"] == null ? null : DateTime.parse(json["packed_time"]),
    deliveryTime: json["delivery_time"] == null ? null : DateTime.parse(json["delivery_time"]),
    destinationTime: json["destination_time"] == null ? null : DateTime.parse(json["destination_time"]),
    logisticName: json["logistic_name"] == null ? null : json["logistic_name"],
    awbNumber: json["awb_number"] == null ? null : json["awb_number"],
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
    receiverName: json["receiver_name"] == null ? null : json["receiver_name"],
    shippingAddress: json["shipping_address"] == null ? null : json["shipping_address"],
  );
}
