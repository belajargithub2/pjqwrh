import 'package:deasy_models/src/merchant/merchant_list_response.dart';
import 'package:deasy_models/src/role_management/role_management_response.dart';

class UserCreateResponse {
  String? message;
  UserCreateData? data;

  UserCreateResponse({this.message, this.data});

  UserCreateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new UserCreateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserCreateData {
  String? deletedAt;
  String? email;
  String? createdAt;
  String? fcmtoken;
  String? id;
  String? name;
  String? password;
  String? phoneNumber;
  RoleManagementData? role;
  MerchantData? supplier;
  String? updatedAt;
  String? verifiedAt;

  UserCreateData(
      {this.createdAt,
        this.deletedAt,
        this.email,
        this.fcmtoken,
        this.id,
        this.name,
        this.password,
        this.phoneNumber,
        this.role,
        this.supplier,
        this.updatedAt,
        this.verifiedAt});

  UserCreateData.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    email = json['email'];
    fcmtoken = json['fcmtoken'];
    id = json['id'];
    name = json['name'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    role = json['role'] != null
        ? new RoleManagementData.fromJson(json['role'])
        : null;
    supplier = json['supplier'] != null
        ? new MerchantData.fromJson(json['supplier'])
        : null;
    updatedAt = json['updated_at'];
    verifiedAt = json['verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    data['email'] = this.email;
    data['fcmtoken'] = this.fcmtoken;
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    data['phone_number'] = this.phoneNumber;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.supplier != null) {
      data['supplier'] = this.supplier!.toJson();
    }
    data['updated_at'] = this.updatedAt;
    data['verified_at'] = this.verifiedAt;
    return data;
  }
}
