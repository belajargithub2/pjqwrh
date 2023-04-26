import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';

class OptimusDrawerProfileAppbarButtonWidget
    extends GetView<OptimusDrawerCustomController> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isNotif.value = false;
        controller.onTapMenu(context);
      },
      child: Container(
        width: 200,
        child: Row(
          key: UniqueKey(),
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Center(
                    child: Text(
              controller.username.value,
              style: TextStyle(color: DeasyColor.semanticInfo300, fontSize: 12),
              textAlign: TextAlign.center,
            ))),
            Obx(
              () => Icon(
                controller.isNotif.isFalse
                    ? controller.isMenuOpen.isFalse
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: DeasyColor.kpYellow500,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
