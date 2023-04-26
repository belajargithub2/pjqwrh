import 'dart:convert';

SettingsResponse settingsResponseFromJson(String str) =>
    SettingsResponse.fromJson(json.decode(str));

class SettingsResponse {
  SettingsResponse({
    this.message,
    this.data,
  });

  String? message;
  SettingsData? data;

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      SettingsResponse(
        message: json["message"],
        data: SettingsData.fromJson(json["data"]),
      );
}

class SettingsData {
  SettingsData({
    this.appName,
    this.appVersion,
  });

  String? appName;
  String? appVersion;

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
        appName: json["app_name"],
        appVersion: json["app_version"],
      );
}
