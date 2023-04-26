import 'dart:convert';

CreateSnapNBuyRequest createSnapNBuyRequestFromJson(String str) => CreateSnapNBuyRequest.fromJson(json.decode(str));

String createSnapNBuyRequestToJson(CreateSnapNBuyRequest data) => json.encode(data.toJson());

class CreateSnapNBuyRequest {
  CreateSnapNBuyRequest({
    this.application,
    this.assets,
    this.mobilePhone,
    this.prospectId,
    this.shippingCost,
  });

  Application? application;
  List<Asset>? assets;
  String? mobilePhone;
  String? prospectId;
  int? shippingCost;

  factory CreateSnapNBuyRequest.fromJson(Map<String, dynamic> json) => CreateSnapNBuyRequest(
    application: json["application"] == null ? null : Application.fromJson(json["application"]),
    assets: json["assets"] == null ? null : List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
    mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    shippingCost: json["shipping_cost"] == null ? null : json["shipping_cost"],
  );

  Map<String, dynamic> toJson() => {
    "application": application == null ? null : application!.toJson(),
    "assets": assets == null ? null : List<dynamic>.from(assets!.map((x) => x.toJson())),
    "mobile_phone": mobilePhone == null ? null : mobilePhone,
    "prospect_id": prospectId == null ? null : prospectId,
    "shipping_cost": shippingCost == null ? null : shippingCost,
  };
}

class Application {
  Application({
    this.adminFee,
    this.af,
    this.aoId,
    this.firstInstallment,
    this.installmentAmount,
    this.insuranceFee,
    this.isAdminAsLoan,
    this.miNumber,
    this.ntf,
    this.payToDealerAmount,
    this.productId,
    this.productOfferingId,
    this.rate,
    this.sessionId,
    this.subsidiDealer,
    this.tenor,
    this.tenorLimit,
    this.totalOtr,
    this.totalPayment,
    this.programId,
  });

  int? adminFee;
  int? af;
  String? aoId;
  String? firstInstallment;
  int? installmentAmount;
  int? insuranceFee;
  bool? isAdminAsLoan;
  int? miNumber;
  int? ntf;
  int? payToDealerAmount;
  String? productId;
  String? productOfferingId;
  double? rate;
  String? sessionId;
  int? subsidiDealer;
  int? tenor;
  int? tenorLimit;
  int? totalOtr;
  int? totalPayment;
  String? programId;

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
    af: json["af"] == null ? null : json["af"],
    aoId: json["ao_id"] == null ? null : json["ao_id"],
    firstInstallment: json["first_installment"] == null ? null : json["first_installment"],
    installmentAmount: json["installment_amount"] == null ? null : json["installment_amount"],
    insuranceFee: json["insurance_fee"] == null ? null : json["insurance_fee"],
    isAdminAsLoan: json["is_admin_as_loan"] == null ? null : json["is_admin_as_loan"],
    miNumber: json["mi_number"] == null ? null : json["mi_number"],
    ntf: json["ntf"] == null ? null : json["ntf"],
    payToDealerAmount: json["pay_to_dealer_amount"] == null ? null : json["pay_to_dealer_amount"],
    productId: json["product_id"] == null ? null : json["product_id"],
    productOfferingId: json["product_offering_id"] == null ? null : json["product_offering_id"],
    rate: json["rate"] == null ? null : json["rate"],
    sessionId: json["session_id"] == null ? null : json["session_id"],
    subsidiDealer: json["subsidi_dealer"] == null ? null : json["subsidi_dealer"],
    tenor: json["tenor"] == null ? null : json["tenor"],
    tenorLimit: json["tenor_limit"] == null ? null : json["tenor_limit"],
    totalOtr: json["total_otr"] == null ? null : json["total_otr"],
    totalPayment: json["total_payment"] == null ? null : json["total_payment"],
    programId: json["program_id"] == null ? null : json["program_id"],
  );

  Map<String, dynamic> toJson() => {
    "admin_fee": adminFee == null ? null : adminFee,
    "af": af == null ? null : af,
    "ao_id": aoId == null ? null : aoId,
    "first_installment": firstInstallment == null ? null : firstInstallment,
    "installment_amount": installmentAmount == null ? null : installmentAmount,
    "insurance_fee": insuranceFee == null ? null : insuranceFee,
    "is_admin_as_loan": isAdminAsLoan == null ? null : isAdminAsLoan,
    "mi_number": miNumber == null ? null : miNumber,
    "ntf": ntf == null ? null : ntf,
    "pay_to_dealer_amount": payToDealerAmount == null ? null : payToDealerAmount,
    "product_id": productId == null ? null : productId,
    "product_offering_id": productOfferingId == null ? null : productOfferingId,
    "rate": rate == null ? null : rate,
    "session_id": sessionId == null ? null : sessionId,
    "subsidi_dealer": subsidiDealer == null ? null : subsidiDealer,
    "tenor": tenor == null ? null : tenor,
    "tenor_limit": tenorLimit == null ? null : tenorLimit,
    "total_otr": totalOtr == null ? null : totalOtr,
    "total_payment": totalPayment == null ? null : totalPayment,
    "program_id": programId == null ? null : programId,
  };
}

class Asset {
  Asset({
    this.assetCode,
    this.assetType,
    this.categoryCode,
    this.categoryName,
    this.discountAmount,
    this.dpAmount,
    this.insuranceAmount,
    this.itemDescription,
    this.otr,
    this.productId,
    this.quantity,
  });

  String? assetCode;
  String? assetType;
  String? categoryCode;
  String? categoryName;
  int? discountAmount;
  int? dpAmount;
  int? insuranceAmount;
  String? itemDescription;
  int? otr;
  String? productId;
  int? quantity;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetCode: json["asset_code"] == null ? null : json["asset_code"],
    assetType: json["asset_type"] == null ? null : json["asset_type"],
    categoryCode: json["category_code"] == null ? null : json["category_code"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    discountAmount: json["discount_amount"] == null ? null : json["discount_amount"],
    dpAmount: json["dp_amount"] == null ? null : json["dp_amount"],
    insuranceAmount: json["insurance_amount"] == null ? null : json["insurance_amount"],
    itemDescription: json["item_description"] == null ? null : json["item_description"],
    otr: json["otr"] == null ? null : json["otr"],
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "asset_code": assetCode == null ? null : assetCode,
    "asset_type": assetType == null ? null : assetType,
    "category_code": categoryCode == null ? null : categoryCode,
    "category_name": categoryName == null ? null : categoryName,
    "discount_amount": discountAmount == null ? null : discountAmount,
    "dp_amount": dpAmount == null ? null : dpAmount,
    "insurance_amount": insuranceAmount == null ? null : insuranceAmount,
    "item_description": itemDescription == null ? null : itemDescription,
    "otr": otr == null ? null : otr,
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
  };
}
