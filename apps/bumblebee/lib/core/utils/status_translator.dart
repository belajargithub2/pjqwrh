import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class StatusTranslator {
 static String formatStringStatus({required String status, required String role}) {
    switch (status) {
      case ContentConstant.STATUS_APPROVED:
        return EnumOrderTransaction.approved.name;
      case ContentConstant.STATUS_PURCHASE_CONFIRMED:
        return EnumOrderTransaction.purchaseConfirmed.name;
      case ContentConstant.STATUS_CANCELED:
        return EnumOrderTransaction.canceled.name;
      case ContentConstant.STATUS_REJECT:
        return EnumOrderTransaction.rejected.name;
      case ContentConstant.STATUS_CANCEL_REQUEST:
        return EnumOrderTransaction.cancelRequest.name;
      case ContentConstant.STATUS_ON_PROGRESS:
        return EnumOrderTransaction.onProgress.name;
      case ContentConstant.STATUS_BI_CHECKING:
        return EnumOrderTransaction.biChecking.name;
      case ContentConstant.STATUS_DISBURSED:
        return role.isContainIgnoreCase(ContentConstant.ROLE_AGENT)
            ? EnumOrderTransaction.goLive.name
            : EnumOrderTransaction.disbursed.name;
      default:
        return "";
    }
  }
}
