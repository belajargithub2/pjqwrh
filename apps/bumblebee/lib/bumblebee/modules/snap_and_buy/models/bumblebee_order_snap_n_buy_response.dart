class OrderSnapNBuyResponse {
  String? messages;
  OrderSnapNBuyData? data;

  OrderSnapNBuyResponse({this.messages, this.data});

  OrderSnapNBuyResponse.fromJson(Map<String, dynamic> json) {
    messages = json['messages'];
    data = json['data'] != null ? new OrderSnapNBuyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrderSnapNBuyData {
  String? ktpNo;
  String? mobilePhone;
  String? prospectId;
  int? shippingCost;
  String? type;

  OrderSnapNBuyData(
      {this.ktpNo,
        this.mobilePhone,
        this.prospectId,
        this.shippingCost,
        this.type});

  OrderSnapNBuyData.fromJson(Map<String, dynamic> json) {
    ktpNo = json['ktp_no'];
    mobilePhone = json['mobile_phone'];
    prospectId = json['prospect_id'];
    shippingCost = json['shipping_cost'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ktp_no'] = this.ktpNo;
    data['mobile_phone'] = this.mobilePhone;
    data['prospect_id'] = this.prospectId;
    data['shipping_cost'] = this.shippingCost;
    data['type'] = this.type;
    return data;
  }
}