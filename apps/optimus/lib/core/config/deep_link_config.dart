import 'package:deasy_config/deasy_config.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_repository/deasy_repository.dart';


class DynamicLinkConfig {

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
