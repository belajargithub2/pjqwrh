class OptimusRegisterMerchantExistResponse {
  int? code;
  String? message;
  Data? data;

  OptimusRegisterMerchantExistResponse({this.code, this.message, this.data});

  OptimusRegisterMerchantExistResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  bool? isExists;

  Data({this.isExists});

  Data.fromJson(Map<String, dynamic> json) {
    isExists = json['is_exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_exists'] = this.isExists;
    return data;
  }
}