class BaseResponse<T> {
  T? data;
  Errors? errors;
  String? message;
  PageInfo? pageInfo;
  Status status;

  BaseResponse.loading() : status = Status.LOADING;

  BaseResponse.completed(this.data) : status = Status.COMPLETED;

  BaseResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

class Errors {
  String? field;
  String? message;

  Errors({this.field, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
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
