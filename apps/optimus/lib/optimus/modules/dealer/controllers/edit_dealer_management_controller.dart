import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/branch_employee_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/branch_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/channel_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/confirmation_method_list_response.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/repositories/optimus_source_application_repository.dart';

class EditDealerMangementController extends GetxController {
  final dealerIdController = TextEditingController();
  final dealerGroupController = TextEditingController();
  final dealerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  late MerchantRepository merchantRepository;
  late OptimusSourceApplicationRepository sourceAppRepository;
  final isActiveDealerGroup = false.obs;
  final isActiveBranch = false.obs;
  final isActiveCro = false.obs;
  final isActiveChannel = false.obs;
  final isActiveSourceApp = false.obs;
  final isActiveConfirmationMethod = false.obs;
  final dealerScrollController = ScrollController();
  final branchController = TextEditingController();
  final croController = TextEditingController();
  final branchScrollController = ScrollController();
  final croScrollController = ScrollController();
  final channelController = TextEditingController();
  final channelScrollController = ScrollController();
  final sourceAppController = TextEditingController();
  final confirmationMethodController = TextEditingController();
  RxList<String> dealerGroupNameList = RxList<String>();
  RxList<BranchData> branchList = RxList<BranchData>();
  RxList<BranchEmployeeData> croList = RxList<BranchEmployeeData>();
  RxList<ChannelData> channelList = RxList<ChannelData>();
  RxList<SourceAppData> sourceAppList = RxList<SourceAppData>();
  RxList<ConfirmationMethodsData> confirmationMethodList =
      RxList<ConfirmationMethodsData>();
  RxList<String> searchDealerList = RxList<String>();
  RxList<BranchData> searchBranchList = RxList<BranchData>();
  RxList<BranchEmployeeData> searchCroList = RxList<BranchEmployeeData>();
  RxList<ChannelData> searchChannelList = RxList<ChannelData>();
  final RxMap<String?, bool?> sourceAppMap = Map<String, bool>().obs;
  final RxMap<String?, bool?> confirmationMethodMap = Map<String, bool>().obs;
  String? supplierId;
  String? branchId;
  String? croId;
  String? channelId;
  List<SourceAppData> selectedSourceAppList = [];
  List<ConfirmationMethodData> selectedConfirmationMethodList = [];
  List<String?> selectedConfirmationMethodIdList = [];
  final createDate = ''.obs;
  final updateDate = ''.obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    merchantRepository = MerchantRepository();
    sourceAppRepository = OptimusSourceApplicationRepository();
    supplierId = Get.parameters['id'];
    isLoading(true);
    await fetchDealerGroup();
    await fetchBranch();
    await fetchChannels();
    await fetchConfirmationMethods();
    await fetchSourceApplications();
    await fetchMerchantById(supplierId);
    super.onInit();
  }

  fetchDealerGroup() {
    merchantRepository.getGroupName(Get.context, null).then((value) {
      dealerGroupNameList.addAll(value.dealerGroupListData!);
    }).catchError((error) {});
  }

  fetchBranch() {
    merchantRepository.getBranches(Get.context, null).then((value) {
      branchList.addAll(value.listBranchData!);
    }).catchError((onError) {});
  }

  fetchBranchEmployee(String? branchId) {
    merchantRepository.getBranchEmployees(Get.context, branchId).then((value) {
      croList.addAll(value.data!);
    }).catchError((onError) {});
  }

  fetchSourceApplications() {
    sourceAppRepository.getSourceApplicationList(Get.context).then((value) {
      sourceAppList.addAll(value.listSourceAppData!);
    }).catchError((error) {});
  }

  fetchConfirmationMethods() {
    merchantRepository.getConfirmationMethods(Get.context).then((value) {
      confirmationMethodList.addAll(value.confirmationMethods!);
    }).catchError((error) {});
  }

  fetchChannels() {
    merchantRepository.getChannels(Get.context).then((value) {
      channelList.addAll(value.channels!);
    }).catchError((error) {});
  }

  fetchMerchantById(String? id) {
    dealerGroupController.clear();
    branchController.clear();
    channelController.clear();
    sourceAppController.clear();
    confirmationMethodController.clear();
    merchantRepository.getMerchantById(Get.context, id).then((value) {
      setDataMerchant(value);
    }).catchError((error) {});
  }

  setDataMerchant(MerchantDetailResponse value) {
    supplierId = value.data!.supplierId;
    branchId = value.data!.branchId;
    if (branchId != null) fetchBranchEmployee(branchId);
    croId = value.data!.croId;
    dealerIdController.text = value.data!.supplierId!;
    dealerGroupController.text = value.data!.groupName!;
    dealerNameController.text = value.data!.name!;
    branchController.text = value.data!.branchName!;
    croController.text = value.data!.branchEmployee!.employeeName ?? "";
    channelController.text = value.data!.channel!;
    channelList.forEach((channel) {
      if (channel.channelName!.isContainIgnoreCase(value.data!.channel!)) {
        channelId = channel.channelId;
      }
    });
    emailController.text = value.data!.email!;
    phoneNumberController.text = value.data!.phoneNumber!;
    addressController.text = value.data!.address!;
    createDate.value = value.data!.createdAt!;
    updateDate.value = value.data!.updatedAt!;
    selectedSourceAppList.clear();
    selectedSourceAppList.addAll(value.data!.sourceApplications!);
    selectedConfirmationMethodList.clear();
    selectedConfirmationMethodList.addAll(value.data!.confirmationMethods!);
    selectedConfirmationMethodList.forEach((selectedData) {
      confirmationMethodList.forEach((data) {
        if (selectedData.confirmationMethod!.isContainIgnoreCase(data.text!)) {
          selectedConfirmationMethodIdList.add(data.id);
        }
      });
    });

    setSelectedSourceApp(selectedSourceAppList);
    setSelectedConfirmationMethod(selectedConfirmationMethodList);
    isLoading(false);
  }

  setSelectedSourceApp(List<SourceAppData> list) {
    list.forEach((element) {
      if (sourceAppController.text.isEmpty) {
        sourceAppController.text = element.sourceApplication!;
      } else {
        sourceAppController.text =
            sourceAppController.text + ", " + element.sourceApplication!;
      }
    });
  }

  onTapBranchField(String name, String? id) async {
    branchController.text = name;
    branchId = id;
    isActiveBranch.value = false;
    croList.clear();
    croController.clear();
    croId = "";
    await fetchBranchEmployee(branchId);
  }

  onTapCroField(String name, String? id) {
    croController.text = name;
    croId = id;
    isActiveCro.value = false;
  }

  onTapConfirmationMethodField() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
    isActiveConfirmationMethod.value = !isActiveConfirmationMethod.value;
    confirmationMethodList.forEach((confirmationMethodData) {
      var isSelected = false;
      selectedConfirmationMethodList.forEach((selectedConfirmationMethodData) {
        if (confirmationMethodData.text!.isContainIgnoreCase(
            selectedConfirmationMethodData.confirmationMethod!)) {
          isSelected = true;
        }
      });
      if (isSelected) {
        confirmationMethodMap[confirmationMethodData.text] = true;
      } else {
        confirmationMethodMap[confirmationMethodData.text] = false;
      }
    });
  }

  setSelectedConfirmationMethod(List<ConfirmationMethodData> list) {
    list.forEach((element) {
      if (confirmationMethodController.text.isEmpty) {
        confirmationMethodController.text = element.confirmationMethod!;
      } else {
        confirmationMethodController.text = confirmationMethodController.text +
            ", " +
            element.confirmationMethod!;
      }
    });
  }

  onCheckSourceApp(bool isChecked, SourceAppData data) {
    if (isChecked) {
      selectedSourceAppList.add(data);
      sourceAppController.clear();
      setSelectedSourceApp(selectedSourceAppList);
    } else {
      selectedSourceAppList.removeWhere((element) => (element.id == data.id));
      sourceAppController.clear();
      setSelectedSourceApp(selectedSourceAppList);
    }
  }

  onCheckConfirmationMethod(
      bool isChecked, ConfirmationMethodData data, String? id) {
    if (isChecked) {
      selectedConfirmationMethodList.add(data);
      selectedConfirmationMethodIdList.add(id);
      confirmationMethodController.clear();
      setSelectedConfirmationMethod(selectedConfirmationMethodList);
    } else {
      selectedConfirmationMethodList.removeWhere((selectedData) => (selectedData
          .confirmationMethod!
          .isContainIgnoreCase(data.confirmationMethod!)));
      selectedConfirmationMethodIdList
          .removeWhere((selectedId) => (selectedId!.isContainIgnoreCase(id!)));
      confirmationMethodController.clear();
      setSelectedConfirmationMethod(selectedConfirmationMethodList);
    }
  }

  updateFeatureMerchant() async {
    isLoading(true);
    merchantRepository
        .updateFeatureMerchants(Get.context, createRequest())
        .then((value) {
      isLoading(false);
      showUpdateResultDialog(Get.context);
    }).catchError((error) {
      isLoading(false);
    });
  }

  showUpdateResultDialog(BuildContext? context) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),
              backgroundColor: DeasyColor.neutral000,
              content: Container(
                width: Get.width / 2.7,
                height: Get.height / 2.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.clear,
                              color: DeasyColor.neutral400, size: 28),
                          onPressed: () {
                            Get.offNamedUntil(
                              Routes.DEALER_MANAGEMENT,
                              ModalRoute.withName(Routes.DASHBOARD_WEB),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        "resources/images/success_verif.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          ContentConstant.dealerManagementEditted,
                          style: TextStyle(
                              fontSize: 15, color: DeasyColor.neutral900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, dynamic>();
    request["supplier_id"] = supplierId;
    request["group_name"] = dealerGroupController.text;
    request["branch_id"] = branchId;
    if (croId!.isNotEmpty) request["cro_id"] = croId;
    request["branch_name"] = branchController.text;
    request["channel"] = channelId;
    List<dynamic> sourceApplications = [];
    selectedSourceAppList.forEach((element) {
      var data = Map<String, dynamic>();
      data["id"] = element.id;
      sourceApplications.add(data);
    });
    request["source_applications"] = sourceApplications;
    List<dynamic> confirmationMethods = [];
    selectedConfirmationMethodIdList.forEach((element) {
      var data = Map<String, dynamic>();
      data["confirmation_method"] = element;
      confirmationMethods.add(data);
    });
    request["confirmation_methods"] = confirmationMethods;
    return request;
  }

  onTapChannel(ChannelData data) {
    channelId = data.channelId;
    channelController.text = data.channelName!;
    isActiveChannel.value = false;
  }

  bool isContainSNBinSourceApp() {
    String search = 'SNB';
    String str = sourceAppController.text;
    List<String> result = str.split(',');
    bool containe = result.any((e) => e.contains(search));
    return containe;
  }
}
