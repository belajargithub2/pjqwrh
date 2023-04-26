import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/controllers/optimus_new_password_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/views/widgets/optimus_new_password_mobile.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/views/widgets/optimus_new_password_tab.dart';
import 'package:kreditplus_deasy_website/optimus/modules/new_password/views/widgets/optimus_new_password_web.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';

class OptimusNewPasswordPage extends GetView<OptimusNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    controller.retrieveDeepLink();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: DeasyResponsive(
          builder: (context, orientation, screenType) {
            if (screenType == DeasyScreenType.desktop) {
              return OptimusNewPasswordWeb();
            }

            if (screenType == DeasyScreenType.tablet) {
              return OptimusNewPasswordTab();
            }

            return OptimusNewPasswordMobile();
          },
        ),
      ),
    );
  }
}
