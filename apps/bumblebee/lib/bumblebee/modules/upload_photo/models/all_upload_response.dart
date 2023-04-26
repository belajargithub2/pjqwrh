import 'dart:convert';

AllUploadResponse allUploadResponseFromJson(String str) => AllUploadResponse.fromJson(json.decode(str));

String allUploadResponseToJson(AllUploadResponse data) => json.encode(data.toJson());

class AllUploadResponse {
  AllUploadResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory AllUploadResponse.fromJson(Map<String, dynamic> json) => AllUploadResponse(
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
    this.bast,
    this.buktiTerima,
    this.imei
  });

  List<Bast>? bast;
  List<Bast>? buktiTerima;
  List<Bast>? imei;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bast: json["bast"] == null ? null : List<Bast>.from(json["bast"].map((x) => Bast.fromJson(x))),
    buktiTerima: json["bukti_terima"] == null ? null : List<Bast>.from(json["bukti_terima"].map((x) => Bast.fromJson(x))),
    imei: json["imei"] == null ? null : List<Bast>.from(json["imei"].map((x) => Bast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bast": bast == null ? null : List<dynamic>.from(bast!.map((x) => x.toJson())),
    "bukti_terima": buktiTerima == null ? null : List<dynamic>.from(buktiTerima!.map((x) => x.toJson())),
    "imei": imei == null ? null : List<dynamic>.from(imei!.map((x) => x.toJson())),
  };
}

class Bast {
  Bast({
    this.prospectId,
    this.orderDate,
    this.otr,
  });

  String? prospectId;
  DateTime? orderDate;
  int? otr;

  factory Bast.fromJson(Map<String, dynamic> json) => Bast(
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    otr: json["otr"] == null ? null : json["otr"],
  );

  Map<String, dynamic> toJson() => {
    "prospect_id": prospectId == null ? null : prospectId,
    "order_date": orderDate == null ? null : orderDate!.toIso8601String(),
    "otr": otr == null ? null : otr,
  };
}
