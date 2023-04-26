import 'dart:convert';

DealerGroupListResponse dealerGroupListResponseFromJson(String str) => DealerGroupListResponse.fromJson(json.decode(str));

String dealerGroupListResponseToJson(DealerGroupListResponse data) => json.encode(data.toJson());

class DealerGroupListResponse {
  DealerGroupListResponse({
    this.message,
    this.dealerGroupListData
  });

  String? message;
  List<String>? dealerGroupListData;

  factory DealerGroupListResponse.fromJson(Map<String, dynamic> json) => DealerGroupListResponse(
    message: json["message"] == null ? null : json["message"],
    dealerGroupListData: json["data"] == null ? null : List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": dealerGroupListData == null ? null : List<dynamic>.from(dealerGroupListData!.map((x) => x)),
  };
}
