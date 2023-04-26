class NotificationCountResponse {
  NotificationCountResponse({
    this.message,
    this.notificationCountData,
  });

  String? message;
  NotificationCountData? notificationCountData;

  factory NotificationCountResponse.fromJson(Map<String, dynamic> json) => NotificationCountResponse(
    message: json["message"] == null ? null : json["message"],
    notificationCountData: json["data"] == null ? null :
      NotificationCountData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": notificationCountData == null ? null : notificationCountData!.toJson(),
  };
}

class NotificationCountData {
  NotificationCountData({
    this.count,
  });

  int? count;

  factory NotificationCountData.fromJson(Map<String, dynamic> json) => NotificationCountData(
    count: json["count"] == null ? null : json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
  };
}