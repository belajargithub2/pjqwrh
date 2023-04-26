import 'dart:convert';

ListImeiResponse listImeiResponseFromJson(String str) => ListImeiResponse.fromJson(json.decode(str));

String listImeiResponseToJson(ListImeiResponse data) => json.encode(data.toJson());

class ListImeiResponse {
  ListImeiResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ListImeiResponse.fromJson(Map<String, dynamic> json) => ListImeiResponse(
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.imei,
  });

  List<Imei>? imei;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imei: json["imei"] == null ? null : List<Imei>.from(json["imei"].map((x) => Imei.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "imei": imei == null ? null : List<dynamic>.from(imei!.map((x) => x.toJson())),
      };
}

class Imei {
  Imei({
    this.prospectId,
    this.orderDate,
    this.otr,
  });

  String? prospectId;
  DateTime? orderDate;
  double? otr;

  factory Imei.fromJson(Map<String, dynamic> json) => Imei(
        prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
        orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
        otr: json["otr"] == null ? null : json["otr"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "prospect_id": prospectId == null ? null : prospectId,
        "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
        "otr": otr == null ? null : otr,
      };
}
