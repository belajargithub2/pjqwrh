class CallbackDetailResponse {
  String? message;
  List<CallbackDetailData>? callbackDetailData;

  CallbackDetailResponse({this.message, this.callbackDetailData});

  CallbackDetailResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      callbackDetailData = new List<CallbackDetailData>.empty(growable: true);
      json['data'].forEach((v) {
        callbackDetailData!.add(new CallbackDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.callbackDetailData != null) {
      data['data'] = this.callbackDetailData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CallbackDetailData {
  String? prospectId;
  String? callbackUrl;
  RequestPayload? requestPayload;
  ResponsePayload? responsePayload;
  String? tipe;
  int? status;
  String? createdAt;
  String? updatedAt;

  CallbackDetailData({
    this.prospectId,
    this.callbackUrl,
    this.requestPayload,
    this.responsePayload,
    this.tipe,
    this.status,
    this.createdAt,
    this.updatedAt
  });

  CallbackDetailData.fromJson(Map<String, dynamic> json) {
    prospectId = json['prospect_id'];
    callbackUrl = json['callback_url'];
    requestPayload = json['request_payload'] != null
        ? new RequestPayload.fromJson(json['request_payload'])
        : null;
    responsePayload = json['response_payload'] != null
        ? new ResponsePayload.fromJson(json['response_payload'])
        : null;
    tipe = json['tipe'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospect_id'] = this.prospectId;
    data['callback_url'] = this.callbackUrl;
    if (this.requestPayload != null) {
      data['request_payload'] = this.requestPayload!.toJson();
    }
    if (this.responsePayload != null) {
      data['response_payload'] = this.responsePayload!.toJson();
    }
    data['tipe'] = this.tipe;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    
    return data;
  }
}

class RequestPayload {
  String? notes;
  String? orderStatus;
  String? orderStatusCode;
  String? prospectId;

  RequestPayload({
    this.notes,
    this.orderStatus,
    this.orderStatusCode,
    this.prospectId
  });

  RequestPayload.fromJson(Map<String, dynamic> json) {
    notes = json['notes'];
    orderStatus = json['order_status'];
    orderStatusCode = json['order_status_code'];
    prospectId = json['prospect_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes'] = this.notes;
    data['order_status'] = this.orderStatus;
    data['order_status_code'] = this.orderStatusCode;
    data['prospect_id'] = this.prospectId;
    
    return data;
  }
}

class ResponsePayload {
  PayloadData? data;
  int? code;

  ResponsePayload({
    this.data,
    this.code
  });

  ResponsePayload.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new PayloadData.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    
    return data;
  }
}

class PayloadData {
  String? message;

  PayloadData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    
    return data;
  }
}