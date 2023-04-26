class AuthConfig {
  String authentication = "";
  String appSource = "DSY";
  String deviceId = "";
  String orderId = "";
  String xSourceToken = "";
  String prefix = "NWG";
  int uniqueId = 10;

  /// private constructor
  AuthConfig._();

  /// the one and only instance of this singleton
  static final instance = AuthConfig._();

  fromJson(Map json) {
    authentication = json['authentication'] ?? authentication;
    appSource = json['app_source'] ?? appSource;
    deviceId = json['device_id'] ?? deviceId;
    orderId = json['order_id'] ?? orderId;
    xSourceToken = json['x_source_token'] ?? xSourceToken;
    uniqueId = json['unique_id'] ?? uniqueId;
    prefix = json['prefix'] ?? prefix;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authentication'] = authentication;
    data['app_source'] = appSource;
    data['device_id'] = deviceId;
    data['order_id'] = orderId;
    data['x_source_token'] = xSourceToken;
    data['unique_id'] = uniqueId;
    data['prefix'] = prefix;
    return data;
  }
}
