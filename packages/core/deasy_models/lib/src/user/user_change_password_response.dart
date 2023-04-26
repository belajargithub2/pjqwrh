class UserChangePasswordResponse {
  String? message;
  ChangePasswordData? data;

  UserChangePasswordResponse({this.message, this.data});

  UserChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ChangePasswordData.fromJson(json['data']) : null;
  }
}

class ChangePasswordData {
  String? message;

  ChangePasswordData({this.message});

  ChangePasswordData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
