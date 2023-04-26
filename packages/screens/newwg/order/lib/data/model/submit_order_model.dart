import 'dart:convert';

SubmitOrderModel submitOrderModelFromJson(String str) => SubmitOrderModel.fromJson(json.decode(str));

String submitOrderModelToJson(SubmitOrderModel data) => json.encode(data.toJson());

class SubmitOrderModel {
  SubmitOrderModel({
    this.messages,
    this.data,
    this.errors,
    this.code,
  });

  String? messages;
  SubmitOrderData? data;
  dynamic errors;
  int? code;

  factory SubmitOrderModel.fromJson(Map<String, dynamic> json) => SubmitOrderModel(
    messages: json["messages"],
    data: json["data"] == null ? null : SubmitOrderData.fromJson(json["data"]),
    errors: json["errors"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "messages": messages,
    "data": data?.toJson(),
    "errors": errors,
    "code": code,
  };
}

class SubmitOrderData {
  SubmitOrderData();

  factory SubmitOrderData.fromJson(Map<String, dynamic> json) => SubmitOrderData(
  );

  Map<String, dynamic> toJson() => {
  };
}
