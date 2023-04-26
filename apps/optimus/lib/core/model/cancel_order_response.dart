class CancelOrderResponse {
  String? message;
  Data? data;

  CancelOrderResponse({this.message, this.data});

  CancelOrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? prospectId;
  String? reason;

  Data({this.prospectId, this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    prospectId = json['prospect_id'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospect_id'] = this.prospectId;
    data['reason'] = this.reason;
    return data;
  }
}