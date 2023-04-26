class OptimusECommerceClientKeyListResponse {
  String? message;
  List<ECommerceClientKeyData>? eCommerceClientKeyData;
  PageInfo? pageInfo;

  OptimusECommerceClientKeyListResponse(
      {this.message, this.eCommerceClientKeyData, this.pageInfo});

  OptimusECommerceClientKeyListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      eCommerceClientKeyData =
          new List<ECommerceClientKeyData>.empty(growable: true);
      json['data'].forEach((v) {
        eCommerceClientKeyData!.add(new ECommerceClientKeyData.fromJson(v));
      });
    }
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.eCommerceClientKeyData != null) {
      data['data'] =
          this.eCommerceClientKeyData!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class ECommerceClientKeyData {
  String? supplierId;
  String? key;
  String? name;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? callbackUrlOrder;
  String? createdAt;
  String? updatedAt;

  ECommerceClientKeyData(
      {this.supplierId,
      this.key,
      this.name,
      this.callbackUrlSignature,
      this.callbackUrlStatus,
      this.callbackUrlOrder,
      this.createdAt,
      this.updatedAt});

  ECommerceClientKeyData.fromJson(Map<String, dynamic> json) {
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

class PageInfo {
  int? totalRecord;
  int? totalPage;
  int? offset;
  int? limit;
  int? page;
  int? prevPage;
  int? nextPage;

  PageInfo(
      {this.totalRecord,
      this.totalPage,
      this.offset,
      this.limit,
      this.page,
      this.prevPage,
      this.nextPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalRecord = json['total_record'];
    totalPage = json['total_page'];
    offset = json['offset'];
    limit = json['limit'];
    page = json['page'];
    prevPage = json['prev_page'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_record'] = this.totalRecord;
    data['total_page'] = this.totalPage;
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['prev_page'] = this.prevPage;
    data['next_page'] = this.nextPage;
    return data;
  }
}
