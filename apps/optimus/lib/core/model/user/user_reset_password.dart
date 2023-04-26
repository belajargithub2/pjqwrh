
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

  Data? data;
  Error? error;
  Error? errors;
  String? message;
  PageInfo? pageInfo;

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) => ResetPasswordResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
    errors: json["errors"] == null ? null : Error.fromJson(json["errors"]),
    message: json["message"] == null ? null : json["message"],
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "error": error == null ? null : error!.toJson(),
    "errors": errors == null ? null : errors!.toJson(),
    "message": message == null ? null : message,
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class Data {
  Data({
    this.email,
    this.status,
  });

  String? email;
  String? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    email: json["email"] == null ? null : json["email"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "status": status == null ? null : status,
  };
}

class Error {
  Error();

  factory Error.fromJson(Map<String, dynamic>? json) => Error(
  );

  Map<String, dynamic> toJson() => {
  };
}

class PageInfo {
  PageInfo({
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

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
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
