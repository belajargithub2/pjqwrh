import 'package:meta/meta.dart';
import 'dart:convert';

TrackingOrderResponseModel trackingOrderResponseModelFromJson(String str) =>
    TrackingOrderResponseModel.fromJson(json.decode(str));

class TrackingOrderResponseModel {
  TrackingOrderResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  TrackingOrderData? data;

  factory TrackingOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      TrackingOrderResponseModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : TrackingOrderData.fromJson(json["data"]),
      );
}

class TrackingOrderData {
  TrackingOrderData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.prospectId,
    required this.status,
    required this.packedTime,
    required this.deliveryTime,
    required this.destinationTime,
    required this.logisticName,
    required this.awbNumber,
    required this.mobilePhone,
    required this.receiverName,
    required this.shippingAddress,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
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

  factory TrackingOrderData.fromJson(Map<String, dynamic> json) =>
      TrackingOrderData(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        prospectId: json["prospect_id"] == null ? '-' : json["prospect_id"],
        status: json["status"] == null ? '-' : json["status"],
        packedTime: json["packed_time"] == null
            ? null
            : DateTime.parse(json["packed_time"]),
        deliveryTime: json["delivery_time"] == null
            ? null
            : DateTime.parse(json["delivery_time"]),
        destinationTime: json["destination_time"] == null
            ? null
            : DateTime.parse(json["destination_time"]),
        logisticName:
            json["logistic_name"] == null ? '-' : json["logistic_name"],
        awbNumber: json["awb_number"] == null ? '-' : json["awb_number"],
        mobilePhone: json["mobile_phone"] == null ? '-' : json["mobile_phone"],
        receiverName:
            json["receiver_name"] == null ? '-' : json["receiver_name"],
        shippingAddress:
            json["shipping_address"] == null ? '-' : json["shipping_address"],
      );
}
