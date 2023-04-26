class RegisterMerchantExistResponse {
  int? code;
  String? message;
  RegisterMerchantExistData? data;

  RegisterMerchantExistResponse({this.code, this.message, this.data});

  RegisterMerchantExistResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new RegisterMerchantExistData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RegisterMerchantExistData {
  bool? isExists;

  RegisterMerchantExistData({this.isExists});

  RegisterMerchantExistData.fromJson(Map<String, dynamic> json) {
    isExists = json['is_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_exists'] = this.isExists;
    return data;
  }
}
