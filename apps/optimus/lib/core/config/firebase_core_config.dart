import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:deasy_encryptor/deasy_encryptor.dart';

class FirebaseCoreConfig {
  static Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: web,
    ).catchError((e) {
      print("WEB : $e");
    });
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: DeasyEncryptorUtil.decryptString("ci8mF5YfuAzRFBCgyaA44ZuK1hgwiGz++nHDZ7xzF3sZHQz3uYqF9GhdUTx/qcsL"),
    authDomain: DeasyEncryptorUtil.decryptString("VwM9BbxLiQ/VFDai6qYu3PyF8RN4m1v983fmUapEEWdRelmgxOKh7XFESCVmsNIS"),
    projectId: DeasyEncryptorUtil.decryptString("VwM9BbxLiQ/VFDai6qYu3MLziHEN6SqehgaGMZQ3bho="),
    storageBucket: DeasyEncryptorUtil.decryptString("VwM9BbxLiQ/VFDai6qYu3PyC6BFuiVX6uHX5TIAjeg4="),
    messagingSenderId: DeasyEncryptorUtil.decryptString("Cl5kQfFQzUWPQXXEm8pEtw=="),
    appId: DeasyEncryptorUtil.decryptString("AlxlTv1RzUuOSHbwqPU217DZqwctwVjqrnClEeZGGD8nXn2A5sSIzGlcUD1+qMoK"),
    measurementId: DeasyEncryptorUtil.decryptString("dEtoR/Ekqj6IKgHxmstFtg=="),
  );
}
