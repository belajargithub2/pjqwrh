import 'dart:convert';

String subsidiesRequestToJson(OptimusSubsidiesRequest data) => json.encode(data.toJson());

class OptimusSubsidiesRequest {
  OptimusSubsidiesRequest({
    required this.orderDateFrom,
    required this.orderDateTo,
    required this.orderStatus,
    required this.orderId,
    required this.page,
  });

  String? orderDateFrom;
  String? orderDateTo;
  List<String> orderStatus;
  String orderId;
  int page;

  Map<String, dynamic> toJson() => {
    "order_date_from": orderDateFrom == null ? null : orderDateFrom,
    "order_date_to": orderDateTo == null ? null : orderDateTo,
    "order_status": orderStatus == null ? null : List<dynamic>.from(orderStatus.map((x) => x)),
    "order_id": orderId == null ? null : orderId,
    "page": page == null ? null : page,
  };
}

