import 'dart:convert';

ResponseGetAgentFee responseGetAgentFeeFromJson(String str) => ResponseGetAgentFee.fromJson(json.decode(str));

String responseGetAgentFeeToJson(ResponseGetAgentFee data) => json.encode(data.toJson());

class ResponseGetAgentFee {
    ResponseGetAgentFee({
        this.code,
        this.message,
        this.data,
        this.error,
    });

    dynamic code;
    String? message;
    ResponseGetAgentFeeData? data;
    bool? error;

    factory ResponseGetAgentFee.fromJson(Map<String, dynamic> json) => ResponseGetAgentFee(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : ResponseGetAgentFeeData.fromJson(json["data"]),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
        "error": error,
    };
}

class ResponseGetAgentFeeData {
    ResponseGetAgentFeeData({
        this.error,
        this.message,
        this.data,
        this.supplierId,
        this.supplierName,
        this.startDate,
        this.endDate,
        this.incentives,
    });

    bool? error;
    String? message;
    DataData? data;
    String? supplierId;
    String? supplierName;
    DateTime? startDate;
    DateTime? endDate;
    List<Incentive>? incentives;

    factory ResponseGetAgentFeeData.fromJson(Map<String, dynamic> json) => ResponseGetAgentFeeData(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        incentives: json["incentives"] == null ? [] : List<Incentive>.from(json["incentives"]!.map((x) => Incentive.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
        "supplier_id": supplierId,
        "supplier_name": supplierName,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "incentives": incentives == null ? [] : List<dynamic>.from(incentives!.map((x) => x.toJson())),
    };
}

class DataData {
    DataData({
        this.supplierId,
        this.supplierName,
        this.startDate,
        this.endDate,
        this.incentives,
    });

    String? supplierId;
    String? supplierName;
    DateTime? startDate;
    DateTime? endDate;
    List<Incentive>? incentives;

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        supplierId: json["supplier_id"],
        supplierName: json["supplier_name"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        incentives: json["incentives"] == null ? [] : List<Incentive>.from(json["incentives"]!.map((x) => Incentive.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "supplier_id": supplierId,
        "supplier_name": supplierName,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "incentives": incentives == null ? [] : List<dynamic>.from(incentives!.map((x) => x.toJson())),
    };
}

class Incentive {
    Incentive({
        this.agreementNo,
        this.customerName,
        this.assetCode,
        this.date,
        this.beforeTax,
        this.tax,
        this.afterTax,
        this.type,
        this.ntf,
        this.description,
    });

    String? agreementNo;
    String? customerName;
    String? assetCode;
    DateTime? date;
    int? beforeTax;
    int? tax;
    int? afterTax;
    String? type;
    double? ntf;
    String? description;

    factory Incentive.fromJson(Map<String, dynamic> json) => Incentive(
        agreementNo: json["agreement_no"],
        customerName: json["customer_name"],
        assetCode: json["asset_code"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        beforeTax: json["before_tax"],
        tax: json["tax"],
        afterTax: json["after_tax"],
        type: json["type"],
        ntf: json["ntf"]?.toDouble(),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "agreement_no": agreementNo,
        "customer_name": customerName,
        "asset_code": assetCode,
        "date": date?.toIso8601String(),
        "before_tax": beforeTax,
        "tax": tax,
        "after_tax": afterTax,
        "type": type,
        "ntf": ntf,
        "description": description,
    };
}