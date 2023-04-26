import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/core/repositories/merchant_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/channel_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dealer/models/confirmation_method_list_response.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/repositories/optimus_source_application_repository.dart';


enum FILTER { CHANNEL, SOURCE_APP, CONFIRMATION_METHOD }

class DealerManagementController extends GetxController {
  late MerchantRepository merchantRepository;
  late OptimusSourceApplicationRepository sourceAppRepository;
  final limit = 10.obs;
  final totalPage = 0.obs;
  final activeSearch = ''.obs;
  final isLoading = true.obs;
  final Rx<MerchantListResponse> dealerListResponse = MerchantListResponse().obs;
  final activeFilter = false.obs;
  final activeEdit = false.obs;
  final lastSyncDate = ''.obs;
  final channelList = <ChannelData>[];
  final sourceAppList = <SourceAppData>[];
  final confirmationMethodList = <ConfirmationMethodsData>[];
  List<Map<String, dynamic>> orderList = [];
  final isDescGroup = true.obs;
  final isDescBranch = true.obs;
  final isDescChannel = true.obs;
  List<String?> filterChannelList = [];
  List<String?> filterSourceAppList = [];
  List<String?> filterConfirmationMethodList = [];
  final isOpenChannelFilter = false.obs;
  final isOpenSourceAppFilter = false.obs;
  final isOpenConfirmationMethodFilter = false.obs;
  RxMap<String?, bool?> channelMap = RxMap<String?, bool?>();
  RxMap<String?, bool?> sourceAppMap = RxMap<String?, bool?>();
  RxMap<String?, bool?> confirmationMethodMap = RxMap<String?, bool?>();
  TextEditingController searchController = TextEditingController();
  bool isActiveChannelFilter = false;
  bool isActiveSourceAppFilter = false;
  bool isActiveConfirmationMethodFilter = false;
  final tableScrollController = ScrollController();
  final isSearching = false.obs;
  List<String?> tempFilterChannel = [];
  List<String?> tempFilterSourceApp = [];
  List<String?> tempFilterConfirmationMethod = [];
  final expandCardHeight = 0.0.obs;
  final int itemCount = 10;

  @override
  void onInit() {
    merchantRepository = MerchantRepository();
    sourceAppRepository = OptimusSourceApplicationRepository();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        isSearching(true);
      } else {
        isSearching(false);
      }
    });

    Future.delayed(Duration.zero, () {
      fetchLastSync();
      fetchApiAllDealers();
      fetchChannels();
      fetchSourceApplications();
      fetchConfirmationMethods();
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void orderGroup() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "group_name";
    orderBody["dir"] = isDescGroup.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllDealers();
  }

  void orderBranch() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "branch_name";
    orderBody["dir"] = isDescBranch.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllDealers();
  }

  void orderChannel() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "channel";
    orderBody["dir"] = isDescChannel.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllDealers();
  }

  void onArrowClick(bool isNext) {
    if (isNext &&
        (dealerListResponse.value.pageInfo!.page !=
            dealerListResponse.value.pageInfo!.nextPage)) {
      fetchApiAllDealers(page: dealerListResponse.value.pageInfo!.nextPage);
    } else if (dealerListResponse.value.pageInfo!.page !=
        dealerListResponse.value.pageInfo!.prevPage) {
      fetchApiAllDealers(page: dealerListResponse.value.pageInfo!.prevPage);
    }
  }

  void onSearchSubmitted(String searchValue) {
    if (searchValue.isNotEmpty) {
      activeSearch.value = searchValue;
    } else {
      activeSearch.value = '';
    }
    fetchApiAllDealers(search: searchValue);
  }

  void onChangeChannelFilter(String? key, bool? value) {
    channelMap[key] = value;
    channelList.forEach((channel) {
      if (channel.channelName == key) {
        if (value!) {
          tempFilterChannel.add(channel.channelId);
          tempFilterChannel = tempFilterChannel.toSet().toList();
        } else {
          tempFilterChannel
              .removeWhere((element) => element == channel.channelId);
        }
      }
    });
  }

  void onChangeSourceAppFilter(String? key, bool? value) {
    sourceAppMap[key] = value;
    sourceAppList.forEach((sourceApp) {
      if (sourceApp.sourceApplication == key) {
        if (value!) {
          tempFilterSourceApp.add(sourceApp.id);
          tempFilterSourceApp = tempFilterSourceApp.toSet().toList();
        } else {
          tempFilterChannel.removeWhere((element) => element == sourceApp.id);
        }
      }
    });
  }

  void onChangeConfirmationMethodFilter(String? key, bool? value) {
    confirmationMethodMap[key] = value;
    confirmationMethodList.forEach((confirmationMethod) {
      if (confirmationMethod.text == key) {
        if (value!) {
          tempFilterConfirmationMethod.add(confirmationMethod.id);
          tempFilterConfirmationMethod =
              tempFilterConfirmationMethod.toSet().toList();
        } else {
          tempFilterConfirmationMethod
              .removeWhere((element) => element == confirmationMethod.id);
        }
      }
    });
  }

  void onApplyFilter() {
    filterChannelList.clear();
    filterChannelList.addAll(tempFilterChannel);

    filterSourceAppList.clear();
    filterSourceAppList.addAll(tempFilterSourceApp);

    filterConfirmationMethodList.clear();
    filterConfirmationMethodList.addAll(tempFilterConfirmationMethod);

    fetchApiAllDealers();

    isOpenConfirmationMethodFilter(false);
    isOpenSourceAppFilter(false);
    isOpenChannelFilter(false);
    expandCardHeight.value = 0;
  }

  fetchChannels() {
    merchantRepository.getChannels(Get.context).then((value) {
      channelList.addAll(value.channels!);
      channelList.forEach((element) {
        if (filterChannelList.contains(element.channelId)) {
          channelMap[element.channelName] = true;
        } else {
          channelMap[element.channelName] = false;
        }
      });
      update();
    }).catchError((error) {});
  }

  fetchSourceApplications() {
    sourceAppRepository.getSourceApplicationList(Get.context).then((value) {
      sourceAppList.addAll(value.listSourceAppData!);
      sourceAppList.forEach((element) {
        if (filterSourceAppList.contains(element.id)) {
          sourceAppMap[element.sourceApplication] = true;
        } else {
          sourceAppMap[element.sourceApplication] = false;
        }
      });
      update();
    }).catchError((error) {});
  }

  fetchConfirmationMethods() {
    merchantRepository.getConfirmationMethods(Get.context).then((value) {
      confirmationMethodList.addAll(value.confirmationMethods!);
      confirmationMethodList.forEach((element) {
        if (filterConfirmationMethodList.contains(element.id)) {
          confirmationMethodMap[element.text] = true;
        } else {
          confirmationMethodMap[element.text] = false;
        }
      });
      update();
    }).catchError((error) {});
  }

  navigateToEdit(String? supplierId) {
    Get.toNamed(Routes.EDIT_DEALER_MANAGEMENT, parameters: {
      "id": supplierId!,
    })!.then((value) => fetchApiAllDealers());
  }

  fetchApiAllDealers({int? page = 1, String search = ''}) {
    isLoading.value = true;
    if (search.isNotEmpty) {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      filters["page"] = page;
      filters["q"] = search;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      if (filterChannelList.isNotEmpty) filters["channel"] = filterChannelList;
      if (filterSourceAppList.isNotEmpty)
        filters["source_applications"] = filterSourceAppList;
      if (filterConfirmationMethodList.isNotEmpty)
        filters["confirmation_methods"] = filterConfirmationMethodList;
      fetchDealer(filters);
    } else {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      filters["page"] = page;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      if (filterChannelList.isNotEmpty) filters["channel"] = filterChannelList;
      if (filterSourceAppList.isNotEmpty)
        filters["source_applications"] = filterSourceAppList;
      if (filterConfirmationMethodList.isNotEmpty)
        filters["confirmation_methods"] = filterConfirmationMethodList;
      fetchDealer(filters);
    }
  }

  void fetchDealer(Map<String, dynamic> filters) {
    merchantRepository.getAllMerchant(Get.context, filters).then((value) {
      isLoading.value = false;
      dealerListResponse.value = value;
      update();
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  syncDealers() {
    merchantRepository.syncMerchant(Get.context).then((value) {
      if (value) {
        if (activeSearch.value.isEmpty) {
          fetchApiAllDealers();
        } else {
          fetchApiAllDealers(search: activeSearch.value);
        }
      }
      fetchLastSync();
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  fetchLastSync() {
    merchantRepository.getLastSync(Get.context).then((value) {
      lastSyncDate.value = value.lastSyncData!.syncDate!;
      DateTime tempDate =
          DateFormat("yyyy-MM-dd HH:mm:ss").parse(lastSyncDate.value);
      lastSyncDate.value = DateFormat("dd/MM/yyyy HH:mm").format(tempDate);
      update();
    }).catchError((error) {});
  }

  clearChannelFilter() {
    channelMap.forEach((key, value) {
      channelMap[key] = false;
    });
    isOpenConfirmationMethodFilter(false);
    isOpenSourceAppFilter(false);
    isOpenChannelFilter(false);
    clearFilterList(FILTER.CHANNEL);
    fetchApiAllDealers();

    expandCardHeight.value = 0;
  }

  clearSourceAppFilter() {
    sourceAppMap.forEach((key, value) {
      sourceAppMap[key] = false;
    });
    isOpenConfirmationMethodFilter(false);
    isOpenSourceAppFilter(false);
    isOpenChannelFilter(false);
    clearFilterList(FILTER.SOURCE_APP);
    fetchApiAllDealers();

    expandCardHeight.value = 0;
  }

  clearConfirmationMethodFilter() {
    confirmationMethodMap.forEach((key, value) {
      confirmationMethodMap[key] = false;
    });
    isOpenConfirmationMethodFilter(false);
    isOpenSourceAppFilter(false);
    isOpenChannelFilter(false);
    clearFilterList(FILTER.CONFIRMATION_METHOD);
    fetchApiAllDealers();

    expandCardHeight.value = 0;
  }

  void clearFilterList(FILTER flag) {
    switch (flag) {
      case FILTER.CHANNEL:
        tempFilterChannel.clear();
        filterChannelList.clear();
        break;
      case FILTER.SOURCE_APP:
        tempFilterSourceApp.clear();
        filterSourceAppList.clear();
        break;
      case FILTER.CONFIRMATION_METHOD:
        tempFilterConfirmationMethod.clear();
        filterConfirmationMethodList.clear();
        break;
      default:
        expandCardHeight.value = 0;
    }
  }

  void copyText(String? text) {
    Clipboard.setData(ClipboardData(text: text));
    DeasySnackBarUtil.showSnackBar(Get.context!, "Text berhasil di copy");
  }

  String concatTextFromList(bool isSourceApp, MerchantData data) {
    String text = "";
    if (isSourceApp) {
      data.sourceApplications!.forEach((element) {
        text = text + element.sourceApplication!;
      });
    } else {
      data.confirmationMethods!.forEach((element) {
        text = text + element.confirmationMethod!;
      });
    }

    return text;
  }

  void openFilterContainer(FILTER flag) {
    int listLength = dealerListResponse.value.merchantData!.length;
    switch (flag) {
      case FILTER.CHANNEL:
        isOpenChannelFilter.toggle();
        isOpenSourceAppFilter(false);
        isOpenConfirmationMethodFilter(false);

        if (listLength < 2 && isOpenChannelFilter.isTrue) {
          expandCardHeight.value = ((limit.value - listLength) * 10).toDouble();
        } else {
          expandCardHeight.value = 0;
        }
        break;
      case FILTER.SOURCE_APP:
        isOpenChannelFilter(false);
        isOpenSourceAppFilter.toggle();
        isOpenConfirmationMethodFilter(false);
        if (listLength < 6 && isOpenSourceAppFilter.isTrue) {
          expandCardHeight.value = ((limit.value - listLength) * 30).toDouble();
        } else {
          expandCardHeight.value = 0;
        }
        break;
      case FILTER.CONFIRMATION_METHOD:
        isOpenChannelFilter(false);
        isOpenSourceAppFilter(false);
        isOpenConfirmationMethodFilter.toggle();
        if (listLength < 2 && isOpenConfirmationMethodFilter.isTrue) {
          expandCardHeight.value = ((limit.value - listLength) * 10).toDouble();
        } else {
          expandCardHeight.value = 0;
        }
        break;
      default:
        expandCardHeight.value = 0;
    }
  }
}
