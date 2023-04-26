import 'dart:convert';

CalculateRequest calculateRequestFromJson(String str) => CalculateRequest.fromJson(json.decode(str));

String calculateRequestToJson(CalculateRequest data) => json.encode(data.toJson());

class CalculateRequest {
  CalculateRequest({
    this.programId,
    this.customerId,
    this.dpAmount,
    this.totalOtr,
    this.insuranceShippingFee,
    this.shippingFee,
  });

  String? programId;
  int? customerId;
  int? dpAmount;
  int? totalOtr;
  int? insuranceShippingFee;
  int? shippingFee;

  factory CalculateRequest.fromJson(Map<String, dynamic> json) => CalculateRequest(
    programId: json["program_id"] == null ? null : json["program_id"],
    customerId: json["customer_id"] == null ? null : json["customer_id"],
    dpAmount: json["dp_amount"] == null ? null : json["dp_amount"],
    totalOtr: json["total_otr"] == null ? null : json["total_otr"],
    insuranceShippingFee: json["insurance_shipping_fee"] == null ? null : json["insurance_shipping_fee"],
    shippingFee: json["shipping_fee"] == null ? null : json["shipping_fee"],
  );

  Map<String, dynamic> toJson() => {
    "program_id": programId == null ? null : programId,
    "customer_id": customerId == null ? null : customerId,
    "dp_amount": dpAmount == null ? null : dpAmount,
    "total_otr": totalOtr == null ? null : totalOtr,
    "insurance_shipping_fee": insuranceShippingFee == null ? null : insuranceShippingFee,
    "shipping_fee": shippingFee == null ? null : shippingFee,
  };
}

CalculateResponse calculateResponseFromJson(String str) => CalculateResponse.fromJson(json.decode(str));

String calculateResponseToJson(CalculateResponse data) => json.encode(data.toJson());

class CalculateResponse {
  CalculateResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<TenorData>? data;

  factory CalculateResponse.fromJson(Map<String, dynamic> json) => CalculateResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<TenorData>.from(json["data"].map((x) => TenorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TenorData {
  TenorData({
    this.firstInstallment,
    this.installmentAmount,
    this.insuranceFee,
    this.rate,
    this.tenor,
    this.tenorLimit,
    this.adminFee,
    this.totalPaymentAmount,
    this.subsidyAdminDealer,
    this.subsidyRateDealer,
    this.subsidyDealer,
    this.payToDealerAmount,
    this.productId,
    this.productOfferingId,
    this.totalOtr,
    this.af,
    this.ntf,
    this.isAdminAsLoan,
    this.sessionId,
  });

  String? firstInstallment;
  int? installmentAmount;
  int? insuranceFee;
  double? rate;
  int? tenor;
  int? tenorLimit;
  int? adminFee;
  int? totalPaymentAmount;
  int? subsidyAdminDealer;
  int? subsidyRateDealer;
  int? subsidyDealer;
  int? payToDealerAmount;
  String? productId;
  String? productOfferingId;
  int? totalOtr;
  int? af;
  int? ntf;
  bool? isAdminAsLoan;
  String? sessionId;

  factory TenorData.fromJson(Map<String, dynamic> json) => TenorData(
    firstInstallment: json["first_installment"] == null ? null : json["first_installment"],
    installmentAmount: json["installment_amount"] == null ? null : json["installment_amount"],
    insuranceFee: json["insurance_fee"] == null ? null : json["insurance_fee"],
    rate: json["rate"] == null ? null : json["rate"].toDouble(),
    tenor: json["tenor"] == null ? null : json["tenor"],
    tenorLimit: json["tenor_limit"] == null ? null : json["tenor_limit"],
    adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
    totalPaymentAmount: json["total_payment_amount"] == null ? null : json["total_payment_amount"],
    subsidyAdminDealer: json["subsidy_admin_dealer"] == null ? null : json["subsidy_admin_dealer"],
    subsidyRateDealer: json["subsidy_rate_dealer"] == null ? null : json["subsidy_rate_dealer"],
    subsidyDealer: json["subsidy_dealer"] == null ? null : json["subsidy_dealer"],
    payToDealerAmount: json["pay_to_dealer_amount"] == null ? null : json["pay_to_dealer_amount"],
    productId: json["product_id"] == null ? null : json["product_id"],
    productOfferingId: json["product_offering_id"] == null ? null : json["product_offering_id"],
    totalOtr: json["total_otr"] == null ? null : json["total_otr"],
    af: json["af"] == null ? null : json["af"],
    ntf: json["ntf"] == null ? null : json["ntf"],
    isAdminAsLoan: json["is_admin_as_loan"] == null ? null : json["is_admin_as_loan"],
    sessionId: json["session_id"] == null ? null : json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_installment": firstInstallment == null ? null : firstInstallment,
    "installment_amount": installmentAmount == null ? null : installmentAmount,
    "insurance_fee": insuranceFee == null ? null : insuranceFee,
    "rate": rate == null ? null : rate,
    "tenor": tenor == null ? null : tenor,
    "tenor_limit": tenorLimit == null ? null : tenorLimit,
    "admin_fee": adminFee == null ? null : adminFee,
    "total_payment_amount": totalPaymentAmount == null ? null : totalPaymentAmount,
    "subsidy_admin_dealer": subsidyAdminDealer == null ? null : subsidyAdminDealer,
    "subsidy_rate_dealer": subsidyRateDealer == null ? null : subsidyRateDealer,
    "subsidy_dealer": subsidyDealer == null ? null : subsidyDealer,
    "pay_to_dealer_amount": payToDealerAmount == null ? null : payToDealerAmount,
    "product_id": productId == null ? null : productId,
    "product_offering_id": productOfferingId == null ? null : productOfferingId,
    "total_otr": totalOtr == null ? null : totalOtr,
    "af": af == null ? null : af,
    "ntf": ntf == null ? null : ntf,
    "is_admin_as_loan": isAdminAsLoan == null ? null : isAdminAsLoan,
    "session_id": sessionId == null ? null : sessionId,
  };
}



