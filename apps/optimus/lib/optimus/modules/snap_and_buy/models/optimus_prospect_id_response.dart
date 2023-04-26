class ProspectIdResponse {
  String? message;
  ProspectIdData? data;

  ProspectIdResponse({this.message, this.data});

  ProspectIdResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ProspectIdData.fromJson(json['data']) : null;
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

class ProspectIdData {
  String? prospectId;

  ProspectIdData({this.prospectId});

  ProspectIdData.fromJson(Map<String, dynamic> json) {
    prospectId = json['prospect_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospect_id'] = this.prospectId;
    return data;
  }
}