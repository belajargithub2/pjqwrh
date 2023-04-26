class ECommerceClientKeyCreateResponse {
  String? message;
  EcommerceCilentCreateData? data;

  ECommerceClientKeyCreateResponse({this.message, this.data});

  ECommerceClientKeyCreateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new EcommerceCilentCreateData.fromJson(json['data']) : null;
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

class EcommerceCilentCreateData {
  String? supplierId;
  String? key;
  String? name;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? callbackUrlOrder;
  String? createdAt;
  String? updatedAt;

  EcommerceCilentCreateData(
      {this.supplierId,
        this.key,
        this.name,
        this.callbackUrlSignature,
        this.callbackUrlStatus,
        this.callbackUrlOrder,
        this.createdAt,
        this.updatedAt});

  EcommerceCilentCreateData.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    key = json['key'];
    name = json['name'];
    callbackUrlSignature = json['callback_url_signature'];
    callbackUrlStatus = json['callback_url_status'];
    callbackUrlOrder = json['callback_url_order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['key'] = this.key;
    data['name'] = this.name;
    data['callback_url_signature'] = this.callbackUrlSignature;
    data['callback_url_status'] = this.callbackUrlStatus;
    data['callback_url_order'] = this.callbackUrlOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
