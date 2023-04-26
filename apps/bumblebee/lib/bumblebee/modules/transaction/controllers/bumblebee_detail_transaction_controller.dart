import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:deasy_color/deasy_color.dart';

class BumblebeeDetailTransactionController extends GetxController {
  TransactionListModel? transaction = TransactionListModel();
  BumblebeeTransactionRepository transactionRepository =
      new BumblebeeTransactionRepository();
  final isLoading = false.obs;
  final isMerchantOnline = false.obs;

  final isNotEmptyPO = false.obs;
  final isNotEmptyInvoice = false.obs;
  final role = "".obs;
  final agentBrand = "".obs;
  final agentModel = "".obs;
  final agentType = "".obs;
  final agentDisbursedAmount = 0.obs;
  final agentProductOfferingName = "".obs;
  final agentFee = 0.obs;
  final agentOrderStatus = "".obs;
  final isNotEformOnProgress = false.obs;
  final isApprovedAndTrackingNotExists = false.obs;
  final orderDateAgent = ''.obs;
  final customerNameAgent = ''.obs;
  final hasPOAccess = false.obs;
  final hasInvoiceAccess = false.obs;
  final hasBASTAccess = false.obs;
  final hasBuktiTerimaAccess = false.obs;
  final hasImeiAccess = false.obs;
  final RxList<String> documentAccessList = <String>[].obs;

  @override
  void onInit() async {
    transaction = Get.arguments['transaction'];
    isMerchantOnline.value = Get.arguments['isMerchantOnline'] ?? false;
    await DeasyPocket().getRole().then((value) {
      role.value = value;
    });

    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      transactionRepository
          .fetchApiDetailAgentOrders(Get.context, transaction!.prospectId)
          .then((value) {
        agentBrand.value = value.data!.assets!.first.vehicleBrand!;
        agentModel.value = value.data!.assets!.first.vehicleModel!;
        agentType.value = value.data!.assets!.first.vehicleType!;
        agentDisbursedAmount.value = value.data!.disbursedAmount ?? 0;
        agentProductOfferingName.value = value.data!.productOfferingName ?? "-";
        agentFee.value = value.data!.feeAgent ?? 0;
        agentOrderStatus.value = value.data!.status!;
        orderDateAgent.value = value.data!.orderDate!
            .toFormattedDate(format: DateConstant.dateFormat2);
        customerNameAgent.value = value.data!.customerName!;
      });
    }
    setPOInvoiceStatus();
    checkIsNotEformOnProgress();
    checkisApprovedAndTrackingNotExists();
    await getDocumentAccess();
    if (!role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      checkTrackingAccess();
    }

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkIsNotEformOnProgress() {
    if (transaction!.orderStatus == EnumOrderTransaction.onProgress &&
        transaction!.sourceApplication != "EFORM") {
      isNotEformOnProgress(true);
    }
  }

  void checkisApprovedAndTrackingNotExists() {
    if (transaction!.orderStatus == EnumOrderTransaction.approved &&
        transaction!.trackingExists == false) {
      isApprovedAndTrackingNotExists(true);
    }
  }

  void checkTrackingAccess() {
    var isAWB = false;
    if (transaction!.confirmationMethods!.isNotEmpty) {
      transaction!.confirmationMethods!.forEach((element) {
        if (element.confirmationMethod == ContentConstant.AWB) {
          isAWB = true;
        }
      });
    }

    if (isAWB) {
      if (isMerchantOnline.isTrue) {
        documentAccessList.add(ContentConstant.STATUS_PENGIRIMAN);
      }
    }
  }

  Future<void> getDocumentAccess() async {
    hasPOAccess(await DeasyPocket().getPOAccess());
    hasInvoiceAccess(await DeasyPocket().getInvoiceAccess());
    hasBASTAccess(await DeasyPocket().getViewBASTAccess());
    hasBuktiTerimaAccess(await DeasyPocket().getViewBuktiTerimaAccess());
    hasImeiAccess(await DeasyPocket().getViewImeiAccess());

    addDocumentAccess(
        hasBuktiTerimaAccess.isTrue, ContentConstant.BUKTI_TERIMA);
    addDocumentAccess(hasBASTAccess.isTrue, ContentConstant.BAST);
    addDocumentAccess(hasImeiAccess.isTrue, ContentConstant.IMEI);
  }

  addDocumentAccess(bool isHasAccess, String flag) {
    if (isHasAccess && isMerchantOnline.isFalse) {
      documentAccessList.add(flag);
    }
  }

  fetchApiTracking() {
    transactionRepository
        .fetchApiTracking(Get.context, null, transaction!.prospectId)
        .then((value) {
      if (transaction!.orderStatus.id
              .isContainIgnoreCase(ContentConstant.STATUS_ON_PROGRESS) ||
          transaction!.orderStatus.id
              .isContainIgnoreCase(ContentConstant.STATUS_CANCEL_REQUEST) ||
          transaction!.orderStatus.id
              .isContainIgnoreCase(ContentConstant.STATUS_CANCELED) ||
          transaction!.orderStatus.id
              .isContainIgnoreCase(ContentConstant.STATUS_REJECT)) {
        showAvailableTrackingBottomSheet(value.trackingData!, false);
      } else {
        showAvailableTrackingBottomSheet(value.trackingData!, true);
      }
    });
  }

  void setPOInvoiceStatus() {
    if ((transaction!.epoDate != null) &&
        (transaction!.orderStatus.id == ContentConstant.STATUS_APPROVED ||
            transaction!.orderStatus.id ==
                ContentConstant.STATUS_PURCHASE_CONFIRMED)) {
      isNotEmptyPO(true);
    }

    if (transaction!.orderStatus.id ==
            ContentConstant.STATUS_PURCHASE_CONFIRMED &&
        transaction!.invoiceDate != null) {
      isNotEmptyInvoice(true);
    }
  }

  bool isDocumentAvailable(String documentAccess) {
    switch (documentAccess) {
      case ContentConstant.BUKTI_TERIMA:
        if (transaction!.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS ||
            transaction!.orderStatus.id ==
                ContentConstant.STATUS_CANCEL_REQUEST ||
            transaction!.orderStatus.id == ContentConstant.STATUS_CANCELED ||
            transaction!.orderStatus.id == ContentConstant.STATUS_REJECT) {
          return false;
        }

        if (transaction!.customerReceiptPhotoUrl!.isNotEmpty &&
            (transaction!.orderStatus.id ==
                    ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                transaction!.orderStatus.id ==
                    ContentConstant.STATUS_DISBURSED ||
                transaction!.orderStatus.id ==
                    ContentConstant.STATUS_APPROVED)) {
          return true;
        }

        return false;

      case ContentConstant.BAST:
        if (transaction!.orderStatus.id ==
                ContentConstant.STATUS_PURCHASE_CONFIRMED ||
            transaction!.orderStatus.id == ContentConstant.STATUS_DISBURSED) {
          return true;
        }

        return false;

      case ContentConstant.IMEI:
        return (transaction!.imeiUrl!.isNotEmpty);

      case ContentConstant.AWB:
        return (transaction!.trackingExists! &&
                transaction!.orderStatus.id != ContentConstant.STATUS_REJECT) ||
            (transaction!.trackingExists! &&
                transaction!.orderStatus.id !=
                    ContentConstant.STATUS_ON_PROGRESS);

      default:
        return false;
    }
  }

  void fetchApiDocumentById(BuildContext? context, String flag,
      {String? title}) async {
    AnalyticConfig().sendEventAccess("Document");
    if (flag.toLowerCase() == ContentConstant.BAST.toLowerCase() ||
        flag.toLowerCase() == ContentConstant.CUSTOMER.toLowerCase() ||
        flag.toLowerCase() == ContentConstant.IMEI.toLowerCase()) {
      Get.toNamed(Routes.TRANSACTION_IMAGE_PREVIEW, arguments: {
        "prospectId": transaction!.prospectId,
        "type": flag.toLowerCase(),
        "title": title
      });
    } else {
      Get.toNamed(Routes.TRANSACTION_PDF, arguments: {
        "prospectId": transaction!.prospectId,
        "type": flag.camelCase,
        "title": flag.toLowerCase() == ContentConstant.EPO.toLowerCase()
            ? ContentConstant.PO
            : flag,
      });
    }
  }

  showAvailableTrackingBottomSheet(TrackingData tracking, bool isAvailable) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: Get.context!,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: isAvailable ? 0.6 : 0.33,
            child: Container(
                margin: EdgeInsets.only(right: 6.w, left: 6.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        height: 3,
                        width: DeasySizeConfigUtils.screenWidth! / 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: DeasyColor.neutral400,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.55.h),
                    Center(
                      child: DeasyTextView(
                        text: "${ContentConstant.trackingStatus}",
                        fontColor: DeasyColor.neutral900,
                        fontFamily: FontFamily.medium,
                        fontSize: 5.w,
                      ),
                    ),
                    SizedBox(height: 2.95.h),
                    DeasyTextView(
                      text:
                          "${ContentConstant.status} : ${tracking.status ?? '-'}",
                      fontColor: DeasyColor.neutral900,
                      fontFamily: FontFamily.medium,
                    ),
                    SizedBox(height: 0.6.h),
                    DeasyTextView(
                        text:
                            "${ContentConstant.orderId} : ${tracking.prospectId ?? '-'}",
                        fontColor: DeasyColor.neutral400,
                        fontFamily: FontFamily.medium),
                    SizedBox(height: 0.6.h),
                    if (isAvailable)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DeasyTextView(
                              text:
                                  "${ContentConstant.noAwb} : ${tracking.awbNumber ?? '-'}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.logisticName} : ${tracking.logisticName ?? '-'}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.deliveryTime} : ${tracking.deliveryTime == null ? "-" : tracking.deliveryTime!.toLocal().toFormattedDate(format: DateConstant.dateFormat7)}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.arrivedTime} : ${tracking.destinationTime == null ? "-" : tracking.destinationTime!.toLocal().toFormattedDate(format: DateConstant.dateFormat7)}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.receiverName} : ${tracking.receiverName ?? '-'}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.shippingAddress} : ${tracking.shippingAddress ?? '-'}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium,
                              maxLines: 4),
                          SizedBox(height: 0.6.h),
                          DeasyTextView(
                              text:
                                  "${ContentConstant.receiverMobilePhone} : ${tracking.mobilePhone ?? '-'}",
                              fontColor: DeasyColor.neutral400,
                              fontFamily: FontFamily.medium),
                        ],
                      ),
                    SizedBox(height: 6.w),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: double.infinity),
                      child: DeasyPrimaryButton(
                        onPressed: () {
                          Get.back();
                        },
                        text: ContentConstant.back,
                      ),
                    ),
                    SizedBox(height: 3.w),
                  ],
                )),
          );
        });
  }

  Widget setStatus() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      switch (agentOrderStatus.value) {
        case ContentConstant.STATUS_DISBURSED:
          {
            return wordingStatus(
                DeasyColor.sally50,
                DeasyColor.sally900,
                EnumOrderTransaction.goLive.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_melted.svg");
          }

        case ContentConstant.STATUS_CANCELED:
          {
            return wordingStatus(
                DeasyColor.neutral50,
                DeasyColor.neutral400,
                EnumOrderTransaction.canceled.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_cancel.svg");
          }

        case ContentConstant.STATUS_REJECT:
          {
            return wordingStatus(
                DeasyColor.dmsFFF1F1,
                DeasyColor.dmsF46363,
                EnumOrderTransaction.rejected.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_reject.svg");
          }

        case ContentConstant.STATUS_BI_CHECKING:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.biChecking.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case ContentConstant.STATUS_CREDIT_PROCESS:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.creditProcess.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case ContentConstant.STATUS_ON_SURVEY:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.survey.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case ContentConstant.STATUS_APPROVED:
          {
            return wordingStatus(
                DeasyColor.dmsEBFFF2,
                DeasyColor.dms2ED477,
                EnumOrderTransaction.approved.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_approve.svg");
          }

        default:
          {
            return Text('');
          }
      }
    } else {
      switch (transaction!.orderStatus) {
        case EnumOrderTransaction.purchaseConfirmed:
          {
            return wordingStatus(
                DeasyColor.kpBlue50,
                DeasyColor.kpBlue500,
                EnumOrderTransaction.purchaseConfirmed.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_purchase_confirm.svg");
          }

        case EnumOrderTransaction.disbursed:
          {
            return wordingStatus(
                DeasyColor.sally50,
                DeasyColor.sally900,
                role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)
                    ? EnumOrderTransaction.goLive.message
                    : EnumOrderTransaction.disbursed.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_melted.svg");
          }

        case EnumOrderTransaction.canceled:
          {
            return wordingStatus(
                DeasyColor.neutral50,
                DeasyColor.neutral400,
                EnumOrderTransaction.canceled.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_cancel.svg");
          }

        case EnumOrderTransaction.cancelRequest:
          {
            return wordingStatus(
                DeasyColor.neutral50,
                DeasyColor.neutral800,
                EnumOrderTransaction.cancelRequest.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_request_cancel.svg");
          }

        case EnumOrderTransaction.rejected:
          {
            return wordingStatus(
                DeasyColor.dmsFFF1F1,
                DeasyColor.dmsF46363,
                EnumOrderTransaction.rejected.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_reject.svg");
          }

        case EnumOrderTransaction.onProgress:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.onProgress.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case EnumOrderTransaction.biChecking:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.biChecking.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case EnumOrderTransaction.creditProcess:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.creditProcess.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case EnumOrderTransaction.survey:
          {
            return wordingStatus(
                DeasyColor.kpYellow50,
                DeasyColor.kpYellow500,
                EnumOrderTransaction.survey.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg");
          }

        case EnumOrderTransaction.approved:
          {
            return wordingStatus(
                DeasyColor.dmsEBFFF2,
                DeasyColor.dms2ED477,
                EnumOrderTransaction.approved.message,
                "${IconConstant.RESOURCES_ICON_PATH}ic_approve.svg");
          }

        default:
          {
            return Text('');
          }
      }
    }
  }

  int getIndex() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      switch (agentOrderStatus.value) {
        case ContentConstant.STATUS_BI_CHECKING:
          {
            return 0;
          }

        case ContentConstant.STATUS_ON_SURVEY:
          {
            return 1;
          }

        case ContentConstant.STATUS_CREDIT_PROCESS:
          {
            return 2;
          }

        case ContentConstant.STATUS_APPROVED:
          {
            return 3;
          }

        case ContentConstant.STATUS_REJECT:
          {
            return 4;
          }

        case ContentConstant.STATUS_CANCELED:
          {
            return 5;
          }

        case ContentConstant.STATUS_PAID:
          {
            return 6;
          }

        case ContentConstant.STATUS_DISBURSED:
          {
            return 7;
          }

        default:
          {
            return 4;
          }
      }
    } else {
      switch (transaction!.orderStatus) {
        case EnumOrderTransaction.onProgress:
          {
            return 0;
          }

        case EnumOrderTransaction.approved:
          {
            return 1;
          }

        case EnumOrderTransaction.rejected:
          {
            return 2;
          }

        case EnumOrderTransaction.purchaseConfirmed:
          {
            return 3;
          }

        case EnumOrderTransaction.cancelRequest:
          {
            return 4;
          }

        case EnumOrderTransaction.disbursed:
          {
            return 5;
          }

        case EnumOrderTransaction.canceled:
          {
            return 6;
          }

        default:
          {
            return 0;
          }
      }
    }
  }

  Widget wordingStatus(
      Color color, Color fontColor, String wording, String image) {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      color: color,
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            "$image",
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$wording',
              style: TextStyle(
                color: fontColor,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
              ),
            ),
          )),
        ],
      ),
    );
  }

  String getOrderDate() {
    if (transaction!.orderDate != null) {
      return transaction!.orderDate!
          .toFormattedDate(format: DateConstant.dateFormat2);
    }

    return orderDateAgent.value;
  }

  bool checkCancelOrder() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) &&
        agentOrderStatus.value
            .isContainIgnoreCase(ContentConstant.orderStatusBIChecking)) {
      return true;
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) &&
            isNotEformOnProgress.isTrue ||
        isApprovedAndTrackingNotExists.isTrue) {
      return true;
    } else {
      return false;
    }
  }

  bool checkShowIndicator() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) ||
        (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) &&
            agentOrderStatus.value != ContentConstant.STATUS_CANCELED)) {
      return true;
    } else {
      return false;
    }
  }

  fetchDocument(String documentAccess) {
    switch (documentAccess) {
      case ContentConstant.PO:
        if (isNotEmptyPO.isTrue) {
          fetchApiDocumentById(Get.context, ContentConstant.EPO.toLowerCase());
        } else {
          offlineDialog(Get.context!, documentAccess);
        }
        break;
      case ContentConstant.INVOICE:
        if (isNotEmptyInvoice.isTrue) {
          fetchApiDocumentById(Get.context, documentAccess);
        } else {
          offlineDialog(Get.context!, documentAccess);
        }
        break;
      case ContentConstant.BUKTI_TERIMA:
        if (isDocumentAvailable(documentAccess)) {
          fetchApiDocumentById(
              Get.context, ContentConstant.CUSTOMER.toLowerCase(),
              title: '$documentAccess');
        } else {
          offlineDialog(Get.context!, documentAccess.toUpperCase());
        }
        break;
      case ContentConstant.IMEI:
        if (isDocumentAvailable(documentAccess)) {
          fetchApiDocumentById(Get.context, ContentConstant.IMEI.toLowerCase(),
              title: '$documentAccess');
        } else {
          offlineDialog(Get.context!, documentAccess.toUpperCase());
        }
        break;
      case ContentConstant.BAST:
        if (isDocumentAvailable(documentAccess)) {
          fetchApiDocumentById(Get.context, documentAccess.toLowerCase(),
              title: '$documentAccess');
        } else {
          offlineDialog(Get.context!, documentAccess);
        }
        break;
      case ContentConstant.STATUS_PENGIRIMAN:
        fetchApiTracking();
        break;
      default:
    }
  }

  offlineDialog(BuildContext context, String title) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight! / 4,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: Text(
                      '$title',
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 3),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.05,
                ),
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: Text(
                      ContentConstant.emptyDataBottomSheetText,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.05,
                ),
                Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  child: DeasyCustomButton(
                      radius: 3,
                      text: ContentConstant.back,
                      onPressed: () {
                        Get.back();
                      }),
                )
              ],
            ),
          );
        });
  }
}
