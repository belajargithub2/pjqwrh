import 'dart:convert';

String otpRequestToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
  OtpRequest({
    required this.phoneNumber,
    required this.type,
  });

  String phoneNumber;
  String type;

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "type": type,
      };
}
