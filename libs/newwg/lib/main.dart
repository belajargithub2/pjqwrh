import 'package:deasy_color/deasy_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg/config/base_config.dart';
import 'package:newwg/config/network_config.dart';
import 'package:newwg/routes/app_pages.dart';
import 'package:requests_inspector/requests_inspector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BaseConfig.initialConfig();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppConfig.instance.statusBarColor,
    ),
  );

  bool showInterceptor(){
    var dev = NetworkConfig.instance.environment == 'dev';
    var mock = NetworkConfig.instance.environment == 'mock';
    var staging = NetworkConfig.instance.environment == 'staging';
    var testing = NetworkConfig.instance.environment == 'testing';
    return dev || mock || staging || testing;
  }

  runApp(
    RequestsInspector(
      enabled: showInterceptor(),
      showInspectorOn: ShowInspectorOn.Both,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "New WG",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: DeasyColor.neutral900),
            bodyMedium: TextStyle(color: DeasyColor.neutral900),
            bodySmall: TextStyle(color: DeasyColor.neutral900),
            titleMedium: TextStyle(color: DeasyColor.neutral900),
            titleSmall: TextStyle(color: DeasyColor.neutral900),
            headlineSmall: TextStyle(color: DeasyColor.neutral900),
          ),
          fontFamily: 'KBFGDisplayLight',
          primaryColor: AppConfig.instance.buttonPrimaryColor,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
    ),
  );
}
