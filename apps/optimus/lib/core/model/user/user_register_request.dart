import 'dart:convert';

UserRegisterRequest UserRegisterRequestFromJson(String str) => UserRegisterRequest.fromJson(json.decode(str));

String UserRegisterRequestToJson(UserRegisterRequest data) => json.encode(data.toJson());

class UserRegisterRequest {
  UserRegisterRequest({
    this.token,
    this.city,
    this.createPasswordUrl,
    this.district,
    this.email,
    this.name,
    this.phoneNumber,
    this.province,
    this.rt,
    this.rw,
    this.supplierId,
    this.village,
    this.zipCode,
    this.merchantType,
    this.isAgent
  });

  String? token;
  String? city;
  String? createPasswordUrl;
  String? district;
  String? email;
  String? merchantAddress;
  String? name;
  String? phoneNumber;
  String? province;
  String? rt;
  String? rw;
  String? supplierId;
  String? village;
  String? zipCode;
  String? merchantType;
  bool? isAgent;

  factory UserRegisterRequest.fromJson(Map<String, dynamic> json) => UserRegisterRequest(
    city: json["city"],
    token: json["token"],
    createPasswordUrl: json["create_password_url"],
    district: json["district"],
    email: json["email"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    province: json["province"],
    rt: json["rt"],
    rw: json["rw"],
    supplierId: json["supplier_id"],
    village: json["village"],
    zipCode: json["zip_code"],
    merchantType: json["merchant_type"],
    isAgent: json["is_agent"]
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "city": city,
    "create_password_url": createPasswordUrl,
    "district": district,
    "email": email,
    "merchant_address": merchantAddress,
    "name": name,
    "phone_number": phoneNumber,
    "province": province,
    "rt": rt,
    "rw": rw,
    "supplier_id": supplierId,
    "village": village,
    "zip_code": zipCode,
    "merchant_type" : merchantType,
    "is_agent" : isAgent
  };
}
