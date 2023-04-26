import 'dart:io';

//this class is only used for development mode and using emulator

// Just for the sake of clarity specially for the newcomers to Flutter/Dart,
// here is what you need to do in order to enable this option globally in your project:

//source : https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}