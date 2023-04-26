import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_custom_paging/deasy_custom_paging.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/user_management/controllers/optimus_add_or_update_user_management_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/base_widget.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:deasy_models/deasy_models.dart';

class OptimusCreateOrUpdateUserManagementView
    extends GetView<OptimusAddOrUpdateUserManagementController> {
  final _formKey = GlobalKey<FormState>();
  Key scaffoldKey = UniqueKey();
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Obx(() => BaseWidget(
          child: OptimusDrawerCustom(
              scaffoldKey: scaffoldKey,
              parentRoute: OptimusPaths.USER_MANAGEMENT,
              body: Container(
                color: DeasyColor.neutral100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            _menuWidget(),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(Icons.arrow_back,
                                        color: Colors.black),
                                    onPressed: () {
                                      Get.back();
                                    }),
                                SizedBox(
                                  width: 8,
                                ),
                                DeasyTextView(
                                    text: controller.isEdit.value
                                        ? MenuConstant.userManagementEditUser
                                        : MenuConstant.userManagementAddUser,
                                    fontSize: 20,
                                    fontFamily: FontFamily.bold),
                              ],
                            ),
                            SizedBox(height: 40),
                            Form(
                              key: _formKey,
                              child: Card(
                                color: DeasyColor.neutral000,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: Container(
                                  margin: EdgeInsets.all(24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      controller.listRole.length < 1
                                          ? CircularProgressIndicator()
                                          : EditTextWidget(
                                              controller: controller.roleName,
                                              title: ContentConstant.role,
                                              hint: ContentConstant.selectRole,
                                              onFieldTap: () {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        new FocusNode());
                                                SelectDialog.showModal<
                                                    RoleManagementData>(
                                                  context,
                                                  items: controller.listRole,
                                                  backgroundColor:
                                                      DeasyColor.neutral000,
                                                  label: ContentConstant
                                                      .searchRole,
                                                  titleStyle: TextStyle(
                                                      color: DeasyColor
                                                          .neutral900),
                                                  searchBoxDecoration:
                                                      InputDecoration(
                                                    hintText: ContentConstant
                                                        .searchHint,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DeasyColor
                                                              .neutral600,
                                                          width: 0.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DeasyColor
                                                              .neutral600,
                                                          width: 0.0),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DeasyColor
                                                              .neutral600,
                                                          width: 0.0),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DeasyColor
                                                              .neutral600,
                                                          width: 0.0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                    ),
                                                  ),
                                                  onFind: (String filter) =>
                                                      controller
                                                          .filterListRoleUser(
                                                              filter),
                                                  itemBuilder: (BuildContext
                                                          context,
                                                      RoleManagementData item,
                                                      bool isSelected) {
                                                    return Container(
                                                      child: ListTile(
                                                        selected: isSelected,
                                                        title: Text(item.name!),
                                                      ),
                                                    );
                                                  },
                                                  onChange: (RoleManagementData
                                                      result) {
                                                    controller
                                                        .onChangeRole(result);
                                                  },
                                                );
                                              },
                                              widgetSuffix: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: DeasyColor.neutral900),
                                              isReadOnly: true,
                                              isEnabled: controller
                                                  .checkingTextFieldIsEnable(),
                                              validation: (value) =>
                                                  commonValidation(
                                                      value,
                                                      ContentConstant
                                                          .roleCantBeEmpty),
                                            ),
                                      Visibility(
                                        visible: controller.checkRole(),
                                        child: EditTextWidget(
                                          controller:
                                              controller.merchantTextController,
                                          title: ContentConstant.merchantLabel,
                                          hint: ContentConstant
                                              .userManagementSearchByMerchantName,
                                          onFieldTap: () => controller
                                              .isOpenDialogMerchant
                                              .toggle(),
                                          isReadOnly: true,
                                          widgetSuffix: Icon(
                                            controller
                                                    .isOpenDialogMerchant.isTrue
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: DeasyColor.neutral900,
                                          ),
                                          validation: (value) =>
                                              controller.checkRole()
                                                  ? commonValidation(
                                                      value,
                                                      ContentConstant
                                                          .merchantCantBeEmpty)
                                                  : null,
                                        ),
                                      ),
                                      Visibility(
                                        visible: controller.checkRole(),
                                        child: controller.merchantDropdownList
                                                    .length <
                                                1
                                            ? SizedBox()
                                            : listMerchantWidget(),
                                      ),
                                      EditTextWidget(
                                        controller:
                                            controller.nameTextController,
                                        title: ContentConstant.name,
                                        hint: ContentConstant.sampleName,
                                        paddingBottom: 10,
                                        isEnabled: controller
                                            .checkingTextFieldIsEnable(),
                                        validation: (value) => commonValidation(
                                            value,
                                            ContentConstant.nameCantBeNull),
                                      ),
                                      Visibility(
                                        visible: controller.checkNikEditText(),
                                        child: EditTextWidget(
                                          controller: controller.nikController,
                                          title: ContentConstant.nikLabel,
                                          hint: ContentConstant.nikHint,
                                          paddingBottom: 10,
                                          isEnabled: controller
                                              .checkingTextFieldIsEnable(),
                                          validation: (value) => controller
                                                  .checkNikEditText()
                                              ? controller.nikValidation(value)
                                              : null,
                                        ),
                                      ),
                                      EditTextWidget(
                                        controller: controller
                                            .phoneNumberTextController,
                                        title: ContentConstant.phoneNumber,
                                        hint: ContentConstant.phoneNumberHint,
                                        paddingBottom: 10,
                                        isNumberOnly: true,
                                      ),
                                      EditTextWidget(
                                        controller:
                                            controller.emailTextController,
                                        title: ContentConstant.emailLabel,
                                        hint: ContentConstant.emailHint,
                                        paddingBottom: 10,
                                        validation: (value) => commonValidation(
                                            value,
                                            ValidationConstant
                                                .badRequestLoginPasswordEmpty),
                                      ),
                                      controller.listLobType.length < 1
                                          ? CircularProgressIndicator()
                                          : Visibility(
                                              visible: controller
                                                  .isShowLobType.value,
                                              child: EditTextWidget(
                                                controller: controller
                                                    .lineTypeController,
                                                title: ContentConstant
                                                    .lineOfBusinessLabel,
                                                hint: ContentConstant
                                                    .lineOfBusinessHint,
                                                onFieldTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  dialogLobType();
                                                },
                                                widgetSuffix: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color:
                                                        DeasyColor.neutral900),
                                                isReadOnly: true,
                                                paddingBottom: 20,
                                                validation: (value) =>
                                                    commonValidation(
                                                        value,
                                                        ContentConstant
                                                            .lineOfBusinessCantBeNull),
                                              ),
                                            ),
                                      Row(
                                        children: [
                                          Spacer(),
                                          DeasyPrimaryButton(
                                              text: controller.isEdit.value
                                                  ? ContentConstant
                                                      .saveChangesLabel
                                                  : ContentConstant
                                                      .addUserLabel,
                                              width: 154,
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  controller.submit();
                                                }
                                              }),
                                        ],
                                      ),
                                      controller.isShowDialogSubmit.isTrue
                                          ? submitDialog(
                                              controller.isEdit.value)
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ));
  }

  listMerchantWidget() {
    return controller.isOpenDialogMerchant.isFalse
        ? SizedBox()
        : Container(
            color: DeasyColor.neutral000,
            height: 325,
            width: 400,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: DeasyColor.semanticInfo300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: DeasyColor.kpBlue200),
                      ),
                      hintText: ContentConstant.typeToSearch,
                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined,
                          color: DeasyColor.semanticInfo300),
                    ),
                    controller: controller.searchControllerMerchant,
                    readOnly: false,
                    onTap: () {
                      controller.getAllMerchant();
                    },
                    obscureText: false,
                    onChanged: (String text) async {
                      controller.onChangeSearch(text);
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: RefreshIndicator(
                    onRefresh: controller.refreshMerchant,
                    child: DeasyCustomPaging(
                      isFinish: controller.countMerchant.value ==
                          controller.merchantDropdownList.length,
                      onLoadMore: controller.loadMore,
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              controller.onTapMerchant(
                                  controller.merchantDropdownList[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                  controller.merchantDropdownList[index].name!),
                              height: 40.0,
                              alignment: Alignment.centerLeft,
                            ),
                          );
                        },
                        itemCount: controller.merchantDropdownList.length,
                      ),
                      whenEmptyLoad: false,
                      delegate: DefaultLoadMoreDelegate(),
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                    ),
                  ),
                ),
              ],
            ));
  }

  Widget _menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.userManagementLabel,
      menuNameThree:
          '${controller.isEdit.value ? MenuConstant.userManagementEditUser : MenuConstant.userManagementAddUser}',
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: () {
        _drawerController.handleIcon();
        Get.offNamed(OptimusPaths.USER_MANAGEMENT);
      },
    );
  }

  submitDialog(bool isEdit) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showGeneralDialog(
        context: Get.context!,
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (_, __, ___) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 408,
                height: 294,
                decoration: BoxDecoration(
                  color: DeasyColor.neutral000,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SvgPicture.asset(
                      IconConstant.RESOURCES_ICON_DONE,
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      isEdit
                          ? ContentConstant.userManagementSuccessUpdateUser
                          : ContentConstant.userManagementSuccessAddUser,
                      style:
                          TextStyle(fontSize: 20, color: DeasyColor.neutral900),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Container(
                      width: 360,
                      child: DeasyCustomElevatedButton(
                        text: ContentConstant.userManagementBackLabel,
                        textColor: DeasyColor.neutral000,
                        borderColor: DeasyColor.kpYellow500,
                        primary: DeasyColor.kpYellow500,
                        paddingButton: 15,
                        onPress: () async {
                          controller.isShowDialogSubmit.value = false;
                          await Future.delayed(Duration(milliseconds: 300));

                          Get.offNamedUntil(
                            OptimusPaths.USER_MANAGEMENT,
                            ModalRoute.withName(Routes.DASHBOARD_WEB),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
    return SizedBox();
  }

  dialogLobType() {
    SelectDialog.showModal<LobType>(
      Get.context!,
      items: controller.listLobType,
      backgroundColor: DeasyColor.neutral000,
      label: ContentConstant.searchRole,
      titleStyle: TextStyle(color: DeasyColor.neutral900),
      searchBoxDecoration: InputDecoration(
        hintText: ContentConstant.searchHint,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onFind: (String filter) => controller.filterListLobType(filter),
      itemBuilder: (BuildContext context, LobType item, bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item.lobTypeName!),
          ),
        );
      },
      onChange: (LobType result) {
        controller.onChangeLobType(result);
      },
    );
  }
}
