class DocumentResponse {
  String? message;
  List<DocumentData>? data;

  DocumentResponse({this.message, this.data});

  DocumentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = new List<DocumentData>.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new DocumentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentData {
  String? prospectId;
  String? name;
  String? url;
  String? createdAt;
  String? createdBy;
  String? updatedAt;
  String? updatedBy;
  Null deletedAt;
  Null deletedBy;

  DocumentData(
      {this.prospectId,
        this.name,
        this.url,
        this.createdAt,
        this.createdBy,
        this.updatedAt,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy});

  DocumentData.fromJson(Map<String, dynamic> json) {
    prospectId = json['prospect_id'];
    name = json['name'];
    url = json['url'];
    createdAt = json['CreatedAt'];
    createdBy = json['CreatedBy'];
    updatedAt = json['UpdatedAt'];
    updatedBy = json['UpdatedBy'];
    deletedAt = json['DeletedAt'];
    deletedBy = json['DeletedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospect_id'] = this.prospectId;
    data['name'] = this.name;
    data['url'] = this.url;
    data['CreatedAt'] = this.createdAt;
    data['CreatedBy'] = this.createdBy;
    data['UpdatedAt'] = this.updatedAt;
    data['UpdatedBy'] = this.updatedBy;
    data['DeletedAt'] = this.deletedAt;
    data['DeletedBy'] = this.deletedBy;
    return data;
  }
}
