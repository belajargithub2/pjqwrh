import 'dart:convert';

CallbackListResponse callbackListResponseFromJson(String str) => CallbackListResponse.fromJson(json.decode(str));

String callbackListResponseToJson(CallbackListResponse data) => json.encode(data.toJson());

class CallbackListResponse {
  CallbackListResponse({
    this.callbackData,
    this.message,
    this.pageInfo
  });

  List<CallbackData>? callbackData;
  String? message;
  PageInfo? pageInfo;

  factory CallbackListResponse.fromJson(Map<String, dynamic> json) => CallbackListResponse(
    message: json["message"] == null ? null : json["message"],
    callbackData: json["data"] == null ? null :
      List<CallbackData>.from(json["data"].map((x) => CallbackData.fromJson(x))),
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": callbackData == null ? null : List<dynamic>.from(callbackData!.map((x) => x.toJson())),
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class CallbackData {
  CallbackData({
    this.createdAt,
    this.merchantStatusCode,
    this.orderNotes,
    this.orderStatus,
    this.prospectId,
    this.sourceApplication,
  });

  String? createdAt;
  int? merchantStatusCode;
  String? orderNotes;
  String? orderStatus;
  String? prospectId;
  String? sourceApplication;

  factory CallbackData.fromJson(Map<String, dynamic> json) => CallbackData(
    createdAt: json["created_at"] == null ? null : json["created_at"],
    merchantStatusCode: json["merchant_status_code"] == null ? null : json["merchant_status_code"],
    orderNotes: json["order_notes"] == null ? null : json["order_notes"],
    orderStatus: json["order_status"] == null ? null : json["order_status"],
    prospectId: json["prospect_id"] == null ? null : json["prospect_id"],
    sourceApplication: json["source_application"] == null ? null : json["source_application"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt == null ? null : createdAt,
    "merchant_status_code": merchantStatusCode == null ? null : merchantStatusCode,
    "order_notes": orderNotes == null ? null : orderNotes,
    "order_status": orderStatus == null ? null : orderStatus,
    "prospect_id": prospectId == null ? null : prospectId,
    "source_application": sourceApplication == null ? null : sourceApplication,
  };
}

class PageInfo {
  PageInfo({
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

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
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