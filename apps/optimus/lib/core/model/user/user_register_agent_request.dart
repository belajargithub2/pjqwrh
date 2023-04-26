import 'package:meta/meta.dart';
import 'dart:convert';

UserRegisterAgentRequest userRegisterAgentRequestFromJson(String str) =>
    UserRegisterAgentRequest.fromJson(json.decode(str));

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
  });

  String? name;
  String? phoneNumber;
  String? email;
  String? userType;
  String? nik;
  bool? isAgent;

  factory UserRegisterAgentRequest.fromJson(Map<String, dynamic> json) =>
      UserRegisterAgentRequest(
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        email: json["email"] == null ? null : json["email"],
        userType: json["user_type"] == null ? null : json["user_type"],
        nik: json["nik"] == null ? null : json["nik"],
        isAgent: json["is_agent"] == null ? null : json["is_agent"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "user_type": userType == null ? null : userType,
        "nik": nik == null ? null : nik,
        "is_agent": isAgent == null ? null : isAgent,
      };
}
