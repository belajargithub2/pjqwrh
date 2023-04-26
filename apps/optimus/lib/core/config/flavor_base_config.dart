BaseFlavorConfig? flavorConfig;

void setFlavor(BaseFlavorConfig config) {
  flavorConfig = config;
}

BaseFlavorConfig? get flavorConfiguration {
  return flavorConfig;
}

abstract class BaseFlavorConfig {
  String get appDisplayName;

  String get flavorName;

  String get dynamicLink;

  String get deasyWebBaseUrl;

  String get deepLinkUrl;

  String get firebaseAppKey;

  String get appMerchantBaseUrlV1;

  String get appMerchantBaseUrlV2;

  String get appMerchantBaseUrlWithoutVersion;

  String get appMarketingBaseUrl;

  String get appECommerceBaseUrl;

  String get appMediaBaseUrl;

  String get appMerchantClientKey;

  String get appMerchantAuthKey;

  String get appMarketingAuthKey;

  String get appECommerceAuthKey;

  String get vapidKey;

  String get appMediaAuthKey;

  int get dioReceiveTimeout;

  int get dioConnectTimeout;

  String get deasyLocalKey;
}
