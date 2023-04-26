class UserChangePasswordResponse {
  String? message;
  Data? data;

  UserChangePasswordResponse({this.message, this.data});

  UserChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? message;

  Data({this.message});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
