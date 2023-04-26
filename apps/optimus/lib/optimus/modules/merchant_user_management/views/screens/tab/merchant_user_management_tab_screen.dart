part of 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/views/screens/merchant_user_management_screen.dart';

class MerchantUserManagementTabScreen extends GetWidget<MerchantUserManagementController> {

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        color: DeasyColor.dmsF8F9FC,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_header(), _table(), _emptyTable() ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MenuWidgets.twoMenu(
          menuNameOne: MenuConstant.dashboardLabel,
          menuNameTwo: MenuConstant.merchantUserManagement,
          onTapMenuOne: () {
            controller.drawerController.handleIcon();
            Get.back();
            Get.offNamed(OptimusRoutes.DASHBOARD_WEB);
          },
          fontSize: 12,
        ),
        SizedBox(height: 15),
        DeasyTextView(
          text: MenuConstant.merchantUserManagement,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: FontFamily.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: DeasyColor.kpBlue600,
                size: 17,
              ),
              SizedBox(width: 5),
              DeasyTextView(
                text: ContentConstant.merchantUserManagementInfo,
                fontSize: 14,
                letterSpacing: 0.2,
                fontColor: DeasyColor.kpBlue600,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Spacer(),
            Obx(() => DeasyCustomElevatedButton(
              text: ContentConstant.addMerchantUser,
              primary: controller.userList.length == 3
                  ? DeasyColor.neutral300
                  : DeasyColor.kpYellow500,
              textColor: DeasyColor.neutral000,
              paddingButton: 10,
              borderColor: controller.userList.length == 3
                  ? DeasyColor.neutral300
                  : DeasyColor.kpYellow500,
              onPress: () => controller.userList.length == 3
                  ? null
                  : controller.navigateToAddUser(),
            )),
            SizedBox(width: 10),
          ],
        ),
      ],
    );
  }

  Widget _table() {
    return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: RawScrollbar(
          thickness: 11,
          thumbColor: DeasyColor.neutral400,
          controller: controller.tableScrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: controller.tableScrollController,
            child:  DataTable(
              dataRowHeight: 70,
              columnSpacing: 30,
              columns: [
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableNo,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableUserName,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTablePhoneNumber,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableEmail,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableStatus,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableUpdateAt,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
                DataColumn(
                    label: DeasyTextView(
                      text: ContentConstant.merchantUserManagementTableAction,
                      fontColor: DeasyColor.kpBlue400,
                      fontFamily: FontFamily.medium,
                    )),
              ],
              rows: List.generate(
                controller.userList.length,
                    (index) => DataRow(cells: [
                  DataCell(AnimatedContainer(
                      width: 10.w * 0.3,
                      duration: Duration(milliseconds: 500),
                      child: DeasyTextView(
                        text: controller.incrementNumber(index),
                        fontColor: DeasyColor.neutral800,
                        fontFamily: FontFamily.medium,
                      ))),
                  DataCell(
                    AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 10.w * 0.9 +
                            (controller.isOpenDrawer ? 0 : 10.w * 0.1),
                        child: DeasyTextView(
                          text: controller.userList[index].name!,
                          fontColor: DeasyColor.neutral800,
                          fontFamily: FontFamily.medium,
                        )),
                  ),
                  DataCell(AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width:
                      10.w * 0.8 + (controller.isOpenDrawer ? 0 : 10.w * 0.1),
                      child: DeasyTextView(
                        text:
                        controller.userList[index].phoneNumber.toDashIfNull(),
                        fontColor: DeasyColor.neutral800,
                        fontFamily: FontFamily.medium,
                      ))),
                  DataCell(AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width:
                      10.w * 1.3 + (controller.isOpenDrawer ? 0 : 10.w * 0.3),
                      child: DeasyTextView(
                        text: controller.userList[index].email!,
                        fontColor: DeasyColor.neutral800,
                        fontFamily: FontFamily.medium,
                      ))),
                  DataCell(AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width:
                      10.w * 1.2 + (controller.isOpenDrawer ? 0 : 10.w * 0.2),
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller.userList[index].isVerified!
                                ? DeasyColor.kpBlue50
                                : DeasyColor.semanticWarning100,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.44.h),
                            child: controller.userList[index].isVerified!
                                ? _verifiedStatusWidget()
                                : MerchantUserManagementStatusWidget(
                              index: index,
                              duration: controller.getTimerDuration(
                                  createdAt: controller
                                      .userList[index].createdAt ??
                                      null,
                                  retryAt: controller.userList[index]
                                      .emailVerifiedAfterRetry ??
                                      null,
                                  index: index),
                            )),
                      ))),
                  DataCell(AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width:
                      10.w * 1.2 + (controller.isOpenDrawer ? 0 : 10.w * 0.2),
                      child: DeasyTextView(
                        text: controller.userList[index].updatedAt
                            .toString()
                            .toFormattedDate(format: DateConstant.dateFormat4),
                        fontColor: DeasyColor.neutral800,
                        fontFamily: FontFamily.medium,
                      ))),
                  DataCell(AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      width: 10.w * 1.2,
                      child: controller.userList[index].isVerified == false
                          ? _actionButtons(index)
                          : _deleteButton(index))),
                ]),
              ),
            ),
          ),
        ));
  }

  Widget _actionButtons(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: controller.userList[index].isVerified == false,
          child: IconButton(
            icon: Icon(
              Icons.mail_outline,
              color: DeasyColor.kpBlue600,
            ),
            onPressed: () {
              controller.isActiveTimer[index] == true
                  ? waitingToResendEmailDialog()
                  : resendEmailDialog(ontap: () async {
                if (controller.isActiveTimer[index] == false) {
                  Get.back();
                  await controller
                      .resendEmail(controller.userList[index].email!)
                      .then((value) async {
                    if (controller.isShowSuccessResendDialog) {
                      await controller.reloadUserList();
                      controller.isActiveTimer[index] = true;
                      successResendEmailDialog(
                          controller.userList[index].email!);
                    }
                  });
                } else {
                  Get.back();
                  DeasySnackBarUtil.showFlushBarError(
                      Get.context!, ContentConstant.waiting);
                }
              });
            },
          ),
        ),
        _deleteButton(index)
      ],
    );
  }

  Widget _deleteButton(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: DeasyColor.dmsF46363,
          ),
          onPressed: () {
            deleteUserDialog(() async {
              await controller
                  .deleteUser(controller.userList[index].id!)
                  .then((value) async {
                if (controller.isShowSuccessDeleteDialog) {
                  await controller.reloadUserList();
                  successDeleteDialog();
                }
              });
            });
          },
        ),
      ],
    );
  }

  Widget _verifiedStatusWidget() {
    return DeasyTextView(
      text: ContentConstant.verified,
      fontColor: DeasyColor.kpBlue600,
      fontFamily: FontFamily.medium,
      fontSize: 1.76.h,
    );
  }

  Widget _emptyTable(){
    return Visibility(
      visible: controller.userList.isEmpty ,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(IlustrationConstant.RESOURCES_ICON_ORDER_BAST, width: 276,),
            ),
            SizedBox(height: 20,),
            DeasyTextView(text: 'Kamu belum menambahkan Merchant Employee ')
          ],
        ),
      ),
    );
  }
}
