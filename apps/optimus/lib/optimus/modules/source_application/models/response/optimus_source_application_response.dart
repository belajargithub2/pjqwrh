class OptimusSourceAppResponse {
  List<SourceAppData>? listSourceAppData;
  String? message;
  PageInfo? pageInfo;

  OptimusSourceAppResponse({this.listSourceAppData, this.message});

  OptimusSourceAppResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      listSourceAppData = new List<SourceAppData>.empty(growable: true);
      json['data'].forEach((v) {
        listSourceAppData!.add(new SourceAppData.fromJson(v));
      });
    }
    message = json['message'];
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSourceAppData != null) {
      data['data'] = this.listSourceAppData!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class SourceAppData {
  String? id;
  String? sourceApplication;
  String? callbackUrlSignature;
  String? callbackUrlStatus;
  String? callbackUrlOrder;
  String? createdAt;
  String? updatedAt;

  SourceAppData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.sourceApplication,
    this.callbackUrlSignature,
    this.callbackUrlStatus,
    this.callbackUrlOrder
  });

  SourceAppData.fromJson(Map<String, dynamic> json) {
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

class PageInfo {
  int? limit;
  int? nextPage;
  int? offset;
  int? page;
  int? prevPage;
  int? totalPage;
  int? totalRecord;

  PageInfo(
      {this.limit,
        this.nextPage,
        this.offset,
        this.page,
        this.prevPage,
        this.totalPage,
        this.totalRecord});

  PageInfo.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    nextPage = json['next_page'];
    offset = json['offset'];
    page = json['page'];
    prevPage = json['prev_page'];
    totalPage = json['total_page'];
    totalRecord = json['total_record'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['next_page'] = this.nextPage;
    data['offset'] = this.offset;
    data['page'] = this.page;
    data['prev_page'] = this.prevPage;
    data['total_page'] = this.totalPage;
    data['total_record'] = this.totalRecord;
    return data;
  }
}
