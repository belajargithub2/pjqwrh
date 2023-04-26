import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/controllers/optimus_register_merchant_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_mobile.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_tablet.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_web.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/base_widget.dart';

class OptimusRegisterMerchant
    extends GetView<OptimusRegisterMerchantController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseWidget(
        child: DeasyResponsive(
          builder: (context, orientation, screenType) {
            if (screenType == DeasyScreenType.desktop) {
              return OptimusRegisterWeb();
            }

            if (screenType == DeasyScreenType.tablet) {
              return OptimusRegisterTabletWeb();
            }

            return OptimusRegisterMobileWeb();
          },
        ),
      ),
    );
  }
}
