import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';

class ProdFlavorConfig extends BaseFlavorConfig {
  @override
  String get appDisplayName => "Deasy";
  String get flavorName => "prod";
  String get dynamicLink => "https://proddeasy.page.link";
  int get dioReceiveTimeout => 200 * 1000; // 200 seconds
  int get dioConnectTimeout => 200 * 1000;

  String get appMerchantBaseUrlWithoutVersion =>
      DeasyEncryptorUtil.decryptString(
          "WxIoBrZc1lLXFTGi9q4vxv+C6Agzkkjr8n/iUehSDSQiBSSf2P698W1YVDl6rM4O");
  String get deasyWebBaseUrl =>
      "https://merchant.kreditplus.com"; //http://34.160.26.104
  String get deepLinkUrl => "https://firebasedynamiclinks.googleapis.com/v1/";
  String get firebaseAppKey => DeasyEncryptorUtil.decryptString(
      "ci8mF5YfvTTWOzqj3/wt2JWLzC4uy2O283jhS+wVIW4ZEg38oaLo9GhdUTx/qcsL");
  String get appMerchantBaseUrlV1 => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLXFTGi9q4vxv+C6Agzkkjr8n/iUehSDSQiBSSftYLY0hdldzBzpccH");
  String get appMerchantBaseUrlV2 => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLXFTGi9q4vxv+C6Agzkkjr8n/iUehSDSQiBSSftYLY0hdmdzBzpccH");
  String get appMarketingBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLXFTGi9q4vxv+C6Agzkkjr8n/iUehSDSQiBSSfuZPDlgQgMVsRj7QzYe6ju4xImKNIu//uZkhEqA==");
  String get appECommerceBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLfEyys86oz0bfO+RF011H883L/VfRLC3lvCSbd+5PBlE5TXzJxp8UF");
  String get appMediaBaseUrl => DeasyEncryptorUtil.decryptString(
      "WxIoBrZc1lLSBSHs86ol27PN8xN4nVP65nrjUqpEEWdRelmgxOKh7XFESCVmsNIS");
  String get appMerchantClientKey => DeasyEncryptorUtil.decryptString(
      "CwQcOPcTuVHTTyXt9K0wiKy7/hAosRXvtVT0dqIGHCwKL2XXvZ6L119+AgAni5hxINWiuo1JmaJJuv7vZ0lFqQ==");

  String get appMerchantAuthKey => DeasyEncryptorUtil.decryptString(
      "aRc2OYgunwnXITm47qkGxKSJzjBWs3XbxG/Fd81jBk0AJQfSs5P8sSIDIXI/0qRKD7nG5e8m7ds0/7WjIh8x4ede0FJaaZp7c6KFzlR/lUw=");
  String get appMarketingAuthKey => DeasyEncryptorUtil.decryptString(
      "aRc2OYgunwnXITm47qkGxKSJzjBWs3XbxG/Fd81jBk0AJQfSs5P8sSIDIXI/0qRKD7nG5e8m7ds0/7WjIh8x4ede0FJaaZp7c6KFzlR/lUw=");
  String get appECommerceAuthKey => DeasyEncryptorUtil.decryptString(
      "QDFvPJIlvjPQJAasqpoygLix/lIR9TaCmhqaLYgrcgY=");
  String get vapidKey => DeasyEncryptorUtil.decryptString(
      "cS0XNYcMo1DpKhCv1/sA2pWn3FIltGj8+3PUU7xrFXMLWCDjrIfHygsEPUwlxfprCruY5vt3zeEl4LK4CzAlyrstsAwNF9UaOtSmpAkO7DIPuDbmVyrixbOzPvUaL+uw");
  String get appMediaAuthKey => DeasyEncryptorUtil.decryptString(
      "chwEPvwIgC/vJgfy1Icl54WtoSMR9TaCmhqaLYgrcgY=");
  String get deasyLocalKey => DeasyEncryptorUtil.decryptString(
      "VwMqW6EDmA7DXTeg878g3MLziHEN6SqehgaGMZQ3bho=");
}
