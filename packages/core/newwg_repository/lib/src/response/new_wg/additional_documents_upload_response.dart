class AdditionalDocumentsUploadResponse {
  int? code;
  String? message;
  Data? data;
  Errors? errors;

  AdditionalDocumentsUploadResponse({
    this.code,
    this.message,
    this.data,
    this.errors,
  });

  AdditionalDocumentsUploadResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datas = <String, dynamic>{};
    datas['code'] = code;
    datas['message'] = message;
    if (data != null) {
      datas['data'] = data!.toJson();
    }
    if (errors != null) {
      datas['errors'] = errors!.toJson();
    }
    return datas;
  }
}

class Data {
  String? mediaUrl;

  Data({this.mediaUrl});

  Data.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_url'] = mediaUrl;
    return data;
  }
}

class Errors {
  int? code;
  String? message;

  Errors({this.code, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
