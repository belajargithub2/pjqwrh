import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/controllers/edit_dealer_management_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';

class EditDealerManagementWeb extends GetView<EditDealerMangementController> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final OptimusDrawerCustomController _drawerController = Get.find();

  onBranchSearchTextChanged(String text) async {
    controller.searchBranchList.clear();
    if (text.isEmpty) {
      controller.update();
      return;
    }

    controller.branchList.forEach((branch) {
      if (branch.branchFullname!.isContainIgnoreCase(text))
        controller.searchBranchList.add(branch);
    });

    controller.update();
  }

  onCroSearchTextChanged(String text) async {
    controller.searchCroList.clear();
    if (text.isEmpty) {
      controller.update();
      return;
    }

    controller.croList.forEach((cro) {
      if (cro.employeeName!.isContainIgnoreCase(text))
        controller.searchCroList.add(cro);
    });

    controller.update();
  }

  onChannelSearchTextChanged(String text) async {
    controller.searchChannelList.clear();
    if (text.isEmpty) {
      controller.update();
      return;
    }

    controller.channelList.forEach((channel) {
      if (channel.channelName!.isContainIgnoreCase(text))
        controller.searchChannelList.add(channel);
    });

    controller.update();
  }

  onDealerSearchTextChanged(String text) {
    controller.searchDealerList.clear();
    if (text.isEmpty) {
      controller.update();
      return;
    }

    controller.dealerGroupNameList.forEach((dealer) {
      if (dealer.isContainIgnoreCase(text))
        controller.searchDealerList.add(dealer);
    });
  }

  Widget buildDealerList() {
    return ListView.builder(
      controller: controller.dealerScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.dealerGroupNameList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.dealerGroupController.text =
                  controller.dealerGroupNameList[i];
              controller.isActiveDealerGroup.value = false;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child:
                        DeasyTextView(text: controller.dealerGroupNameList[i])),
                if (!(i == controller.dealerGroupNameList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildSearchDealerList() {
    return ListView.builder(
      controller: controller.dealerScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.searchDealerList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.dealerGroupController.text =
                  controller.searchDealerList[i];
              controller.isActiveDealerGroup.value = false;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(text: controller.searchDealerList[i])),
                if (!(i == controller.searchDealerList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildBranchList() {
    return ListView.builder(
      controller: controller.branchScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.branchList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.onTapBranchField(
                controller.branchList[i].branchFullname!,
                controller.branchList[i].branchId,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.branchList[i].branchFullname)),
                if (!(i == controller.branchList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildSearchBranchList() {
    return ListView.builder(
      controller: controller.branchScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.searchBranchList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.onTapBranchField(
                controller.searchBranchList[i].branchFullname!,
                controller.searchBranchList[i].branchId,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.searchBranchList[i].branchFullname)),
                if (!(i == controller.searchBranchList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildCroList() {
    return ListView.builder(
      controller: controller.croScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.croList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.onTapCroField(
                controller.croList[i].employeeName!,
                controller.croList[i].croId,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.croList[i].employeeName)),
                if (!(i == controller.croList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildSearchCroList() {
    return ListView.builder(
      controller: controller.croScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.searchCroList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.onTapCroField(
                controller.searchCroList[i].employeeName!,
                controller.searchCroList[i].croId,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.searchCroList[i].employeeName)),
                if (!(i == controller.searchCroList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildChannelList() {
    return ListView.builder(
      controller: controller.channelScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.channelList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.onTapChannel(controller.channelList[i]);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.channelList[i].channelName)),
                if (!(i == controller.channelList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  Widget buildSearchChannelList() {
    return ListView.builder(
      controller: controller.channelScrollController,
      physics: BouncingScrollPhysics(),
      itemCount: controller.searchChannelList.length,
      itemBuilder: (context, i) {
        return InkWell(
            onTap: () {
              controller.channelController.text =
                  controller.searchChannelList[i].channelName!;
              controller.isActiveChannel.value = false;
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    child: DeasyTextView(
                        text: controller.searchChannelList[i].channelName)),
                if (!(i == controller.searchChannelList.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral200),
              ],
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Obx(
      () => Stack(
        children: [
          OptimusDrawerCustom(
              scaffoldKey: scaffoldKey,
              body: Container(
                color: DeasyColor.neutral100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        menuWidget(),
                        Row(
                          children: [
                            IconButton(
                                icon:
                                    Icon(Icons.arrow_back, color: Colors.black),
                                onPressed: () {
                                  Get.back();
                                }),
                            SizedBox(
                              width: 8,
                            ),
                            DeasyTextView(
                                text: MenuConstant.editDealerManagementLabel,
                                fontSize: 20,
                                fontFamily: FontFamily.bold)
                          ],
                        ),
                        SizedBox(height: 40),
                        Form(
                          key: controller.formKey,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Container(
                              margin: EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DeasyTextView(
                                    text: ContentConstant.dealerDetail,
                                    fontColor: DeasyColor.semanticInfo300,
                                    fontFamily: FontFamily.medium,
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            2.5,
                                  ),
                                  SizedBox(height: 12),
                                  Divider(
                                    color: DeasyColor.neutral300,
                                    thickness: 1.0,
                                  ),
                                  SizedBox(height: 16),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.dealerId,
                                    obscure: false,
                                    readOnly: true,
                                    controller: controller.dealerIdController,
                                    textInputType: TextInputType.number,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "${ContentConstant.dealerId} tidak boleh kosong",
                                    prefixIcon: null,
                                    isDisabled: true,
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                    hintText: '',
                                  ),
                                  SizedBox(height: 25),
                                  RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: DeasyTextForm.outlinedTextForm(
                                      labelText: ContentConstant.dealerGroup,
                                      obscure: false,
                                      controller:
                                          controller.dealerGroupController,
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.next,
                                      prefixIcon: null,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          controller.isActiveDealerGroup.isTrue
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: DeasyColor.neutral600,
                                        ),
                                        onTap: () => controller
                                            .isActiveDealerGroup
                                            .toggle(),
                                      ),
                                      onFieldTap: () {
                                        controller.isActiveDealerGroup.value =
                                            true;
                                      },
                                      onChange: (String text) {
                                        onDealerSearchTextChanged(text);
                                      },
                                    ),
                                    onKey: (event) {
                                      if (event.logicalKey.keyLabel
                                          .isEqualIgnoreCase('escape')) {
                                        controller.isActiveDealerGroup.value =
                                            false;
                                      }
                                    },
                                  ),
                                  Visibility(
                                      visible:
                                          controller.isActiveDealerGroup.isTrue,
                                      child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: DeasyColor.neutral400,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: RawScrollbar(
                                              controller: controller
                                                  .dealerScrollController,
                                              isAlwaysShown: true,
                                              thumbColor: DeasyColor.neutral400,
                                              radius: Radius.circular(10),
                                              child: controller.searchDealerList
                                                          .length !=
                                                      0
                                                  ? buildSearchDealerList()
                                                  : buildDealerList()))),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.dealerName,
                                    obscure: false,
                                    readOnly: true,
                                    controller: controller.dealerNameController,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "${ContentConstant.dealerName} tidak boleh kosong",
                                    prefixIcon: null,
                                    isDisabled: true,
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: DeasyTextForm.outlinedTextForm(
                                      labelText: ContentConstant.branch,
                                      hintText: ContentConstant.selectBranch,
                                      controller: controller.branchController,
                                      obscure: false,
                                      readOnly: false,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          controller.isActiveBranch.isTrue
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: DeasyColor.neutral600,
                                        ),
                                        onTap: () =>
                                            controller.isActiveBranch.toggle(),
                                      ),
                                      onFieldTap: () {
                                        controller.isActiveBranch.value = true;
                                      },
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.next,
                                      functionValidate: commonValidation,
                                      parametersValidate:
                                          "${ContentConstant.branch} tidak boleh kosong",
                                      prefixIcon: null,
                                      onChange: (String text) {
                                        onBranchSearchTextChanged(text);
                                      },
                                    ),
                                    onKey: (event) {
                                      if (event.logicalKey.keyLabel
                                          .isEqualIgnoreCase('escape')) {
                                        controller.isActiveBranch.value = false;
                                      }
                                    },
                                  ),
                                  Visibility(
                                      visible: controller.isActiveBranch.isTrue,
                                      child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: DeasyColor.neutral400,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: RawScrollbar(
                                              controller: controller
                                                  .branchScrollController,
                                              isAlwaysShown: true,
                                              thumbColor: DeasyColor.neutral400,
                                              radius: Radius.circular(10),
                                              child: controller.searchBranchList
                                                          .length !=
                                                      0
                                                  ? buildSearchBranchList()
                                                  : buildBranchList()))),
                                  SizedBox(height: 25),
                                  RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: DeasyTextForm.outlinedTextForm(
                                      labelText: ContentConstant.channel,
                                      hintText: ContentConstant.selectChannel,
                                      controller: controller.channelController,
                                      obscure: false,
                                      readOnly: false,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          controller.isActiveChannel.isTrue
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: DeasyColor.neutral600,
                                        ),
                                        onTap: () =>
                                            controller.isActiveChannel.toggle(),
                                      ),
                                      onFieldTap: () {
                                        controller.isActiveChannel.value = true;
                                      },
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.next,
                                      functionValidate: commonValidation,
                                      parametersValidate:
                                          "${ContentConstant.channel} tidak boleh kosong",
                                      prefixIcon: null,
                                      onChange: (String text) {
                                        onChannelSearchTextChanged(text);
                                      },
                                    ),
                                    onKey: (event) {
                                      if (event.logicalKey.keyLabel
                                          .isEqualIgnoreCase('escape')) {
                                        controller.isActiveChannel.value =
                                            false;
                                      }
                                    },
                                  ),
                                  Visibility(
                                      visible:
                                          controller.isActiveChannel.isTrue,
                                      child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: DeasyColor.neutral400,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: RawScrollbar(
                                              controller: controller
                                                  .channelScrollController,
                                              isAlwaysShown: true,
                                              thumbColor: DeasyColor.neutral400,
                                              radius: Radius.circular(10),
                                              child: controller
                                                          .searchChannelList
                                                          .length !=
                                                      0
                                                  ? buildSearchChannelList()
                                                  : buildChannelList()))),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText:
                                        ContentConstant.sourceApplication,
                                    hintText: ContentConstant.selectSourceApp,
                                    controller: controller.sourceAppController,
                                    obscure: false,
                                    readOnly: true,
                                    suffixIcon: Icon(
                                      controller.isActiveSourceApp.isTrue
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      color: DeasyColor.neutral600,
                                    ),
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      controller.isActiveSourceApp.value =
                                          !controller.isActiveSourceApp.value;
                                      controller.sourceAppList
                                          .forEach((sourceAppData) {
                                        var isSelected = false;
                                        controller.selectedSourceAppList
                                            .forEach((selectedSourceAppData) {
                                          if (sourceAppData.id ==
                                              selectedSourceAppData.id) {
                                            isSelected = true;
                                          }
                                        });
                                        if (isSelected) {
                                          controller.sourceAppMap[sourceAppData
                                              .sourceApplication] = true;
                                        } else {
                                          controller.sourceAppMap[sourceAppData
                                              .sourceApplication] = false;
                                        }
                                      });
                                    },
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "${ContentConstant.sourceApplication} tidak boleh kosong",
                                    prefixIcon: null,
                                  ),
                                  Visibility(
                                      visible:
                                          controller.isActiveSourceApp.isTrue,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: DeasyColor.neutral400,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: controller
                                                .sourceAppMap.keys
                                                .map((String? key) {
                                              var lastItem = controller
                                                  .sourceAppList[controller
                                                      .sourceAppList.length -
                                                  1];
                                              return Column(
                                                children: [
                                                  CheckboxListTile(
                                                    activeColor:
                                                        DeasyColor.kpYellow500,
                                                    title: DeasyTextView(
                                                      text: key,
                                                      fontSize:
                                                          DeasySizeConfigUtils
                                                                  .blockVertical *
                                                              2,
                                                    ),
                                                    value: controller
                                                        .sourceAppMap[key],
                                                    onChanged: (bool? value) {
                                                      controller.sourceAppMap[
                                                          key] = value;

                                                      controller.sourceAppList
                                                          .forEach((element) {
                                                        if (element
                                                                .sourceApplication ==
                                                            key) {
                                                          controller
                                                              .onCheckSourceApp(
                                                                  value!,
                                                                  element);
                                                        }
                                                      });
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  ),
                                                  if (!(key ==
                                                      lastItem
                                                          .sourceApplication))
                                                    Divider(
                                                        thickness: 1,
                                                        color: DeasyColor
                                                            .neutral200),
                                                ],
                                              );
                                            }).toList()),
                                      )),
                                  SizedBox(height: 25),
                                  RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    child: DeasyTextForm.outlinedTextForm(
                                      labelText: ContentConstant.croName,
                                      hintText: ContentConstant.selectCro,
                                      controller: controller.croController,
                                      obscure: false,
                                      readOnly: false,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          controller.isActiveCro.isTrue
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: DeasyColor.neutral600,
                                        ),
                                        onTap: () =>
                                            controller.isActiveCro.toggle(),
                                      ),
                                      onFieldTap: () {
                                        controller.isActiveCro.value = true;
                                      },
                                      textInputType: TextInputType.text,
                                      actionKeyboard: TextInputAction.next,
                                      functionValidate:
                                          controller.isContainSNBinSourceApp()
                                              ? commonValidation
                                              : null,
                                      parametersValidate:
                                          "${ContentConstant.croName} tidak boleh kosong",
                                      prefixIcon: null,
                                      onChange: (String text) {
                                        onCroSearchTextChanged(text);
                                      },
                                    ),
                                    onKey: (event) {
                                      if (event.logicalKey.keyLabel
                                          .isEqualIgnoreCase('escape')) {
                                        controller.isActiveCro.value = false;
                                      }
                                    },
                                  ),
                                  Visibility(
                                      visible: controller.isActiveCro.isTrue,
                                      child: Container(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: DeasyColor.neutral400,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          child: controller.croList.isEmpty
                                              ? Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: Center(
                                                      child: DeasyTextView(
                                                          text: ContentConstant
                                                              .dataNotFound)))
                                              : RawScrollbar(
                                                  controller: controller
                                                      .croScrollController,
                                                  isAlwaysShown: true,
                                                  thumbColor:
                                                      DeasyColor.neutral400,
                                                  radius: Radius.circular(10),
                                                  child: controller
                                                              .searchCroList
                                                              .length !=
                                                          0
                                                      ? buildSearchCroList()
                                                      : buildCroList()))),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.confirmMethod,
                                    hintText:
                                        ContentConstant.selectMethodConfirm,
                                    controller:
                                        controller.confirmationMethodController,
                                    obscure: false,
                                    readOnly: true,
                                    suffixIcon: Icon(
                                      controller
                                              .isActiveConfirmationMethod.isTrue
                                          ? Icons.keyboard_arrow_up_outlined
                                          : Icons.keyboard_arrow_down_outlined,
                                      color: DeasyColor.neutral600,
                                    ),
                                    onFieldTap: () {
                                      controller.onTapConfirmationMethodField();
                                    },
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "${ContentConstant.confirmMethod} tidak boleh kosong",
                                    prefixIcon: null,
                                  ),
                                  Visibility(
                                      visible: controller
                                          .isActiveConfirmationMethod.isTrue,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: DeasyColor.neutral400,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: controller
                                                .confirmationMethodMap.keys
                                                .map((String? key) {
                                              var lastItem = controller
                                                      .confirmationMethodList[
                                                  controller
                                                          .confirmationMethodList
                                                          .length -
                                                      1];
                                              return Column(
                                                children: [
                                                  CheckboxListTile(
                                                    activeColor:
                                                        DeasyColor.kpYellow500,
                                                    title: DeasyTextView(
                                                      text: key,
                                                      fontSize:
                                                          DeasySizeConfigUtils
                                                                  .blockVertical *
                                                              2,
                                                    ),
                                                    value: controller
                                                            .confirmationMethodMap[
                                                        key],
                                                    onChanged: (bool? value) {
                                                      controller
                                                              .confirmationMethodMap[
                                                          key] = value;

                                                      controller
                                                          .confirmationMethodList
                                                          .forEach((element) {
                                                        if (element.text!
                                                                .toLowerCase() ==
                                                            key!.toLowerCase()) {
                                                          var data =
                                                              ConfirmationMethodData(
                                                                  confirmationMethod:
                                                                      element
                                                                          .text);
                                                          controller
                                                              .onCheckConfirmationMethod(
                                                                  value!,
                                                                  data,
                                                                  element.id);
                                                        }
                                                      });
                                                    },
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                  ),
                                                  if (!(key == lastItem.text))
                                                    Divider(
                                                        thickness: 1,
                                                        color: DeasyColor
                                                            .neutral200),
                                                ],
                                              );
                                            }).toList()),
                                      )),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.email,
                                    obscure: false,
                                    readOnly: true,
                                    controller: controller.emailController,
                                    textInputType: TextInputType.emailAddress,
                                    actionKeyboard: TextInputAction.next,
                                    prefixIcon: null,
                                    isDisabled: true,
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.phoneNumber,
                                    obscure: false,
                                    readOnly: true,
                                    controller:
                                        controller.phoneNumberController,
                                    textInputType: TextInputType.number,
                                    actionKeyboard: TextInputAction.next,
                                    prefixIcon: null,
                                    isDisabled: true,
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: ContentConstant.dealerAddress,
                                    obscure: false,
                                    readOnly: true,
                                    controller: controller.addressController,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "${ContentConstant.dealerAddress} tidak boleh kosong",
                                    prefixIcon: null,
                                    isDisabled: true,
                                    onFieldTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                    },
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextView(
                                    text: ContentConstant.dateCreated,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    controller.createDate.value.toFormattedDate(
                                            format: "dd MMMM yyyy, HH:mm") +
                                        " WIB",
                                    style: TextStyle(
                                      color: DeasyColor.neutral900,
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              2.0,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextView(
                                    text: ContentConstant.dateUpdated,
                                    fontFamily: FontFamily.medium,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    controller.updateDate.value.toFormattedDate(
                                            format: "dd MMMM yyyy, HH:mm") +
                                        " WIB",
                                    style: TextStyle(
                                      color: DeasyColor.neutral900,
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              2.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      DeasyPrimaryStrokedButton(
                                          text: DialogConstant
                                              .cancelUploadDialog,
                                          width: 154,
                                          onPressed: () {
                                            Get.back();
                                          }),
                                      SizedBox(width: 30),
                                      DeasyPrimaryButton(
                                          text: ButtonConstant.save,
                                          width: 154,
                                          onPressed: () {
                                            if (controller.formKey.currentState!
                                                .validate()) {
                                              controller
                                                  .updateFeatureMerchant();
                                            }
                                          }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          if (controller.isLoading.isTrue)
            AbsorbPointer(
              absorbing: true,
              child: FullScreenSpinner(),
            )
        ],
      ),
    );
  }

  Widget menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.dealerManagementLabel,
      menuNameThree: MenuConstant.editDealerManagementLabel,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      notActiveColor: DeasyColor.kpYellow500,
      activeColor: DeasyColor.neutral400,
      onTapMenuTwo: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DEALER_MANAGEMENT);
      },
    );
  }
}
