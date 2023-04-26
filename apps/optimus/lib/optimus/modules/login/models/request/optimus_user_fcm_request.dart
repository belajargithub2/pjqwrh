class OptimusUserFcmRequest {
  String? supplierId;
  String? token;
  String? userId;

  OptimusUserFcmRequest(
      {this.supplierId,
        this.token,
        this.userId
      });

  OptimusUserFcmRequest.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}