import 'package:meta/meta.dart';

class DeleteAccountResponse {
  DeleteAccountResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  int? code;
  String? message;
  DeleteAccountResponseData? data;

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) => DeleteAccountResponse(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DeleteAccountResponseData.fromJson(json["data"]),
  );

}

class DeleteAccountResponseData {
  DeleteAccountResponseData({
    required this.isPending,
    required this.message,
  });

  bool? isPending;
  String? message;

  factory DeleteAccountResponseData.fromJson(Map<String, dynamic> json) => DeleteAccountResponseData(
    isPending: json["is_pending"] == null ? null : json["is_pending"],
    message: json["message"] == null ? null : json["message"],
  );


}
