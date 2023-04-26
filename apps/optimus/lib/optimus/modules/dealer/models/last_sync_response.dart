import 'dart:convert';

LastSyncResponse lastSyncResponseFromJson(String str) => LastSyncResponse.fromJson(json.decode(str));

String lastSyncResponseToJson(LastSyncResponse data) => json.encode(data.toJson());

class LastSyncResponse {
  LastSyncResponse({
    this.message,
    this.lastSyncData
  });

  String? message;
  LastSyncData? lastSyncData;

  factory LastSyncResponse.fromJson(Map<String, dynamic> json) => LastSyncResponse(
    message: json["message"] == null ? null : json["message"],
    lastSyncData: json["data"] == null ? null : LastSyncData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": lastSyncData == null ? null : lastSyncData!.toJson(),
  };
}

class LastSyncData {
  LastSyncData({
    this.syncDate
  });

  String? syncDate;

  factory LastSyncData.fromJson(Map<String, dynamic> json) => LastSyncData(
    syncDate: json["sync_date"] == null ? null : json["sync_date"],
  );

  Map<String, dynamic> toJson() => {
    "sync_date": syncDate == null ? null : syncDate,
  };
}