

class ReportIncomingWebResponse {
  ReportIncomingWebResponse({
    this.message,
    this.data,
  });

  String? message;
  DataIncomingTransaction? data;

  factory ReportIncomingWebResponse.fromJson(Map<String, dynamic> json) => ReportIncomingWebResponse(
    message: json["message"],
    data: DataIncomingTransaction.fromJson(json["data"]),
  );


}

class DataIncomingTransaction {
  DataIncomingTransaction({
    this.dayQty,
    this.dayValue,
    this.monthQty,
    this.monthValue,
    this.yearQty,
    this.yearValue,
  });

  int? dayQty;
  int? dayValue;
  int? monthQty;
  int? monthValue;
  int? yearQty;
  int? yearValue;

  factory DataIncomingTransaction.fromJson(Map<String, dynamic> json) => DataIncomingTransaction(
    dayQty: json["day_qty"],
    dayValue: json["day_value"],
    monthQty: json["month_qty"],
    monthValue: json["month_value"],
    yearQty: json["year_qty"],
    yearValue: json["year_value"],
  );

}
