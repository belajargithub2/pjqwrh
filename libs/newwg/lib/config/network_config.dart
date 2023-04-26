import 'package:deasy_config/deasy_config.dart';

class NetworkConfig {
  String environment = flavorConfiguration?.flavorName ?? "dev";
  String _baseUrl = "";
  String _platformUrlEncryption = "";
  String _clientKeyPlatform = "";
  String _authKey = "";
  String apiKey = "";

  NetworkConfig._();

  static final instance = NetworkConfig._();

  String get baseUrl {
    return _baseUrl.isNotEmpty ? _baseUrl : getBaseUrlByEnv(environment);
  }

  set baseUrl(String value) {
    _baseUrl = value;
  }

  String get platformUrlEncryption {
    return _platformUrlEncryption.isNotEmpty ? _platformUrlEncryption : getPlatformUrlEncryptionByEnv(environment);
  }

  set platformUrlEncryption(String value) {
    _platformUrlEncryption = value;
  }

  String get authKey {
    return _authKey.isNotEmpty ? _authKey : getAuthKeyByEnv(environment);
  }

  set authKey(String value) {
    _authKey = value;
  }

  String get clientKeyPlatform {
    return _clientKeyPlatform.isNotEmpty ? _clientKeyPlatform : getClientKeyPlatformByEnv(environment);
  }

  set clientKeyPlatform(String value) {
    _clientKeyPlatform = value;
  }

  fromJson(Map json) {
    environment = json['environment'] ?? environment;
    baseUrl = json['base_url'] ?? baseUrl;
    apiKey = json['api_key'] ?? apiKey;
    clientKeyPlatform = json['client_key_platform'] ?? clientKeyPlatform;
    authKey = json['auth_key'] ?? authKey;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['environment'] = environment;
    data['base_url'] = baseUrl;
    data['api_key'] = apiKey;
    data['client_key_platform'] = clientKeyPlatform;
    data['auth_key'] = authKey;
    return data;
  }

  String getBaseUrlByEnv(String env){
    switch(env) {
      case "staging": {
        return "https://hub-api.kbfinansia.com/api/v2/";
      }
      case "prod": {
        return "https://hub-api.kreditplus.com/api/v2/";
      }
      case "mock": {
        return "https://private-d36162-kphubnewwg.apiary-mock.com/api/v2/";
      }
      case "testing": {
        return "https://testing-ecommerce-api.kbfinansia.com/api/v2/";
      }
      default: {
        return "https://dev-ecommerce-api.kreditplus.com/api/v2/";
      }
    }
  }

  String getPlatformUrlEncryptionByEnv(String env){
    switch(env) {
      case "staging": {
        return "https://asia-southeast2-platform-staging-360907.cloudfunctions.net/";
      }
      case "prod": {
        return "https://asia-southeast2-platform-production-340909.cloudfunctions.net/";
      }
      case "mock": {
        return ""; // todo: belum tersedia
      }
      case "testing": {
        return "https://asia-southeast2-platform-otp-testing.cloudfunctions.net/";
      }
      default: {
        return "https://asia-southeast2-platform-otp-testing.cloudfunctions.net/";
      }
    }
  }

  String getAuthKeyByEnv(String env){
    switch(env) {
      case "staging": {
        return "sW3JWCGNjTEm4Us2jRf3";
      }
      case "prod": {
        return "sW3JWCGNjTEm4Us2jRf3";
      }
      case "mock": {
        return ""; // todo: belum tersedia
      }
      case "testing": {
        return "sW3JWCGNjTEm4Us2jRf3";
      }
      default: {
        return "YQheBymPzuYQFziBgyeCHUndWPusjexP";
      }
    }
  }

  String getClientKeyPlatformByEnv(String env){
    switch(env) {
      case "staging": {
        return "\$2a\$04\$2SDuYHoKavXFU1o6.KFiUu0JGRorDz3kUKb1jhJIwV90lfvF8WxAy";
      }
      case "prod": {
        return "\$2a\$04\$2SDuYHoKavXFU1o6.KFiUu0JGRorDz3kUKb1jhJIwV90lfvF8WxAy";
      }
      case "mock": {
        return ""; // todo: belum tersedia
      }
      case "testing": {
        return "\$2a\$04\$5zbgu/0VZSd1GDi0f8TfIu5Bh.AM4D4eLmSKOYlETc1t1ZNpeYtEC";
      }
      default: {
        return "\$2a\$04\$5zbgu/0VZSd1GDi0f8TfIu5Bh.AM4D4eLmSKOYlETc1t1ZNpeYtEC";
      }
    }
  }
}
