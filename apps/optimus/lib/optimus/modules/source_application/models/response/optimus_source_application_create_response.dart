class OptimusSourceAppCreateResponse {
  SourceAppCreateData? sourceAppData;
  String? message;

  OptimusSourceAppCreateResponse({this.sourceAppData, this.message});

  OptimusSourceAppCreateResponse.fromJson(Map<String, dynamic> json) {
    sourceAppData = json['data'] != null ? new SourceAppCreateData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sourceAppData != null) {
      data['data'] = this.sourceAppData!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class SourceAppCreateData {
  String? id;
  String? sourceApplication;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? callbackUrlOrder;
  String? createdAt;
  String? updatedAt;

  SourceAppCreateData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sourceApplication,
    this.callbackUrlSignature,
    this.callbackUrlStatus,
    this.callbackUrlOrder
  });

  SourceAppCreateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sourceApplication = json['source_application'];
    callbackUrlSignature = json['callback_url_signature'];
    callbackUrlStatus = json['callback_url_status'];
    callbackUrlOrder = json['callback_url_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['source_application'] = this.sourceApplication;
    data['callback_url_signature'] = this.callbackUrlSignature;
    data['callback_url_status'] = this.callbackUrlStatus;
    data['callback_url_order'] = this.callbackUrlOrder;
    return data;
  }
}
