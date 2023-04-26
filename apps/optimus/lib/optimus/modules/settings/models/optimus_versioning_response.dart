class OptimusVersioningResponse {
  int? _code;
  String? _message;
  VersioningDataResponse? _data;

  OptimusVersioningResponse({int? code, String? message, VersioningDataResponse? data}) {
    if (code != null) {
      this._code = code;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  int? get code => _code;

  set code(int? code) => _code = code;

  String? get message => _message;

  set message(String? message) => _message = message;

  VersioningDataResponse? get data => _data;

  set data(VersioningDataResponse? data) => _data = data;

  OptimusVersioningResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null
        ? new VersioningDataResponse.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class VersioningDataResponse {
  String? _appName;
  String? _appVersion;

  VersioningDataResponse({String? appName, String? appVersion}) {
    if (appName != null) {
      this._appName = appName;
    }
    if (appVersion != null) {
      this._appVersion = appVersion;
    }
  }

  String? get appName => _appName;

  set appName(String? appName) => _appName = appName;

  String? get appVersion => _appVersion;

  set appVersion(String? appVersion) => _appVersion = appVersion;

  VersioningDataResponse.fromJson(Map<String, dynamic> json) {
    _appName = json['app_name'];
    _appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this._appName;
    data['app_version'] = this._appVersion;
    return data;
  }
}
