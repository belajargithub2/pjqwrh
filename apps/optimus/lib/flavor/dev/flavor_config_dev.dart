import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';

class DevFlavorConfig extends BaseFlavorConfig {
  String get appDisplayName => "Dev Deasy";
  String get flavorName => "dev";
  String get dynamicLink => "https://devdeasy.page.link";
  int get dioReceiveTimeout => 180 * 1000; // 180 seconds
  int get dioConnectTimeout => 180 * 1000;

  String get appMerchantBaseUrlWithoutVersion =>
      DeasyEncryptorUtil.decryptString(
          "WxIoBrZc1lLeFTXs86oz0bqC9hUwmErnuH3kROBOCnotHzqet53c0mlcUD1+qMoK");
  String get deasyWebBaseUrl => "https://dev-deasy.kreditplus.com";
  String get deepLinkUrl => "https://firebasedynamiclinks.googleapis.com/v1/";
  String get firebaseAppKey => DeasyEncryptorUtil.decryptString(
      "ci8mF5YfvTTWOzqj3/wt2JWLzC4uy2O283jhS+wVIW4ZEg38oaLo9GhdUTx/qcsL");
  String get appMerchantBaseUrlV1 => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLeFTXs86oz0bqC9hUwmErnuH3kROBOCnotHzqet53c0gAkMRoAke0D");
  String get appMerchantBaseUrlV2 => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLeFTXs86oz0bqC9hUwmErnuH3kROBOCnotHzqet53c0gAkMRoAku0D");
  String get appMarketingBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLeFTXs864z2beX8Q961Fv+/zj9U+FDF34xBjzD+pHekE4iaRpypMYG");
  String get appECommerceBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLeFTXs+6wu37+G6gJ41Fv+/zj9U+FDF34xBjzD+pHekE41KFxZo8EB");
  String get appMediaBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLeFTXs86ol27PN8xN4nVP65nrjUqpEEWdRelmgxOKh7XFESCVmsNIS");
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

/*
class DevFlavorConfig extends BaseFlavorConfig {
   String get appDisplayName =>  "Dev Deasy";
   String get flavorName =>  "dev";
   String get dynamicLink =>  "https://devdeasy.page.link";
   int get dioReceiveTimeout =>  180 * 1000; // 180 seconds
   int get dioConnectTimeout =>  180 * 1000;

   String get appMerchantBaseUrlWithoutVersion => "https://testing-merchant-api.kbfinansia.com/";
   String get deasyWebBaseUrl =>  "https://testing-deasy.kbfinansia.com";
   String get deepLinkUrl =>  "https://firebasedynamiclinks.googleapis.com/v1/";
   String get firebaseAppKey => DeasyEncryptorUtil.decryptString("ci8mF5YfvTTWOzqj3/wt2JWLzC4uy2O283jhS+wVIW4ZEg38oaLo9GhdUTx/qcsL");
   String get appMerchantBaseUrlV1 => "https://testing-merchant-api.kbfinansia.com/api/v1/";
   String get appMerchantBaseUrlV2 => "https://testing-merchant-api.kbfinansia.com/api/v2/";
   String get appMarketingBaseUrl => "https://testing-merchant-api.kbfinansia.com/marketing/v1/";
   String get appECommerceBaseUrl => DeasyEncryptorUtil.decryptString("WxIoBrZc1lLeFTXs+6wu37+G6gJ41Fv+/zj9U+FDF34xBjzD+pHekE41KFxZo8EB");
   String get appMediaBaseUrl => DeasyEncryptorUtil.decryptString("WxIoBrZc1lLeFTXs86ol27PN8xN4nVP65nrjUqpEEWdRelmgxOKh7XFESCVmsNIS");
   String get appMerchantClientKey => DeasyEncryptorUtil.decryptString("CwQcOPcTuVHTTyXt9K0wiKy7/hAosRXvtVT0dqIGHCwKL2XXvZ6L119+AgAni5hxINWiuo1JmaJJuv7vZ0lFqQ==");
   String get appMerchantAuthKey => DeasyEncryptorUtil.decryptString("V1dlQqNSzUyXRHTz+OJ1g+TStQMrn1+jriGlEOEfSj8kWCiE2P698W1YVDl6rM4O");
   String get appMarketingAuthKey => DeasyEncryptorUtil.decryptString("Xi0YOY0LmzXQNyiL8b8F16WX/wJzsknvwF3OW+pVHWgYBR3+rbjSriMiOVAR1qlWPLDI1fAf1MQV4oWjPigm9ede0FJaaZp7c6KFzlR/lUw=");
   String get appECommerceAuthKey => DeasyEncryptorUtil.decryptString("QDFvPJIlvjPQJAasqpoygLix/lIR9TaCmhqaLYgrcgY=");
   String get vapidKey => DeasyEncryptorUtil.decryptString("cS0XNYcMo1DpKhCv1/sA2pWn3FIltGj8+3PUU7xrFXMLWCDjrIfHygsEPUwlxfprCruY5vt3zeEl4LK4CzAlyrstsAwNF9UaOtSmpAkO7DIPuDbmVyrixbOzPvUaL+uw");
   String get appMediaAuthKey => DeasyEncryptorUtil.decryptString("QDFvPJIlvjPQJAasqpoygLix/lIR9TaCmhqaLYgrcgY=");
   String get deasyLocalKey => DeasyEncryptorUtil.decryptString("VwMqW6EDmA7DXTeg878g3MLziHEN6SqehgaGMZQ3bho=");
}
*/