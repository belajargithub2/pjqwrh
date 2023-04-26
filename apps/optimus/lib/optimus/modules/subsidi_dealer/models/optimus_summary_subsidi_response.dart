import 'dart:convert';

OptimusSummarySubsidiResponse summarySubsidiResponseFromJson(String str) =>
    OptimusSummarySubsidiResponse.fromJson(json.decode(str));

String summarySubsidiResponseToJson(OptimusSummarySubsidiResponse data) =>
    json.encode(data.toJson());

class OptimusSummarySubsidiResponse {
  OptimusSummarySubsidiResponse({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory OptimusSummarySubsidiResponse.fromJson(Map<String, dynamic> json) =>
      OptimusSummarySubsidiResponse(
        code: json["code"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code ?? null,
        "message": message ?? null,
        "data": data == null ? null : data!.toJson()
      };
}

class Data {
  Data({
    this.otr,
    this.ntfAmount,
    this.subsidiAmount,
    this.totalOtr,
    this.aprovedCount,
  });

  int? otr;
  int? ntfAmount;
  int? subsidiAmount;
  int? totalOtr;
  int? aprovedCount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        otr: json["otr"] ?? 0,
        ntfAmount: json["ntf_amount"] ?? 0,
        subsidiAmount: json["subsidi_amount"] ?? 0,
        totalOtr: json["total_otr"] ?? 0,
        aprovedCount: json["aproved_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "otr": otr ?? 0,
        "ntf_amount": ntfAmount ?? 0,
        "subsidi_amount": subsidiAmount ?? 0,
        "total_otr": totalOtr ?? 0,
        "aproved_count": aprovedCount ?? 0,
      };
}
