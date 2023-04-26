import 'dart:async';

import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/routes/app_pages.dart';
import 'package:kreditplus_deasy_website/core/config/firebase_core_config.dart';
import 'package:kreditplus_deasy_website/core/languages/locale_constant.dart';
import 'package:kreditplus_deasy_website/core/languages/localizations_delegate.dart';
import 'package:kreditplus_deasy_website/core/widgets/error/404.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:requests_inspector/requests_inspector.dart';

void mainCommon() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await FirebaseCoreConfig.initializeApp();
    setUrlStrategy(PathUrlStrategy());

    runApp(RequestsInspector(
        enabled: flavorConfiguration!.flavorName == "dev",
        showInspectorOn: ShowInspectorOn.Both,
        child: App()));
  }, (error, stack) {
    print("Log: mainCommon() message: $error");
  });
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_AppState>();
    state?.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _buildRootApp(flavorConfiguration!.appDisplayName);
  }

  Widget _buildRootApp(String appName) {
    return LayoutBuilder(
      builder: (context, constraints) {
        DeasySizeConfigUtils().init(context: Get.context);
        DeasySizeConfigUtils.setScreenSize(constraints);
        return GetMaterialApp(
          title: appName,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          unknownRoute: AppPages.notFoundRoute,
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute(builder: (_) => ErrorPage404());
          },
          locale: _locale,
          supportedLocales: [Locale("id", ""), Locale("en", "")],
          localizationsDelegates: [
            AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
              appBarTheme: AppBarTheme(color: DeasyColor.semanticInfo300),
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: DeasyColor.kpBlue200.withOpacity(.5),
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(color: DeasyColor.neutral900),
                  bodyText2: TextStyle(color: DeasyColor.neutral900),
                  caption: TextStyle(color: DeasyColor.neutral900),
                  subtitle1: TextStyle(color: DeasyColor.neutral900),
                  subtitle2: TextStyle(color: DeasyColor.neutral900),
                  headline5: TextStyle(color: DeasyColor.neutral900)),
              fontFamily: 'KBFGDisplayLight',
              primaryColor: DeasyColor.semanticInfo300,
              colorScheme: ColorScheme.dark(),
              dividerColor: DeasyColor.neutral200,
              errorColor: DeasyColor.dmsF46363,
              canvasColor: DeasyColor.neutral000,
              backgroundColor: DeasyColor.neutral000,
              unselectedWidgetColor: DeasyColor.kpBlue200,
              buttonColor: DeasyColor.kpYellow500,
              focusColor: DeasyColor.semanticInfo300,
              hintColor: DeasyColor.neutral400),
        );
      },
    );
  }
}
