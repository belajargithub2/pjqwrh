import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';

class MockFlavorConfig extends BaseFlavorConfig {
  String get appDisplayName => "Dev Deasy";
  String get flavorName => "dev";
  String get dynamicLink => "https://devdeasy.page.link";
  int get dioReceiveTimeout => 180 * 1000; // 180 seconds
  int get dioConnectTimeout => 180 * 1000;

  String get appMerchantBaseUrlWithoutVersion =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get deasyWebBaseUrl => "https://dev-deasy.kreditplus.com";
  String get deepLinkUrl => "https://firebasedynamiclinks.googleapis.com/v1/";
  String get firebaseAppKey => DeasyEncryptorUtil.decryptString(
      "ci8mF5YfvTTWOzqj3/wt2JWLzC4uy2O283jhS+wVIW4ZEg38oaLo9GhdUTx/qcsL");
  String get appMerchantBaseUrlV1 =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get appMerchantBaseUrlV2 =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get appMarketingBaseUrl =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get appECommerceBaseUrl =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get appMediaBaseUrl =>
      "https://private-e16daa-deasy1.apiary-mock.com/api/v1/";
  String get appMerchantClientKey => DeasyEncryptorUtil.decryptString(
      "CwQcOPcTuVHTTyXt9K0wiKy7/hAosRXvtVT0dqIGHCwKL2XXvZ6L119+AgAni5hxINWiuo1JmaJJuv7vZ0lFqQ==");
  String get appMerchantAuthKey => DeasyEncryptorUtil.decryptString(
      "V1dlQqNSzUyXRHTz+OJ1g+TStQMrn1+jriGlEOEfSj8kWCiE2P698W1YVDl6rM4O");
  String get appMarketingAuthKey => DeasyEncryptorUtil.decryptString(
      "Xi0YOY0LmzXQNyiL8b8F16WX/wJzsknvwF3OW+pVHWgYBR3+rbjSriMiOVAR1qlWPLDI1fAf1MQV4oWjPigm9ede0FJaaZp7c6KFzlR/lUw=");
  String get appECommerceAuthKey => DeasyEncryptorUtil.decryptString(
      "QDFvPJIlvjPQJAasqpoygLix/lIR9TaCmhqaLYgrcgY=");
  String get vapidKey => DeasyEncryptorUtil.decryptString(
      "cS0XNYcMo1DpKhCv1/sA2pWn3FIltGj8+3PUU7xrFXMLWCDjrIfHygsEPUwlxfprCruY5vt3zeEl4LK4CzAlyrstsAwNF9UaOtSmpAkO7DIPuDbmVyrixbOzPvUaL+uw");
  String get appMediaAuthKey => DeasyEncryptorUtil.decryptString(
      "QDFvPJIlvjPQJAasqpoygLix/lIR9TaCmhqaLYgrcgY=");
  String get deasyLocalKey => DeasyEncryptorUtil.decryptString(
      "VwMqW6EDmA7DXTeg878g3MLziHEN6SqehgaGMZQ3bho=");
}
