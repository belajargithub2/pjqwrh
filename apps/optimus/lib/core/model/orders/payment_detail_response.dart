import 'dart:convert';

PaymentDetailResponse paymentDetailResponseFromJson(String str) => PaymentDetailResponse.fromJson(json.decode(str));

class PaymentDetailResponse {
  PaymentDetailResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory PaymentDetailResponse.fromJson(Map<String, dynamic> json) => PaymentDetailResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.prospectId,
    this.applicationId,
    this.agreementNo,
    this.goLiveDate,
    this.payToDealerDate,
    this.payToDealerAmount,
    this.trackingStatus,
    this.createdAt,
  });

  String? prospectId;
  String? applicationId;
  String? agreementNo;
  DateTime? goLiveDate;
  DateTime? payToDealerDate;
  int? payToDealerAmount;
  String? trackingStatus;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    applicationId: json["application_id"] == null ? null : json["application_id"],
    agreementNo: json["agreement_no"] == null ? null : json["agreement_no"],
    goLiveDate: json["go_live_date"] == null ? null : DateTime.parse(json["go_live_date"]),
    payToDealerDate: json["pay_to_dealer_date"] == null ? null : DateTime.parse(json["pay_to_dealer_date"]),
    payToDealerAmount: json["pay_to_dealer_amount"] == null ? null : json["pay_to_dealer_amount"],
    trackingStatus: json["tracking_status"] == null ? null : json["tracking_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );
}
