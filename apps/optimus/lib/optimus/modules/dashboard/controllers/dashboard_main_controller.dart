import 'dart:async';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:deasy_device_info/deasy_device_info.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/model/agent_orders_response.dart';
import 'package:kreditplus_deasy_website/core/model/base_dropdown.dart';
import 'package:kreditplus_deasy_website/core/model/document_response.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/dashboard_search_merchant_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/transaction_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/dialog_payment_detail_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/dialog_preview_downloaded_image_web_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/dialog_tracking_order_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/dialog_upload_web_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/transaction_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_transaction_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/merchant_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/downloader/transaction_download_interface.dart';
import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/core/utils/url_dart_html_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as Excel;
import 'package:universal_html/html.dart' as html;

enum EnumUploadStep {
  init,
  instruction,
  takePhoto,
  preview,
  confirm,
  errorUpload,
  uploaded,
}

class DashboardMainController extends GetxController {
  final urlWrapperClas = Get.find<UrlDartHtmlWrapper>();
  final dialogWrapper = Get.find<DeasyDialogWrapper>();
  final merchantCon = Get.find<MerchantController>();
  final transactionCon = Get.find<DashboardTransactionController>();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final name = ''.obs;
  String? supplierId;
  String? roleId;
  RxBool isVerified = false.obs;
  RxBool isMerchantOnline = false.obs;
  bool isOpened = false;

  final drawerBodyWidth = Get.find<OptimusDrawerCustomController>().bodyWidth;

  final formatCurrency = NumberFormat.simpleCurrency(locale: 'id_ID');
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  RxList<MerchantData> merchants = RxList<MerchantData>();
  RxList<BaseDropdownModel> merchantDropdownList = RxList<BaseDropdownModel>();
  RxBool isMerchantSearchBoxTapped = false.obs;
  TextEditingController? textEditingSearchMerchantController;
  TextEditingController? textEditingTableSearchTransactionMerchantController;
  RxList<BaseDropdownModel> searchResult = RxList<BaseDropdownModel>();
  String searchText = "";
  RxInt nextPage = 1.obs;
  RxInt merchantSearchResultCurrentPage = 1.obs;
  RxInt totalPage = 1.obs;
  RxBool isLoading = true.obs;
  ScrollController scrollController = ScrollController();
  RxBool isAdmin = false.obs;
  List<String> buttonList = ['Hari', 'Bulan', 'Tahun'];
  RxInt selectedIndexButton = 0.obs;
  final incomingValue = 0.0.obs;
  RxInt totalAplikasi = 0.obs;
  RxString textIncomeByTime = 'Hari'.obs;
  RxString selectedMerchantName = ''.obs;
  String pdfUrl = '';

  Map<String, dynamic>? filters;
  String? idNumber;
  final limit = 10.obs;
  String? orderDateFrom;
  String? orderDateTo;
  String? orderStatus;
  String? prospectId;
  final Rx<TransactionResponse> transactionResponse = TransactionResponse().obs;
  RxList<TransactionResponseData> transactionList =
      RxList<TransactionResponseData>();
  Rx<DateTime> activeStartDate = DateTime.now().obs;
  Rx<DateTime> activeEndDate = DateTime.now().obs;
  DateTime dateTimeNow = DateTime.now();
  DateTime? dateTime30DaysBefore;
  ScrollController tableScrollController = ScrollController();
  RxBool isOpenStatusFilter = false.obs;
  RxBool isOpenDateFilter = false.obs;
  RxMap<String, bool?> statusMap = RxMap<String, bool?>();
  Rxn<DateTime> minDate = Rxn<DateTime>();
  Rx<DateTime> maxDate = DateTime.now().obs;
  RxList<String> statusFilterList = RxList<String>();
  final RxList<Map<String, dynamic>> orderList = <Map<String, dynamic>>[].obs;
  final isProspectIdDesc = true.obs;
  final isCustomerNameDesc = true.obs;
  final isMerchantNameDesc = true.obs;
  final isOtrDesc = true.obs;
  final isOrderDateDesc = true.obs;
  final isOrderStatusDesc = true.obs;
  TransactionDownloader? downloader;
  RxInt expandedIndex = 0.obs;
  static const EPO_DOCUMENT_SLUG = "EPO";
  static const INVOICE_DOCUMENT_SLUG = "INVOICE";
  static const BAST_DOCUMENT_SLUG = "BAST";
  RxBool isImageLoaded = false.obs;
  RxBool isSnapNBuyOrder = false.obs;
  RxBool isUploading = false.obs;
  RxBool highlight = false.obs;
  late DropzoneViewController dropZoneController;
  XFile? imageFile;
  late Uint8List imageBytes;
  bool isSuccess = false;
  RxBool isFileNotAllowed = false.obs;
  RxInt imageHeight = 0.obs;
  RxBool isLoadCustReceipt = false.obs;
  RxBool isLoadBast = false.obs;
  final searchQuery = "".obs;
  final index = 1.obs;
  DashboardRepository _dashboardRepository;
  TransactionRepository _transactionRepository;
  final PagingController<int, DashboardSearchMerchantData>
      searchMerchantPagingController = PagingController(firstPageKey: 0);
  static const _pageSize = 5;
  final String _dateFormat = "yyyy-MM-dd";
  Timer? debounce;
  static const ONE_THOUSAND_MILLISECOND = 1000;
  final hasInvoiceAccess = false.obs;
  final hasPOAccess = false.obs;
  final hasViewBuktiTerimaAccess = false.obs;
  final hasUploadBuktiTerimaAccess = false.obs;
  final hasViewImeiAccess = false.obs;
  final hasUploadImeiAccess = false.obs;
  final hasViewBASTAccess = false.obs;
  final hasUploadBASTAccess = false.obs;
  final hasAdmin = false.obs;
  final hasSelectMerchantAccess = false.obs;
  final RxList<String> documentAccessList = <String>[].obs;

  final error = ''.obs;
  final RxList<CameraDescription> cameras = <CameraDescription>[].obs;
  final isInitialized = false.obs;
  final isLoadingCam = false.obs;

  Rxn <CameraController> cameraController = Rxn<CameraController>();
  Rxn <CameraDescription> cameraDescription = Rxn<CameraDescription>();
  final Rx<EnumUploadStep> uploadStep = EnumUploadStep.init.obs;
  final previewImagePath = "".obs;
  final uploadDialogHeaderTitle = "".obs;
  final uploadErrorMessage = "".obs;
  String role = "";
  final Rx<DeasyDeviceInfo> device = Get.find<DeasyDeviceInfo>().obs;
  String? browserType;

  DashboardMainController(
      {required DashboardRepository dashboardRepository,
      required TransactionRepository transactionRepository})
      : _dashboardRepository = dashboardRepository,
        _transactionRepository = transactionRepository;

  @override
  void onInit() async {
    initUserData();
    getBrowserType();
    textEditingTableSearchTransactionMerchantController = TextEditingController();
    searchMerchantPagingController.addPageRequestListener((pageKey) {
      fetchApiDashboardsMerchantsByName(
          pageKey, textEditingSearchMerchantController!.text);
    });

    await DeasyPocket().getRole().then((value) {
      isAdmin.value = value.isContainIgnoreCase("super admin") ? true : false;
    });
    name.value = await DeasyPocket().getName();
    supplierId = await DeasyPocket().getSupplierId();
    roleId = await DeasyPocket().getRoleId();

    await fetchRoleDetail();
    getRole();
    onTapButtonFilterSummary(0);

    if(isAdmin.isTrue) {
      fetchApiDashboardsMerchants();
    }

    filters = new Map<String, dynamic>();
    limit.value = 10;
    dateTime30DaysBefore =
        DateTime(dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 30);
    orderDateFrom = dateTimeNow.toFormattedDate(format: _dateFormat);
    orderDateTo = dateTimeNow.toString().toFormattedDate(format: _dateFormat);
    fetchApiAllOrdersByPage();

    textEditingSearchMerchantController = TextEditingController();
    textEditingSearchMerchantController!.addListener(() {
      searchQuery.value = textEditingSearchMerchantController!.text;
    });

    statusMap[ContentConstant.STATUS_ON_PROGRESS] = false;
    statusMap[ContentConstant.STATUS_APPROVED] = false;
    statusMap[ContentConstant.STATUS_REJECT] = false;
    statusMap[ContentConstant.STATUS_CANCELED] = false;
    statusMap[ContentConstant.STATUS_CANCEL_REQUEST] = false;
    statusMap[ContentConstant.STATUS_PURCHASE_CONFIRMED] = false;
    statusMap[ContentConstant.STATUS_PAID] = false;

    downloader = TransactionDownloader();

    super.onInit();
  }

  @override
  void onClose() {
    searchMerchantPagingController.dispose();
    supplierId!.toCleanString();
    html.Url.revokeObjectUrl(pdfUrl);
    super.onClose();
  }

  initUserData() async {
    final SharedPreferences sharedPreferences = await _prefs;
    isVerified.value = sharedPreferences.getBool("isVerified")!;
    isMerchantOnline.value = sharedPreferences.getBool("isMerchantOnline")!;
  }

  getBrowserType() async {
    device.value.getBrowserType().then((value) {
      browserType = value;
    });
  }

  getRole() async {
    await DeasyPocket().getRole().then((value) {
      role = value;
    });
  }

  Future<void> getCameras() async {
    try {
      cameras.clear();
      final availableCamerasList = await availableCameras();
      cameras.addAll(availableCamerasList);
      if (DeasySizeConfigUtils.isTab || DeasySizeConfigUtils.isMobile) {
        if (isContainRearCam()) {
          cameraDescription.value = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
        } else if (isContainExternalCam()) {
          cameraDescription.value = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.external);
        } else {
          cameraDescription.value = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
        }
      } else {
        if (isContainExternalCam()) {
          cameraDescription.value = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.external);
        } else {
          cameraDescription.value = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
        }
      }
    } catch (e) {
      handleCameraError(e);
    }
  }

  bool isContainExternalCam() {
    var isContain = false;
    cameras.forEach((element) {
      if (element.lensDirection == CameraLensDirection.external) {
        isContain = true;
      }
    });

    return isContain;
  }

  bool isContainRearCam() {
    var isContain = false;
    cameras.forEach((element) {
      if (element.lensDirection == CameraLensDirection.back) {
        isContain = true;
      }
    });

    return isContain;
  }

  Future<void> initCam() async {
    try {
      var resolutionPreset = (DeasySizeConfigUtils.isTab || DeasySizeConfigUtils.isMobile)
        ? ResolutionPreset.veryHigh
        : ResolutionPreset.max;

      cameraController.value = CameraController(
        cameraDescription.value!,
        resolutionPreset,
        enableAudio: false
      );
      
      await cameraController.value!.initialize();
      isInitialized(true);
      isLoadingCam(false);
    } catch (e) {
      handleCameraError(e);
    }
  }

  void activateCamera() async {
    try {
      isLoadingCam(true);
      showTakePhotoDialog();
      await getCameras();
      if (cameraDescription.value != null) {
        initCam();
      } else {
        cameras.clear();
        isLoadingCam(false);
      }
    } catch (e) {
      handleCameraError(e);
    }
  }

  void handleCameraError(e) {
    isLoadingCam(false);
    if (e is CameraException &&
        (e.code.isContainIgnoreCase("CameraAccessDenied") ||
        e.code.isContainIgnoreCase("AudioAccessDenied"))
    ) {
      cameras.clear();
    } else {
      error.value = "$e";
    }
  }

  void showInstructionDialog() {
    uploadStep.value = EnumUploadStep.instruction;
    previewImagePath.value = "";
  }

  void showTakePhotoDialog() {
    uploadStep.value = EnumUploadStep.takePhoto;
  }

  void showPreviewDialog() {
    uploadStep.value = EnumUploadStep.preview;
  }

  void showConfirmDialog() {
    uploadStep.value = EnumUploadStep.confirm;
  }

  void showErrorUploadDialog() {
    uploadStep.value = EnumUploadStep.errorUpload;
  }

  void showUploadedDialog() {
    uploadStep.value = EnumUploadStep.uploaded;
  }

  void findTransaction(String query) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce =
        Timer(const Duration(milliseconds: ONE_THOUSAND_MILLISECOND), () async {
      if (query.isBlank!) {
        clearList();
        fetchApiAllOrdersByPage();
      } else {
        clearList();
            fetchApiAllOrdersByPage(
                page: index.value,
                search: query
            );
      }
    });
  }

  void clearList() {
    transactionList.clear();
    index.value = 1;
  }

  fetchApiAllOrdersByPage({int? page = 1, String search = '', bool isDownload = false}) async {
    filters!["page"] = isDownload ? -1 : page;
    if (idNumber != null) filters!["id_number"] = idNumber;
    if (limit.value != null) filters!["limit"] = isDownload ? -1 : limit.value;
    if (orderList.isNotEmpty) filters!["order_by"] = orderList;
    if (orderDateFrom != null) filters!["order_date_from"] = orderDateFrom;
    if (orderDateTo != null) filters!["order_date_to"] = orderDateTo;
    if (orderStatus != null) filters!["order_status"] = orderStatus;
    if (prospectId != null) filters!["prospect_id"] = prospectId;
    if (search != null || search.isNotEmpty) filters!["search"] = search;
    if (supplierId != null) filters!["supplier_id"] = supplierId;
    if (statusFilterList.isNotEmpty) filters!["order_status"] = statusFilterList;
    statusFilterList.isNotEmpty
        ? await fetchAllOrdersByFilter(filters)
        : await fetchApiAllOrders(filters);
  }

  fetchApiAllOrders(Map<String, dynamic>? requestBody) async {
    isLoading.value = true;
    await _transactionRepository
        .fetchApiAllOrders(Get.context, requestBody)
        .then((value) {
      transactionList.value = value.data!;
      transactionResponse.value = value;
      isLoading.value = false;
      statusFilterList.clear();
    });
  }

  fetchAllOrdersByFilter(Map<String, dynamic>? requestBody) async {
    isLoading.value = true;
    await _transactionRepository
        .fetchApiAllOrders(Get.context, requestBody)
        .then((value) {
      transactionList.value = value.data!;
      transactionResponse.value = value;
      isLoading.value = false;
    });
  }

  void expandRow(int rowIndex) {
    if (expandedIndex.value == rowIndex) {
      expandedIndex.value = 0;
    } else {
      expandedIndex.value = rowIndex;
    }
  }

  Future<void> fetchRoleDetail() async {
    DashboardPermission dashboardPermission = await DeasyPocket()
      .getRoleDashboardPermission()
      .then((value) => DashboardPermission.fromJson(value));

    RoleData roleData = await DeasyPocket()
      .getRoleDetail()
      .then((value) => RoleData.fromJson(value));

    if (dashboardPermission != null) {
      bool viewPO = dashboardPermission.po!;
      bool viewInvoice = dashboardPermission.invoice!;
      bool viewBuktiTerima = dashboardPermission.viewBuktiTerima!;
      bool? uploadBuktiTerima = dashboardPermission.uploadBuktiTerima;
      bool viewImei = dashboardPermission.viewImei!;
      bool? uploadImei = dashboardPermission.uploadImei;
      bool viewBast = dashboardPermission.viewBast!;
      bool? uploadBast = dashboardPermission.uploadBast;
      bool isRoot = roleData.isRoot ?? false;
      bool offline = dashboardPermission.offline!;
      bool? snb = dashboardPermission.snb;
      bool? online = dashboardPermission.online;

      hasAdmin(isRoot);

      if (offline && snb! && online!) {
        hasSelectMerchantAccess(true);
      }

      if (viewPO) {
        hasPOAccess(viewPO);
        documentAccessList.add(ContentConstant.PO);
      }

      if (viewImei || uploadImei!) {
        hasViewImeiAccess(viewImei);
        hasUploadImeiAccess(uploadImei!);
        documentAccessList.add(ContentConstant.NOMOR_IMEI);
      }

      if (viewBuktiTerima || uploadBuktiTerima!) {
        hasViewBuktiTerimaAccess(viewBuktiTerima);
        hasUploadBuktiTerimaAccess(uploadBuktiTerima!);
        documentAccessList.add(ContentConstant.BUKTI_TERIMA);
      }
      if (viewInvoice) {
        hasInvoiceAccess(viewInvoice);
        documentAccessList.add(ContentConstant.INVOICE);
      }

      if (viewBast || uploadBast!) {
        hasViewBASTAccess(viewBast);
        hasUploadBASTAccess(uploadBast!);
        documentAccessList.add(ContentConstant.BAST);
      }
    }

  }


  void onPreview(String documentAccess, TransactionResponseData data) {
    switch (documentAccess) {
      case ContentConstant.PO:
        fetchApiDocumentById(data, ContentConstant.EPO);
        break;
      case ContentConstant.INVOICE:
        fetchApiDocumentById(data, ContentConstant.INVOICE.toUpperCase());
        break;
      case ContentConstant.BUKTI_TERIMA:
        previewImage(data.prospectId, ContentConstant.BUKTI_TERIMA);
        break;
      case ContentConstant.BAST:
        previewImage(data.prospectId, ContentConstant.BAST);
        break;
      case ContentConstant.NOMOR_IMEI:
        previewImage(data.prospectId, ContentConstant.IMEI);
        break;
    }
  }

  void onUpload(String documentAccess, TransactionResponseData data) {
    if (documentAccess == ContentConstant.INVOICE ||
        documentAccess == ContentConstant.PO) {
      return;
    }

    uploadStep.value = EnumUploadStep.init;
    dialogWrapper.dialog(
      DialogUploadWebWidget(
        data,
        data.prospectId,
        documentAccess,
      )
    ).whenComplete(() async {
      if (cameraController.value != null) {
        await cameraController.value!.dispose();
      }

      if (isSuccess) {
        fetchApiAllOrdersByPage(page: transactionResponse.value.pageInfo!.page);
      }
    });
    isInitialized(false);
    onFinishClearField();
  }

  String action(String documentAccess, TransactionResponseData data) {
    switch (documentAccess) {
      case ContentConstant.PO:
        if ((data.epoDate != null) &&
            (data.orderStatus.id == ContentConstant.STATUS_APPROVED ||
                data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                data.orderStatus.id == ContentConstant.STATUS_DISBURSED)) {
          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
        }
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
      case ContentConstant.NOMOR_IMEI:
        if ((data.imeiUrl!.isEmpty) &&
            (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
            data.orderStatus.id == ContentConstant.STATUS_DISBURSED)) {
          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
        }

        if ((data.imeiUrl!.isNotEmpty) &&
            (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
            data.orderStatus.id == ContentConstant.STATUS_DISBURSED ||
            data.orderStatus.id == ContentConstant.STATUS_APPROVED)) {
          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
        }

        if ((data.imeiUrl!.isEmpty) &&
            (data.orderStatus.id == ContentConstant.STATUS_APPROVED)) {
          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD;
        }

        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
      case ContentConstant.INVOICE:
        if (data.invoiceDate != null &&
            (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
             data.orderStatus.id == ContentConstant.STATUS_DISBURSED)) {
          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
        }
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
      case ContentConstant.PO:
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
      case ContentConstant.BUKTI_TERIMA:
        var isBuktiTerima = false;
        if (data.confirmationMethods!.isNotEmpty) {
          data.confirmationMethods!.forEach((element) {
            if (element.confirmationMethod!.toUpperCase() == ContentConstant.BUKTI_TERIMA.toUpperCase()) {
              isBuktiTerima = true;
            }
          });
        }

        if (isBuktiTerima) {
          if (hasViewBuktiTerimaAccess.isTrue && hasUploadBuktiTerimaAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS ||
                data.orderStatus.id == ContentConstant.STATUS_CANCEL_REQUEST ||
                data.orderStatus.id == ContentConstant.STATUS_CANCELED ||
                data.orderStatus.id == ContentConstant.STATUS_REJECT) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
            }

            if (data.customerReceiptPhotoUrl!.isNotEmpty &&
                (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                    data.orderStatus.id == ContentConstant.STATUS_DISBURSED ||
                    data.orderStatus.id == ContentConstant.STATUS_APPROVED)) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD;
          }

          if (hasViewBuktiTerimaAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS ||
                data.orderStatus.id == ContentConstant.STATUS_CANCEL_REQUEST ||
                data.orderStatus.id == ContentConstant.STATUS_CANCELED ||
                data.orderStatus.id == ContentConstant.STATUS_REJECT) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
            }

            if (data.customerReceiptPhotoUrl!.isNotEmpty &&
                (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                    data.orderStatus.id == ContentConstant.STATUS_DISBURSED ||
                    data.orderStatus.id == ContentConstant.STATUS_APPROVED)) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
          }

          if (hasUploadBuktiTerimaAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS ||
                data.orderStatus.id == ContentConstant.STATUS_CANCEL_REQUEST ||
                data.orderStatus.id == ContentConstant.STATUS_CANCELED ||
                data.orderStatus.id == ContentConstant.STATUS_REJECT) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
            }

            if (data.customerReceiptPhotoUrl!.isNotEmpty &&
                (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                    data.orderStatus.id == ContentConstant.STATUS_DISBURSED ||
                    data.orderStatus.id == ContentConstant.STATUS_APPROVED)) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD;
          }
        }
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
      case ContentConstant.BAST:
        var isBast = false;
        if (data.confirmationMethods!.isNotEmpty) {
          data.confirmationMethods!.forEach((element) {
            if (element.confirmationMethod == ContentConstant.BAST) {
              isBast = true;
            }
          });
        }

        if (isBast) {
          if (hasViewBASTAccess.isTrue && hasUploadBASTAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                data.orderStatus.id == ContentConstant.STATUS_DISBURSED) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
            }

            if (data.orderStatus.id == ContentConstant.STATUS_APPROVED) {
              if (data.sourceApplication == ContentConstant.SNB &&
                  data.customerReceiptPhotoUrl!.isEmpty) {
                return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
              }
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
          }

          if (hasViewBASTAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED ||
                data.orderStatus.id == ContentConstant.STATUS_DISBURSED) {
              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
          }

          if (hasUploadBASTAccess.isTrue) {
            if (data.orderStatus.id == ContentConstant.STATUS_APPROVED) {
              if (data.sourceApplication == ContentConstant.SNB &&
                  data.customerReceiptPhotoUrl!.isEmpty) {
                return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
              }

              return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD;
            }

            return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
          }

          return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
        }
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
      default:
        return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
    }
  }
  

  Future<bool> isHasRequestCancelAccess(TransactionResponseData data) async {
    bool isAWB = false;
    bool isHasRequestCancel = false;
    String? shippingStatus = "";
    
    if (data.confirmationMethods!.isNotEmpty) {
      data.confirmationMethods?.forEach((element) {
        if (element.confirmationMethod == ContentConstant.AWB) {
          isAWB = true;
        }
      });
    }

    if (isAWB) {
      await _dashboardRepository
          .fetchApiDashboardOrderStatus(Get.context, data.prospectId)
          .then((value) {
            shippingStatus = value.data?.status;
      }).catchError((error){
        print("Log: ${data.prospectId} messaage: $error");
      }).whenComplete((){
        if(data.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS){
          isHasRequestCancel = true;
        }

        if(data.orderStatus.id == ContentConstant.STATUS_APPROVED){
          if (shippingStatus == "-" ||
              shippingStatus == "" ||
              shippingStatus!.isEqualIgnoreCase(ContentConstant.TRACKING_STATUS_GOODS_BEING_PACKED)){
                isHasRequestCancel = true;
          }
        }
      });

      return isHasRequestCancel;
    } else {
      if (data.orderStatus.id == ContentConstant.STATUS_ON_PROGRESS) {
        if (data.sourceApplication!.isContainIgnoreCase(ContentConstant.eformSourceApp)) {
          isHasRequestCancel = false;
        }
        if (data.sourceApplication!.isContainIgnoreCase(ContentConstant.snbSourceApp)) {
          isHasRequestCancel = true;
        }
      }

      if (data.orderStatus.id == ContentConstant.STATUS_APPROVED) {
        isHasRequestCancel = true;
      }

      return isHasRequestCancel;
    }
  }

  bool hasInfoAccess(TransactionResponseData data) {
    String access = getInfoAccess(data);
    if (access == ContentConstant.trackingFlag ||
        access == ContentConstant.paidFlag) {
      return true;
    }
    return false;
  }

  String getInfoAccess(TransactionResponseData data) {
    var isAWB = false;
    if (data.confirmationMethods!.isNotEmpty) {
      data.confirmationMethods!.forEach((element) {
        if (element.confirmationMethod == ContentConstant.AWB) {
          isAWB = true;
        }
      });
    }

    if (isAWB) {
      if (data.orderStatus.id == ContentConstant.STATUS_APPROVED) {
        if (data.trackingExists!) {
          return ContentConstant.trackingFlag;
        }
        return ContentConstant.trackingFlag;
      }

      if (data.orderStatus.id == ContentConstant.STATUS_PURCHASE_CONFIRMED) {
        return ContentConstant.trackingFlag;
      }

      if (data.orderStatus.id == ContentConstant.STATUS_DISBURSED) {
        return ContentConstant.paidFlag;
      }
    } else {
      if (data.orderStatus.id == ContentConstant.STATUS_DISBURSED) {
        return ContentConstant.paidFlag;
      }
      return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
    }

    return ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE;
  }

  Future<bool> fetchApiDashboardsMerchantsByName(int pageKey, String searchKey) async {
    try {
      final newItems = await _dashboardRepository
          .fetchApiDashboardSearchMerchants(Get.context,
              searchKey: searchKey, page: pageKey, limit: _pageSize);
      final isLastPage = newItems.data!.length < _pageSize;
      if (isLastPage) {
        searchMerchantPagingController.appendLastPage(newItems.data!);
        return isLastPage;
      } else {
        pageKey++;
        searchMerchantPagingController.appendPage(newItems.data!, pageKey);
        return isLastPage;
      }
    } catch (error) {
      searchMerchantPagingController.error = error;
      return false;
    }
  }

  Future fetchApiDashboardsMerchants({int page = 1}) async {
    merchantCon
        .fetchApiDashboardsMerchants(context: Get.context, limit: 7, page: page)
        .then((value) {
      merchants.value = value!.merchantData!;
      merchantSearchResultCurrentPage.value = value.pageInfo!.page!;
      nextPage.value = value.pageInfo!.nextPage!;
      totalPage.value = value.pageInfo!.totalPage!;
      if (searchText.isNotEmpty) {
        if (searchResult.length == 0) {
          merchants.forEach((element) {
            searchResult.add(
                BaseDropdownModel(id: element.supplierId, name: element.name));
          });
        }
      } else {
        merchants.forEach((element) {
          merchantDropdownList.add(
              BaseDropdownModel(id: element.supplierId, name: element.name));
        });
      }
      merchants.clear();
    }, onError: (e) {});

    isLoading.value = false;
  }

  onTapShowMerchantSearch() {
    isMerchantSearchBoxTapped.toggle();
  }

  onTapSelectMerchant(String? merchantId, String merchantName) {
    supplierId = merchantId;
    selectedMerchantName.value = merchantName;
    textEditingSearchMerchantController!.clear();
    isMerchantSearchBoxTapped.toggle();
    onTapButtonFilterSummary(0);
    fetchApiAllOrdersByPage();
  }

  onSearchTextChanged() {
    searchMerchantPagingController.refresh();
  }

  String selectedTimeButton = 'hari';

  onTapButtonFilterSummary(int selected) {
    switch (selected) {
      case 0:
        {
          selectedIndexButton.value = selected;
          transactionCon
              .fetchApiDashboardsDays(supplierId: supplierId)
              .then((value) {
            incomingValue.value = transactionCon.incomingValue!;
            totalAplikasi.value = transactionCon.incomingQty!;
          });

          textIncomeByTime.value = 'Hari';
        }
        break;
      case 1:
        {
          selectedIndexButton.value = selected;
          transactionCon
              .fetchApiDashboardsMonths(supplierId: supplierId)
              .then((value) {
            incomingValue.value = transactionCon.incomingValue!;
            totalAplikasi.value = transactionCon.incomingQty!;
          });

          textIncomeByTime.value = 'Bulan';
        }
        break;
      case 2:
        {
          selectedIndexButton.value = selected;
          transactionCon
              .fetchApiDashboardsYears(supplierId: supplierId)
              .then((value) {
            incomingValue.value = transactionCon.incomingValue!;
            totalAplikasi.value = transactionCon.incomingQty!;
          });
          textIncomeByTime.value = 'Tahun';
        }
        break;
      default:
        return selectedIndexButton.value = 0;
    }
  }

  navigateToCancelRequest(String? orderId) {
    Get.toNamed(Routes.DASHBOARD_CANCEL_REQUEST, arguments: {
      "id": orderId,
    })!.then((value) =>
        fetchApiAllOrdersByPage(page: transactionResponse.value.pageInfo!.page));
  }

  onClickStatusFilter() {
    isOpenStatusFilter.toggle();
    isOpenDateFilter.value = false;
  }

  onClickDateFilter() {
    isOpenDateFilter.toggle();
    isOpenStatusFilter.value = false;
  }

  clearStatusFilter() {
    statusMap.forEach((key, value) {
      statusMap[key] = false;
      statusFilterList.clear();
    });

    fetchApiAllOrdersByPage();
    isOpenStatusFilter(false);
  }

  onApplyStatusFilter() {
    statusFilterList.clear();
    statusMap.forEach((key, value) {
      if (value == true) {
        if (key == "Paid") {
          statusFilterList.add("Disbursed");
        } else {
          final List<String> _keyPool = [];
          _keyPool.add(key);
          var _selectedKey = _keyPool.toSet().toList();
          statusFilterList.addAll(_selectedKey);
        }
      } else {
        statusFilterList.remove(key);
      }
    });
    fetchApiAllOrdersByPage();
    isOpenStatusFilter(false);
  }

  onSelectedDateChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      DateTime selectedStartDate = args.value.startDate;
      maxDate(selectedStartDate.nextMonth(months: 1));
      minDate(selectedStartDate.previousMonth(months: 1));
    }
  }

  void onDateFilterCancel(){
    isOpenDateFilter.toggle();
    maxDate.value = dateTimeNow;
    minDate.value = null;
  }

  void onDateFilterConfirmed(DateTime startDate, DateTime endDate) {
    orderDateFrom = startDate.toFormattedDate(format: _dateFormat);
    orderDateTo = endDate.toFormattedDate(format: _dateFormat);
    activeStartDate.value = startDate;
    activeEndDate.value = endDate;
    fetchApiAllOrdersByPage();
    isOpenDateFilter.toggle();
    maxDate.value = dateTimeNow;
    minDate.value = null;
  }

  void sortingProspectId() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "prospect_id";
    orderBody["dir"] = isProspectIdDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  void sortingCustomerName() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "customer_name";
    orderBody["dir"] = isCustomerNameDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  void sortingMerchantName() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "supplier_name";
    orderBody["dir"] = isMerchantNameDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  void sortingOtr() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "otr";
    orderBody["dir"] = isOtrDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  void sortingOrderDate() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "order_date";
    orderBody["dir"] = isOrderDateDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  void sortingOrderStatus() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "order_status";
    orderBody["dir"] = isOrderStatusDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllOrdersByPage();
  }

  Future<Excel.Worksheet?> generateExcel() async {
    Get.back();
    
    await fetchApiAllOrdersByPage(isDownload: true);
    try {
      final Excel.Workbook workbook = Excel.Workbook();
      Excel.Style globalStyle = workbook.styles.add('style');
      globalStyle.wrapText = true;
      globalStyle.indent = 1;
      globalStyle.hAlign = Excel.HAlignType.left;
      final Excel.Worksheet sheet = workbook.worksheets[0];
      sheet.getRangeByName('A1:H1').cellStyle.bold = true;
      sheet.getRangeByName('A1:H1').cellStyle.hAlign = Excel.HAlignType.left;
      sheet.getRangeByName('A1:H1').cellStyle.indent = 1;
      sheet.getRangeByName('A1').setText('Order ID');
      sheet.getRangeByName('B1').setText('Harga');
      sheet.getRangeByName('C1').setText('Tanggal');
      sheet.getRangeByName('D1').setText('Status');
      sheet.getRangeByName('E1').setText('Tanggal Terbit Invoice');
      sheet.getRangeByName('F1').setText('Tanggal Go Live');
      sheet.getRangeByName('G1').setText('Pembayaran Ke Dealer');
      sheet.getRangeByName('H1').setText('Tanggal Pembayaran Ke Dealer');
      transactionList.asMap().forEach((index, value) {
        sheet.getRangeByName(getIndex("A", index)).setText(value.prospectId);

        sheet
            .getRangeByName(getIndex("B", index))
            .setText(value.otr.toString().toRupiah());

        sheet.getRangeByName(getIndex("C", index)).setText(
            value.orderDate.toString().toFormattedDate(format: _dateFormat));

        if (value.orderStatus.name == null || value.orderStatus.name.isBlank!) {
          sheet.getRangeByName(getIndex("D", index)).setText("-");
        } else {
          sheet
              .getRangeByName(getIndex("D", index))
              .setText(value.orderStatus.name);
        }

        if (value.invoiceDate == null) {
          sheet.getRangeByName(getIndex("E", index)).setText("-");
        } else {
          sheet.getRangeByName(getIndex("E", index)).setText(value.invoiceDate
              .toString()
              .toFormattedDate(format: _dateFormat));
        }

        if (value.goLiveDate == null) {
          sheet.getRangeByName(getIndex("F", index)).setText("-");
        } else {
          sheet.getRangeByName(getIndex("F", index)).setText(
              value.goLiveDate.toString().toFormattedDate(format: _dateFormat));
        }

        if (value.payToDealerAmount == null) {
          sheet.getRangeByName(getIndex("G", index)).setText("-");
        } else {
          sheet
              .getRangeByName(getIndex("G", index))
              .setText(value.payToDealerAmount.toString().toRupiah());
        }

        if (value.payToDealerDate == null) {
          sheet.getRangeByName(getIndex("H", index)).setText("-");
        } else {
          sheet.getRangeByName(getIndex("H", index)).setText(value
              .payToDealerDate
              .toString()
              .toFormattedDate(format: _dateFormat));
        }
      });

      final Excel.Range A = sheet.getRangeByName('A2:A1000');
      final Excel.Range B = sheet.getRangeByName('B2:B1000');
      final Excel.Range C = sheet.getRangeByName('C2:C1000');
      final Excel.Range D = sheet.getRangeByName('D2:D1000');
      final Excel.Range E = sheet.getRangeByName('E2:E1000');
      final Excel.Range F = sheet.getRangeByName('F2:F1000');
      final Excel.Range G = sheet.getRangeByName('G2:G1000');
      final Excel.Range H = sheet.getRangeByName('H2:H1000');
      A.cellStyle = globalStyle;
      B.cellStyle = globalStyle;
      C.cellStyle = globalStyle;
      D.cellStyle = globalStyle;
      E.cellStyle = globalStyle;
      F.cellStyle = globalStyle;
      G.cellStyle = globalStyle;
      H.cellStyle = globalStyle;

      A.columnWidth = 25;
      B.columnWidth = 25;
      C.columnWidth = 25;
      D.columnWidth = 21;
      E.columnWidth = 25;
      F.columnWidth = 25;
      G.columnWidth = 25;
      H.columnWidth = 25;

      final List<int> bytes = workbook.saveAsStream();
      if(downloader != null){
        downloader!.downloadFile(
          bytes, "Report $orderDateFrom - $orderDateTo.xlsx");
      }

      await fetchApiAllOrdersByPage();

      return sheet;
    } catch (e) {
      Future.delayed(Duration(seconds: 1), () {
        Get.back();
        DeasySnackBarUtil.showFlushBarError(
            Get.context!, ContentConstant.failedReportDownload);
      });
      return null;
    }
  }

  getIndex(String key, int index) {
    return "$key${index + 2}";
  }

  fetchApiDocumentById(
      TransactionResponseData transaction, String documentType) {
    DocumentData? epoData;
    DocumentData? invoiceData;
    _transactionRepository
        .fetchApiDocumentById(Get.context, null, transaction.prospectId)
        .then((value) {
      value.data!.forEach((element) {
        if (element.name!.isContainIgnoreCase(EPO_DOCUMENT_SLUG)) {
          epoData = element;
        } else if (element.name!.isContainIgnoreCase(INVOICE_DOCUMENT_SLUG)) {
          invoiceData = element;
        }
      });

      switch (documentType) {
        case EPO_DOCUMENT_SLUG:
          if (epoData != null) {
            downloadDocument(epoData!.name, "epo", transaction.prospectId);
          } else {
            _showDocumentNotFoundSnackBar();
          }
          break;
        case INVOICE_DOCUMENT_SLUG:
          if (invoiceData != null) {
            downloadDocument(invoiceData!.name, "Invoice", transaction.prospectId);
          } else {
            _showDocumentNotFoundSnackBar();
          }
          break;
      }
    }).catchError((error) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, error);
    });
  }

  _showDocumentNotFoundSnackBar() {
    DeasySnackBarUtil.showFlushBarError(Get.context!, ContentConstant.documentNotFound);
  }

  downloadDocument(String? name, String flag, String? prospectId) {
    _transactionRepository
        .fetchDocument(Get.context, null, prospectId, "${flag.camelCase}")
        .then((value) {
      html.Url.revokeObjectUrl(pdfUrl);
      final pdfBytes = value;
      final blob = html.Blob([pdfBytes], 'application/pdf');
      pdfUrl = urlWrapperClas.createObjectUrlFromBlob(blob);
      html.window.open(pdfUrl, '_blank');
    });
  }

  previewImage(String? prospectId, String flag) async {
    String fetchDocumentFlag = flag.isContainIgnoreCase(ContentConstant.BUKTI_TERIMA)
      ? ContentConstant.CUSTOMER.toLowerCase() : flag.toLowerCase();

    _transactionRepository
        .fetchDocument(Get.context, null, prospectId, "$fetchDocumentFlag")
        .then((value) {
      var bytes = value;
      isImageLoaded.value = true;

      dialogWrapper.dialog(DialogPreviewDownloadedImageWebWidget(flag, bytes));
      onFinishClearField();
    }).catchError((error) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, "Foto $flag Tidak Ditemukan");
    });
  }

  takePhoto() async {
    imageFile = await cameraController.value?.takePicture();
    imageBytes = (await imageFile?.readAsBytes())!;
    previewImagePath.value = imageFile!.path;
    await cameraController.value?.dispose();
    isInitialized(false);
  }

  onDropFile(ev) async {
    if (ev != null) {
      try {
        final fileData = await dropZoneController.getFileData(ev);
        final url = await dropZoneController.createFileUrl(ev);
        final mime = await dropZoneController.getFileMIME(ev);

        if (!mime.isContainIgnoreCase("jpeg") &&
            !mime.isContainIgnoreCase("jpg") &&
            !mime.isContainIgnoreCase("png") &&
            !mime.isContainIgnoreCase("image") &&
            !mime.isContainIgnoreCase("pdf")) {
          isFileNotAllowed.value = true;
        }

        var decodedImage = await decodeImageFromList(fileData);
        imageHeight.value = decodedImage.height;
        imageFile = XFile(url);
        highlight.value = false;
        previewImagePath.value = url;
        showPreviewDialog();
      } catch (e) {}
    }
  }

  chooseFileIP() async {
    var imageFile = await (ImagePicker().pickImage(source: ImageSource.gallery) as FutureOr<XFile>);
    var list = await imageFile.readAsBytes();
    var decodedImage = await decodeImageFromList(list);
    imageHeight.value = decodedImage.height;
    previewImagePath.value = imageFile.path;
    showPreviewDialog();
  }

  Map<String, dynamic> createBodyRequest(String? prospectId) {
    var request = Map<String, String?>();
    request["prospect_id"] = prospectId;
    return request;
  }

  uploadSelectedFile(String? prospectId, String flag) async {
    isUploading.value = true;
    var requestBody = createBodyRequest(prospectId);

    imageFile!.readAsBytes().then((value) {
      List<int> bytes = value.cast();
      switch (flag) {
        case ContentConstant.BUKTI_TERIMA:
          _transactionRepository
              .postApiUploadCustReceipt(Get.context, requestBody, bytes)
              .then((value) {
            setSuccessUploadDialog();
          }).catchError((error) {
            setFailedUpload("$error");
          });
          break;
        case ContentConstant.NOMOR_IMEI:
          _transactionRepository
              .postApiUploadImei(Get.context, requestBody, bytes)
              .then((value) {
            setSuccessUploadDialog();
          }).catchError((error) {
            setFailedUpload("$error");
          });
          break;
        case ContentConstant.BAST:
          _transactionRepository
              .postApiUploadBAST(Get.context, requestBody, bytes)
              .then((value) {
            setSuccessUploadDialog();
          }).catchError((error) {
            setFailedUpload("$error");
          });
          break;
        default:
      }
    });
  }

  setSuccessUploadDialog() {
    isUploading.value = false;
    showUploadedDialog();
    isSuccess = true;
  }

  setFailedUpload(String errorMessage) {
    uploadErrorMessage.value = errorMessage;
    showErrorUploadDialog();
    isSuccess = false;
    isUploading.value = false;
  }

  String getDialogHeaderText(String flag) {
    switch (flag) {
      case ContentConstant.BUKTI_TERIMA:
        return DialogConstant.uploadReceiptDialogSubtitle;
      case ContentConstant.NOMOR_IMEI:
        return DialogConstant.uploadImeiDialogSubtitle;
      case ContentConstant.BAST:
        return DialogConstant.uploadBastDialogSubtitle;
      default:
        return DialogConstant.uploadReceiptDialogSubtitle;
    }
  }

  void onFinishClearField() {
    previewImagePath.value = "";
    isSuccess = false;
    imageFile = null;
    highlight.value = false;
    isImageLoaded.value = false;
  }

  String onInfo(TransactionResponseData data) {
    String access = getInfoAccess(data);

    if (access == ContentConstant.trackingFlag) {
      trackingOrder(data.prospectId);
      return "tracking order";
    } else {
      paymentDetail(data.prospectId);
      return "payment detail";
    }
  }

  Future trackingOrder(String? prospectId) async {
    await _dashboardRepository
        .fetchApiDashboardOrderStatus(Get.context, prospectId)
        .then((value) {
      showDialogTrackOrder(
          arrivedTime: formatDateToString(value.data!.destinationTime),
          logisticName: value.data!.logisticName,
          noAWB: value.data!.awbNumber,
          deliveryTime: formatDateToString(value.data!.deliveryTime),
          status: value.data!.status,
          orderId: value.data!.prospectId,
          receiverName: value.data!.receiverName,
          shippingAddress: value.data!.shippingAddress,
        mobilePhone: value.data!.mobilePhone
      );
    });
  }

  Future paymentDetail(String? prospectId) async {
    await _transactionRepository.fetchApiPaymentDetail(Get.context, prospectId)
        .then((value) {
      DateFormat dayFormatter = DateFormat(DateConstant.dayFormat, DateConstant.localId);
      DateFormat dateFormatter = DateFormat(DateConstant.dateFormat2, DateConstant.localId);
      DateFormat hourFormatter = DateFormat(DateConstant.hourFormat);

      String dayText = dayFormatter.format(value.data!.payToDealerDate!.toLocal());
      String dateText = dateFormatter.format(value.data!.payToDealerDate!.toLocal());
      String hourText = hourFormatter.format(value.data!.payToDealerDate!.toLocal());

      String paymentDate = "$dayText, $dateText pukul $hourText";

      showDialogPaymentDetail(
          orderId: value.data!.prospectId,
          agreementNo: value.data!.agreementNo,
          payToDealerDate: paymentDate,
        payToDealerAmount: "${value.data!.payToDealerAmount.toString().toCurrency()},-",
        trackingStatus: value.data!.trackingStatus ?? "-"
      );
    });
  }

  String formatDateToString(DateTime? time) {
    if (time != null) {
      return time.toLocal().toFormattedDate(format: DateConstant.dateFormat3);
    } else {
      return '-';
    }
  }

  Future showDialogTrackOrder(
      {required String? orderId,
      required String? status,
      required String? noAWB,
      required String? logisticName,
      required String deliveryTime,
      required String arrivedTime,
      required String? receiverName,
      required String? shippingAddress,
      required String? mobilePhone}) {
    return dialogWrapper.dialog(DialogTrackingOrderWidget(
        arrivedTime: arrivedTime,
        logisticName: logisticName,
        deliveryTime: deliveryTime,
        status: status,
        orderId: orderId,
        noAWB: noAWB,
        receiverName: receiverName,
        shippingAddress: shippingAddress,
        mobilePhone: mobilePhone));
  }

  Future showDialogPaymentDetail(
      {required String? orderId,
    required String? agreementNo,
    required String payToDealerDate,
    required String payToDealerAmount,
    required String trackingStatus,}) {
    return dialogWrapper.dialog(DialogPaymentDetailWidget(
      orderId: orderId,
      agreementNo: agreementNo,
      payToDealerDate: payToDealerDate,
      payToDealerAmount: payToDealerAmount,
      trackingStatus: trackingStatus,
    ));
  }

  String formatStringStatus(String status) {
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
      case ContentConstant.STATUS_PAID:
        return role.isContainIgnoreCase(ContentConstant.ROLE_AGENT)
            ? EnumOrderTransaction.goLive.name
            : EnumOrderTransaction.disbursed.name ;
      default:
        return "";
    }
  }
}
