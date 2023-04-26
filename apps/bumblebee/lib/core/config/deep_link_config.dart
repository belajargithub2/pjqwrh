import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class DynamicLinkConfig {
  Future<void> initDynamicLinks() async {
    Future.delayed(const Duration(seconds: 3), () async {
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        if (dynamicLinkData.link != null) {
          String token = dynamicLinkData.link.pathSegments[1];
          String email = dynamicLinkData.link.pathSegments[2];
          String flag = dynamicLinkData.link.pathSegments[3];

          if (flag == 'reset' || flag == 'create') {
            Get.toNamed(BumblebeeRoutes.NEW_PASSWORD,
                arguments: {"key": token, "email": email, "flag": flag});
          } else if (flag == 'deleted') {
            Get.toNamed(BumblebeeRoutes.LOGIN,
                arguments: {"key": token, "email": email, "flag": flag});
          }
        }
      }).onError((error) {
        print('onLink error');
        print(error.message);
      });
    });
  }

  Future<String> createDynamicLink(
      String? token,
      DeepLinkRepository deepLinkRepository,
      String? email,
      String flag,
      String route) async {
    String url = await deepLinkRepository
        .createLink(
            Get.context,
            {
              "dynamicLinkInfo": {
                "domainUriPrefix": flavorConfiguration!.dynamicLink,
                "link": "${flavorConfiguration!.deasyWebBaseUrl}/$route/$token/$email/$flag",
                "androidInfo": {
                  "androidPackageName": getPackageName(true),
                  "androidMinPackageVersionCode": "0"
                },
                "iosInfo": {"iosBundleId": getPackageName(false)},
              }
            },
            "${flavorConfiguration!.firebaseAppKey}")
        .then((value) => value!.shortLink!);
    return url;
  }

  String getPackageName(bool isAndroid) {
    String packageName = "${ContentConstant.PACKAGE_NAME}";

    if (isAndroid) {
      packageName = "$packageName.android";
    } else {
      packageName = "$packageName.ios";
    }

    switch (flavorConfiguration!.flavorName) {
      case "prod":
        {
          return "$packageName";
        }
      case "dev":
        {
          return "$packageName.dev";
        }
      case "staging":
        {
          return "$packageName.staging";
        }
      default:
        {
          return "$packageName.dev";
        }
    }
  }
}
