import 'dart:convert';

OptimusHistoriesLoginResponse historiesLoginResponseFromJson(String str) => OptimusHistoriesLoginResponse.fromJson(json.decode(str));

String historiesLoginResponseToJson(OptimusHistoriesLoginResponse data) => json.encode(data.toJson());

class OptimusHistoriesLoginResponse {
  OptimusHistoriesLoginResponse({
    this.code,
    this.data,
    this.error,
    this.errors,
    this.message,
    this.pageInfo,
  });

  int? code;
  Data? data;
  String? error;
  String? errors;
  String? message;
  PageInfo? pageInfo;

  factory OptimusHistoriesLoginResponse.fromJson(Map<String, dynamic> json) => OptimusHistoriesLoginResponse(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"] == null ? null : json["error"],
    errors: json["errors"] == null ? null : json["errors"],
    message: json["message"] == null ? null : json["message"],
    pageInfo: json["page_info"] == null ? null : PageInfo.fromJson(json["page_info"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data!.toJson(),
    "error": error == null ? null : error,
    "errors": errors == null ? null : errors,
    "message": message == null ? null : message,
    "page_info": pageInfo == null ? null : pageInfo!.toJson(),
  };
}

class Data {
  Data({
    this.osVersion,
    this.apiVersion,
    this.appsVersion,
    this.browserType,
    this.browserVersion,
    this.createdAt,
    this.deviceId,
    this.deviceModel,
    this.email,
    this.id,
    this.isMobile,
    this.latitude,
    this.loginDate,
    this.logoutDate,
    this.longitude,
    this.phoneNumber,
    this.updatedAt,
  });

  String? osVersion;
  String? apiVersion;
  String? appsVersion;
  String? browserType;
  String? browserVersion;
  String? createdAt;
  String? deviceId;
  String? deviceModel;
  String? email;
  int? id;
  bool? isMobile;
  double? latitude;
  String? loginDate;
  String? logoutDate;
  double? longitude;
  String? phoneNumber;
  String? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    osVersion: json["OSVersion"] == null ? null : json["OSVersion"],
    apiVersion: json["api_version"] == null ? null : json["api_version"],
    appsVersion: json["apps_version"] == null ? null : json["apps_version"],
    browserType: json["browser_type"] == null ? null : json["browser_type"],
    browserVersion: json["browser_version"] == null ? null : json["browser_version"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    deviceId: json["device_id"] == null ? null : json["device_id"],
    deviceModel: json["device_model"] == null ? null : json["device_model"],
    email: json["email"] == null ? null : json["email"],
    id: json["id"] == null ? null : json["id"],
    isMobile: json["is_mobile"] == null ? null : json["is_mobile"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    loginDate: json["login_date"] == null ? null : json["login_date"],
    logoutDate: json["logout_date"] == null ? null : json["logout_date"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "OSVersion": osVersion == null ? null : osVersion,
    "api_version": apiVersion == null ? null : apiVersion,
    "apps_version": appsVersion == null ? null : appsVersion,
    "browser_type": browserType == null ? null : browserType,
    "browser_version": browserVersion == null ? null : browserVersion,
    "created_at": createdAt == null ? null : createdAt,
    "device_id": deviceId == null ? null : deviceId,
    "device_model": deviceModel == null ? null : deviceModel,
    "email": email == null ? null : email,
    "id": id == null ? null : id,
    "is_mobile": isMobile == null ? null : isMobile,
    "latitude": latitude == null ? null : latitude,
    "login_date": loginDate == null ? null : loginDate,
    "logout_date": logoutDate == null ? null : logoutDate,
    "longitude": longitude == null ? null : longitude,
    "phone_number": phoneNumber == null ? null : phoneNumber,
    "updated_at": updatedAt == null ? null : updatedAt,
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
