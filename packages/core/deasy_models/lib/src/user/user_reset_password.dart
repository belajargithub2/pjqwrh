
import 'dart:convert';

ResetPasswordResponse resetPasswordResponseFromJson(String str) => ResetPasswordResponse.fromJson(json.decode(str));

String resetPasswordResponseToJson(ResetPasswordResponse data) => json.encode(data.toJson());

class ResetPasswordResponse {
  ResetPasswordResponse({
    this.data,
    this.error,
    this.errors,
    this.message,
    this.pageInfo,
  });

  ResetPasswordData? data;
  ResetPasswordError? error;
  ResetPasswordError? errors;
  String? message;
  ResetPasswordPageInfo? pageInfo;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    data: json["data"] == null ? null : ResetPasswordData.fromJson(json["data"]),
    error: json["error"] == null ? null : ResetPasswordError.fromJson(json["error"]),
    errors: json["errors"] == null ? null : ResetPasswordError.fromJson(json["errors"]),
    message: json["message"] == null ? null : json["message"],
    pageInfo: json["page_info"] == null ? null : ResetPasswordPageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "error": error == null ? null : error!.toJson(),
    "errors": errors == null ? null : errors!.toJson(),
    "message": message == null ? null : message,
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class ResetPasswordData {
  ResetPasswordData({
    this.email,
    this.status,
  });

  String? email;
  String? status;

  factory ResetPasswordData.fromJson(Map<String, dynamic> json) => ResetPasswordData(
    email: json["email"] == null ? null : json["email"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "status": status == null ? null : status,
  };
}

class ResetPasswordError {
  ResetPasswordError();

  factory ResetPasswordError.fromJson(Map<String, dynamic>? json) => ResetPasswordError(
  );

  Map<String, dynamic> toJson() => {
  };
}

class ResetPasswordPageInfo {
  ResetPasswordPageInfo({
    this.limit,
    this.nextPage,
    this.offset,
    this.page,
    this.prevPage,
    this.totalPage,
    this.totalRecord,
  });

  int? limit;
  int? nextPage;
  int? offset;
  int? page;
  int? prevPage;
  int? totalPage;
  int? totalRecord;

  factory ResetPasswordPageInfo.fromJson(Map<String, dynamic> json) => ResetPasswordPageInfo(
    limit: json["limit"] == null ? null : json["limit"],
    nextPage: json["next_page"] == null ? null : json["next_page"],
    offset: json["offset"] == null ? null : json["offset"],
    page: json["page"] == null ? null : json["page"],
    prevPage: json["prev_page"] == null ? null : json["prev_page"],
    totalPage: json["total_page"] == null ? null : json["total_page"],
    totalRecord: json["total_record"] == null ? null : json["total_record"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "next_page": nextPage == null ? null : nextPage,
    "offset": offset == null ? null : offset,
    "page": page == null ? null : page,
    "prev_page": prevPage == null ? null : prevPage,
    "total_page": totalPage == null ? null : totalPage,
    "total_record": totalRecord == null ? null : totalRecord,
  };
}
