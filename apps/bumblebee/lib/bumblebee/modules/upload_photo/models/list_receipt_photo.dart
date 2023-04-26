import 'dart:convert';

ListReceiptPhotoResponse listReceiptPhotoResponseFromJson(String str) => ListReceiptPhotoResponse.fromJson(json.decode(str));

String listReceiptPhotoResponseToJson(ListReceiptPhotoResponse data) => json.encode(data.toJson());

class ListReceiptPhotoResponse {
  ListReceiptPhotoResponse({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory ListReceiptPhotoResponse.fromJson(Map<String, dynamic> json) => ListReceiptPhotoResponse(
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
    this.buktiTerima,
  });

  List<BuktiTerima>? buktiTerima;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    buktiTerima: json["bukti_terima"] == null ? null : List<BuktiTerima>.from(json["bukti_terima"].map((x) => BuktiTerima.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bukti_terima": buktiTerima == null ? null : List<dynamic>.from(buktiTerima!.map((x) => x.toJson())),
  };
}

class BuktiTerima {
  BuktiTerima({
    this.prospectId,
    this.orderDate,
    this.otr,
  });

  String? prospectId;
  DateTime? orderDate;
  double? otr;

  factory BuktiTerima.fromJson(Map<String, dynamic> json) => BuktiTerima(
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
