import 'dart:convert';

import 'package:deasy_models/src/agent_orders_response.dart';

TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

class TransactionResponse {
  TransactionResponse({
    this.message,
    this.data,
    this.pageInfo,
  });

  String? message;
  List<TransactionResponseData>? data;
  TransactionPageInfo? pageInfo;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<TransactionResponseData>.from(
                json["data"].map((x) => TransactionResponseData.fromJson(x))),
        pageInfo: json["page_info"] == null
            ? null
            : TransactionPageInfo.fromJson(json["page_info"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "page_info": pageInfo == null ? null : pageInfo!.toJson(),
      };
}

class TransactionResponseData {
  TransactionResponseData({
    this.prospectId,
    this.productOfferingId,
    this.productOfferingName,
    this.supplierId,
    this.supplierName,
    this.supplierKey,
    this.croName,
    this.idNumber,
    this.customerName,
    this.mobilePhone,
    this.email,
    this.residenceAreaPhone,
    this.residencePhone,
    this.residenceAddress,
    this.residenceKelurahan,
    this.residenceKecamatan,
    this.residenceCity,
    this.residenceRt,
    this.residenceRw,
    this.residenceZipCode,
    this.qty,
    this.otr,
    this.discount,
    this.shippingCost,
    this.adminFee,
    this.insuranceFee,
    this.insuranceShippingFee,
    this.rate,
    this.tenor,
    this.installmentAmount,
    this.firstInstallmentAmount,
    this.dpPercent,
    this.dpAmount,
    this.ntfAmount,
    this.discountDealer,
    this.firstPayment,
    this.payToDealerAmount,
    this.assets,
    this.orderDate,
    this.orderStatus,
    this.invoiceDate,
    this.epoDate,
    this.bastDate,
    this.sourceApplication,
    this.agreementNo,
    this.goLiveDate,
    this.payToDealerDate,
    this.customerReceiptPhotoUrl,
    this.bastUrl,
    this.imeiUrl,
    this.isAdminAsLoan,
    this.trackingExists,
    this.confirmationMethods,
  });

  String? prospectId;
  String? productOfferingId;
  dynamic productOfferingName;
  String? supplierId;
  String? supplierName;
  dynamic supplierKey;
  String? croName;
  String? idNumber;
  String? customerName;
  String? mobilePhone;
  String? email;
  String? residenceAreaPhone;
  String? residencePhone;
  String? residenceAddress;
  String? residenceKelurahan;
  String? residenceKecamatan;
  String? residenceCity;
  String? residenceRt;
  String? residenceRw;
  String? residenceZipCode;
  int? qty;
  int? otr;
  int? discount;
  int? shippingCost;
  int? adminFee;
  int? insuranceFee;
  dynamic insuranceShippingFee;
  double? rate;
  int? tenor;
  int? installmentAmount;
  int? firstInstallmentAmount;
  dynamic dpPercent;
  int? dpAmount;
  int? ntfAmount;
  dynamic discountDealer;
  dynamic firstPayment;
  double? payToDealerAmount;
  dynamic assets;
  DateTime? orderDate;
  EnumOrderTransaction? orderStatus;
  DateTime? invoiceDate;
  DateTime? epoDate;
  DateTime? bastDate;
  String? sourceApplication;
  dynamic agreementNo;
  dynamic goLiveDate;
  dynamic payToDealerDate;
  String? customerReceiptPhotoUrl;
  String? bastUrl;
  String? imeiUrl;
  bool? isAdminAsLoan;
  bool? trackingExists;
  List<ConfirmationMethodElement>? confirmationMethods;

  factory TransactionResponseData.fromJson(Map<String, dynamic> json) =>
      TransactionResponseData(
        prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
        productOfferingId: json["product_offering_id"] == null
            ? null
            : json["product_offering_id"],
        productOfferingName: json["product_offering_name"],
        supplierId: json["supplier_id"] == null ? null : json["supplier_id"],
        supplierName:
            json["supplier_name"] == null ? "-" : json["supplier_name"],
        supplierKey: json["supplier_key"],
        croName: json["cro_name"] == null ? null : json["cro_name"],
        idNumber: json["id_number"] == null ? null : json["id_number"],
        customerName:
            json["customer_name"] == null ? null : json["customer_name"],
        mobilePhone: json["mobile_phone"] == null ? null : json["mobile_phone"],
        email: json["email"] == null ? null : json["email"],
        residenceAreaPhone: json["residence_area_phone"] == null
            ? null
            : json["residence_area_phone"],
        residencePhone:
            json["residence_phone"] == null ? null : json["residence_phone"],
        residenceAddress: json["residence_address"] == null
            ? null
            : json["residence_address"],
        residenceKelurahan: json["residence_kelurahan"] == null
            ? null
            : json["residence_kelurahan"],
        residenceKecamatan: json["residence_kecamatan"] == null
            ? null
            : json["residence_kecamatan"],
        residenceCity:
            json["residence_city"] == null ? null : json["residence_city"],
        residenceRt: json["residence_rt"] == null ? null : json["residence_rt"],
        residenceRw: json["residence_rw"] == null ? null : json["residence_rw"],
        residenceZipCode: json["residence_zip_code"] == null
            ? null
            : json["residence_zip_code"],
        qty: json["qty"] == null ? null : json["qty"],
        otr: json["otr"] == null ? null : json["otr"],
        discount: json["discount"] == null ? null : json["discount"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
        insuranceFee:
            json["insurance_fee"] == null ? null : json["insurance_fee"],
        insuranceShippingFee: json["insurance_shipping_fee"],
        rate: json["rate"] == null ? null : json["rate"].toDouble(),
        tenor: json["tenor"] == null ? null : json["tenor"],
        installmentAmount: json["installment_amount"] == null
            ? null
            : json["installment_amount"],
        firstInstallmentAmount: json["first_installment_amount"] == null
            ? null
            : json["first_installment_amount"],
        dpPercent: json["dp_percent"],
        dpAmount: json["dp_amount"] == null ? null : json["dp_amount"],
        ntfAmount: json["ntf_amount"] == null ? null : json["ntf_amount"],
        discountDealer: json["discount_dealer"],
        firstPayment: json["first_payment"],
        payToDealerAmount: json["pay_to_dealer_amount"] == null
            ? null
            : json["pay_to_dealer_amount"].toDouble(),
        assets: json["assets"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        orderStatus: json["order_status"] == null
            ? null
            : ResponseEnumOrderTransactionMap[json["order_status"]],
        invoiceDate: json["invoice_date"] == null
            ? null
            : DateTime.parse(json["invoice_date"]),
        epoDate:
            json["epo_date"] == null ? null : DateTime.parse(json["epo_date"]),
        bastDate: json["bast_date"] == null
            ? null
            : DateTime.parse(json["bast_date"]),
        sourceApplication: json["source_application"] == null
            ? " "
            : json["source_application"],
        agreementNo: json["agreement_no"],
        goLiveDate: json["go_live_date"],
        payToDealerDate: json["pay_to_dealer_date"],
        customerReceiptPhotoUrl: json["customer_receipt_photo_url"] == null
            ? ""
            : json["customer_receipt_photo_url"],
        bastUrl: json["bast_url"] == null ? "" : json["bast_url"],
        imeiUrl: json["imei_url"] == null ? "" : json["imei_url"],
        isAdminAsLoan:
            json["is_admin_as_loan"] == null ? null : json["is_admin_as_loan"],
        trackingExists:
            json["tracking_exists"] == null ? null : json["tracking_exists"],
        confirmationMethods: json["confirmation_methods"] == null
            ? null
            : List<ConfirmationMethodElement>.from(json["confirmation_methods"]
                .map((x) => ConfirmationMethodElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "prospect_id": prospectId == null ? null : prospectId,
        "product_offering_id":
            productOfferingId == null ? null : productOfferingId,
        "product_offering_name": productOfferingName,
        "supplier_id": supplierId == null ? null : supplierId,
        "supplier_id": supplierName == null ? null : supplierName,
        "supplier_key": supplierKey,
        "cro_name": croName == null ? null : croName,
        "id_number": idNumber == null ? null : idNumber,
        "customer_name": customerName == null ? null : customerName,
        "mobile_phone": mobilePhone == null ? null : mobilePhone,
        "email": email == null ? null : email,
        "residence_area_phone":
            residenceAreaPhone == null ? null : residenceAreaPhone,
        "residence_phone": residencePhone == null ? null : residencePhone,
        "residence_address": residenceAddress == null ? null : residenceAddress,
        "residence_kelurahan":
            residenceKelurahan == null ? null : residenceKelurahan,
        "residence_kecamatan":
            residenceKecamatan == null ? null : residenceKecamatan,
        "residence_city": residenceCity == null ? null : residenceCity,
        "residence_rt": residenceRt == null ? null : residenceRt,
        "residence_rw": residenceRw == null ? null : residenceRw,
        "residence_zip_code":
            residenceZipCode == null ? null : residenceZipCode,
        "qty": qty == null ? null : qty,
        "otr": otr == null ? null : otr,
        "discount": discount == null ? null : discount,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "admin_fee": adminFee == null ? null : adminFee,
        "insurance_fee": insuranceFee == null ? null : insuranceFee,
        "insurance_shipping_fee": insuranceShippingFee,
        "rate": rate == null ? null : rate,
        "tenor": tenor == null ? null : tenor,
        "installment_amount":
            installmentAmount == null ? null : installmentAmount,
        "first_installment_amount":
            firstInstallmentAmount == null ? null : firstInstallmentAmount,
        "dp_percent": dpPercent,
        "dp_amount": dpAmount == null ? null : dpAmount,
        "ntf_amount": ntfAmount == null ? null : ntfAmount,
        "discount_dealer": discountDealer,
        "first_payment": firstPayment,
        "pay_to_dealer_amount":
            payToDealerAmount == null ? null : payToDealerAmount,
        "assets": assets,
        "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
        "order_status": orderStatus == null ? null : orderStatus,
        "invoice_date":
            invoiceDate == null ? null : invoiceDate!.toIso8601String(),
        "epo_date": epoDate == null ? null : epoDate!.toIso8601String(),
        "bast_date": bastDate == null ? null : bastDate!.toIso8601String(),
        "source_application":
            sourceApplication == null ? null : sourceApplication,
        "agreement_no": agreementNo,
        "go_live_date": goLiveDate,
        "pay_to_dealer_date": payToDealerDate,
        "customer_receipt_photo_url":
            customerReceiptPhotoUrl == null ? null : customerReceiptPhotoUrl,
        "bast_url": bastUrl == null ? null : bastUrl,
        "imei_url": imeiUrl == null ? null : imeiUrl,
        "is_admin_as_loan": isAdminAsLoan == null ? null : isAdminAsLoan,
        "tracking_exists": trackingExists == null ? null : trackingExists,
        "confirmation_methods": confirmationMethods == null
            ? null
            : List<dynamic>.from(confirmationMethods!.map((x) => x.toJson())),
      };
}

class ConfirmationMethodElement {
  ConfirmationMethodElement({
    this.merchantSupplierId,
    this.confirmationMethod,
  });

  String? merchantSupplierId;
  String? confirmationMethod;

  factory ConfirmationMethodElement.fromJson(Map<String, dynamic> json) =>
      ConfirmationMethodElement(
        merchantSupplierId: json["merchant_supplier_id"] == null
            ? null
            : json["merchant_supplier_id"],
        confirmationMethod: json["confirmation_method"] == null
            ? null
            : json["confirmation_method"],
      );

  Map<String, dynamic> toJson() => {
        "merchant_supplier_id":
            merchantSupplierId == null ? null : merchantSupplierId,
        "confirmation_method":
            confirmationMethod == null ? null : confirmationMethod,
      };
}

class TransactionPageInfo {
  TransactionPageInfo({
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

  factory TransactionPageInfo.fromJson(Map<String, dynamic> json) => TransactionPageInfo(
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
