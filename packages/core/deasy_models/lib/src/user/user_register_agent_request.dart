import 'package:meta/meta.dart';
import 'dart:convert';

String userRegisterAgentRequestToJson(UserRegisterAgentRequest data) =>
    json.encode(data.toJson());

class UserRegisterAgentRequest {
  UserRegisterAgentRequest({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.userType,
    required this.nik,
    required this.isAgent,
    required this.createPasswordUrl,
    this.token,
  });

  String? name;
  String? phoneNumber;
  String? email;
  String? userType;
  String? nik;
  bool? isAgent;
  String? createPasswordUrl;
  String? token;

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "user_type": userType == null ? null : userType,
        "nik": nik == null ? null : nik,
        "is_agent": isAgent == null ? null : isAgent,
        "create_password_url":
            createPasswordUrl == null ? null : createPasswordUrl,
        "token": token,
      };
}
