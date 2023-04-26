import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

Widget menuWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: MenuWidgets.twoMenu(
        menuNameOne: ContentConstant.dashboard,
        menuNameTwo: ContentConstant.submission,
        onTapMenuOne: () {
          Get.offNamed(OptimusRoutes.DASHBOARD_WEB);
        },
      ),
    );
  }