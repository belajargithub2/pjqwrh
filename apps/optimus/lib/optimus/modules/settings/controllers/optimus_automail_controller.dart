import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/dashboard_search_merchant_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_add_recipients_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_enable_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_update_recipient_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_add_recipients_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_enable_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipient_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipient_type_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipients_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_update_recipients_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_automail_repository.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/automail/widgets/optimus_add_recipient_dialog_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/views/automail/widgets/optimus_search_merchant_dropdown_widget.dart';
import 'package:deasy_dialog/deasy_dialog.dart';

class OptimusAutomailController extends GetxController {
  final OptimusAutomailRepository repository;
  var formKey = GlobalKey<FormState>();
  String _merchant = 'MERCHANT';
  String _dealer = 'DEALER';

  RxBool isEnable = true.obs;
  RxBool isEditable = false.obs;
  final isLoading = false.obs;
  final isLoadingInDialog = false.obs;
  final dialogWrapper = Get.find<DeasyDialogWrapper>();
  final merchantTextController = TextEditingController();
  final recipientTypeTextCont = TextEditingController();
  final dealerName = TextEditingController();
  final email1TextController = TextEditingController();
  final email2TextController = TextEditingController();
  final email3TextController = TextEditingController();
  RxBool showDealerField = false.obs;
  late int _selectedID;
  late String _recipientTypeSelected;

  final PagingController<int, DashboardSearchMerchantData>
      searchMerchantPagingController = PagingController(firstPageKey: 0);

  final RxList<RecipentType> listRecipientTypes = <RecipentType>[].obs;

  final Rxn<AutomailRecipientsResponse> recipients =
      Rxn<AutomailRecipientsResponse>();

  final List<RecipientData> _allRecipients = <RecipientData>[];

  TextEditingController searchController = TextEditingController();
  TextEditingController textEditingSearchMerchantController =
      TextEditingController();
  final Rxn<AutomailRecipientDetailResponse> detailRecipient =
      Rxn<AutomailRecipientDetailResponse>();
  final Rxn<AutomailEnableResponse> switchEnabler =
      Rxn<AutomailEnableResponse>();
  final Rxn<AutomailUpdateRecipientsResponse> updateRecipientResponse =
      Rxn<AutomailUpdateRecipientsResponse>();
  final Rxn<AutomailAddRecipientsResponse> addRecipientResponse =
      Rxn<AutomailAddRecipientsResponse>();
  final DashboardRepository _dashboardRepository;
  static const _pageSize = 5;
  RxString selectedMerchantName = ''.obs;
  String? supplierId;
  int initPage = 1;
  int initLimit = 10;

  OptimusAutomailController(
      {required OptimusAutomailRepository optimusAutomailRepository,
      required DashboardRepository dashboardRepository})
      : repository = optimusAutomailRepository,
        _dashboardRepository = dashboardRepository;

  @override
  void onInit() {
    fetchAllRecipients(page: initPage, limit: initLimit, searchKey: '');
    super.onInit();
  }

  @override
  void onClose() {
    searchMerchantPagingController.dispose();
    super.onClose();
  }

  Future<bool> fetchApiDashboardsMerchantsByName(
      int pageKey, String searchKey) async {
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

  String? isEmailValid(String? email) {
    if (email!.isNotEmpty) {
      return email.emailValidator(
          msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
          msgEmailNotValid: ValidationConstant.emailNotValid.capitalizeFirst!);
    }
    if (email.isEmpty) {
      return ContentConstant.automailFirstEmailCantBeEmpty;
    }

    return null;
  }

  void submit(bool isNewData) {
    final isValid = formKey.currentState?.validate();
    if (isValid!) {
      showSaveConfirmationDialog(isNewData);
      return;
    }
  }

  void showSaveConfirmationDialog(bool isNewData) {
    return DeasyBaseDialogs.getInstance().optimusIconDialog(
      context: Get.context!,
      title: ContentConstant.automailSaveTitle,
      subTitle: ContentConstant.automailSaveSubTitle,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      subTitleTextAlign: TextAlign.center,
      buttonOkText: ButtonConstant.save,
      onPressButtonOk: () {
        isNewData ? addRecipient() : updateRecipient();
      },
      onPressButtonCancel: () {
        onCancelInput();
      },
      buttonCancelText: ButtonConstant.cancel,
      icon: SvgPicture.asset(
        AssetConstant.warning,
        height: 64.0,
        width: 64.0,
      ),
    );
  }

  String? sameDealerValidation(
      String value, String messageError, String messageEmptyError) {
    bool? exists = _allRecipients.any((dealer) => dealer.name == value);
    if (value.isEmpty) {
      return messageEmptyError;
    }
    if (exists && value.isNotEmpty) {
      return messageError;
    }
    return null;
  }

  void dialogConfirmSwitchRecipientEnabler(bool value,
      {required int id, required bool isEnable}) {
    return DeasyBaseDialogs.getInstance().optimusIconDialog(
      context: Get.context!,
      title: isEnable == true
          ? ContentConstant.automailDisableTitle
          : ContentConstant.automailEnableTitle,
      subTitle: isEnable == true
          ? ContentConstant.automailDisableSubTitle
          : ContentConstant.automailEnableSubTitle,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      subTitleTextAlign: TextAlign.center,
      buttonOkText: isEnable == true ? ButtonConstant.off : ButtonConstant.on,
      onPressButtonOk: () {
        Get.back();
        switchEnablerAutomailRecipient(id: id, isEnable: !isEnable);
      },
      onPressButtonCancel: () {
        Get.back();
        onCancelInput();
      },
      buttonCancelText: ButtonConstant.cancel,
      icon: SvgPicture.asset(
        AssetConstant.warning,
        height: 64.0,
        width: 64.0,
      ),
    );
  }

  Future fetchAllRecipientType() async {
    isLoading.value = true;
    repository.getRecipientTypes().then((value) {
      listRecipientTypes.clear();
      listRecipientTypes.addAll(value.data);
      _allRecipients.forEach((element) {
        listRecipientTypes
            .removeWhere((e) => e.id.contains(element.recipientType!));
      }); // delete used recipient type
    }).catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() => isLoading.value = false);
  }

  Future fetchAllRecipients({
    required int page,
    int limit = 10,
    String? searchKey,
  }) async {
    isLoading.value = true;
    repository
        .getAllRecipients(searchKey: searchKey ?? '', page: page, limit: limit)
        .then((value) {
      recipients.value = value;
      if (_allRecipients.isNotEmpty) {
        final _recipientExist = _allRecipients
            .every((element) => recipients.value!.data!.contains(element.id));
        if (!_recipientExist) {
          _allRecipients.addAll(recipients.value!.data!);
        }
      } else {
        _allRecipients.addAll(recipients.value!.data!);
      }
    }).catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() => isLoading.value = false);
  }

  Future onSubmitSearch(String searchKey) async {
    await fetchAllRecipients(searchKey: searchKey.toLowerCase(), page: 1);
  }

  Future fetchDetailRecipients({
    required int id,
    String? supplierName,
  }) async {
    isLoadingInDialog.value = true;
    dealerName.text = supplierName ?? '-';
    _selectedID = id;
    repository.getDetailRecipients(id: id).then((value) {
      RecipentType _type = RecipentType(id: value.data.recipientType, text: '');
      onChangeType(_type);
      detailRecipient.value = value;
      recipientChanger(
          text: detailRecipient.value!.data.recipientType == _merchant
              ? _dealer
              : detailRecipient.value!.data.recipientType,
          id: detailRecipient.value!.data.recipientType == _merchant
              ? _dealer
              : detailRecipient.value!.data.recipientType);
      email1TextController.text =
          detailRecipient.value!.data.recipients[0].email;
      if (detailRecipient.value!.data.recipients.length == 2) {
        email2TextController.text =
            detailRecipient.value!.data.recipients[1].email ?? '';
      }
      if (detailRecipient.value!.data.recipients.length == 3) {
        email2TextController.text =
            detailRecipient.value!.data.recipients[1].email ?? '';
        email3TextController.text =
            detailRecipient.value!.data.recipients[2].email ?? '';
      }
      supplierId = detailRecipient.value!.data.supplierId.toString();
    }).catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() {
      isLoadingInDialog.value = false;
    });
  }

  Future<void> switchEnablerAutomailRecipient(
      {required int id, required bool isEnable}) async {
    AutomailEnableRequest _requestBody =
        AutomailEnableRequest(id: id, isEnable: isEnable);

    repository.automailEnabler(request: _requestBody).then((value) {
      switchEnabler.value = value;
      fetchAllRecipients(page: initPage, limit: initLimit, searchKey: '');
      return showSuccessDialog(
          title: isEnable == true
              ? ContentConstant.automailEnable
              : ContentConstant.automailDisable);
    });
  }

  Future editRecipient(
      {required AutomailUpdateRecipientsRequest request}) async {
    isLoadingInDialog.toggle(); // khusus load di dialog
    repository
        .updateRecipient(request: request)
        .then((value) => updateRecipientResponse.value = value)
        .catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() => isLoadingInDialog.toggle());
  }

  Future addRecipient() async {
    isLoadingInDialog.value = true;
    List<RecipientRequest> _emails = [];
    RecipientRequest _recipient1;
    RecipientRequest _recipient2;
    RecipientRequest _recipient3;

    //mandatory must have first email
    _recipient1 = RecipientRequest(email: email1TextController.text);
    _emails.add(_recipient1);

    if (email2TextController.text.isNotEmpty) {
      _recipient2 = RecipientRequest(email: email2TextController.text);
      _emails.add(_recipient2);
    }
    if (email3TextController.text.isNotEmpty) {
      _recipient3 = RecipientRequest(email: email3TextController.text);
      _emails.add(_recipient3);
    }

    AutomailAddRecipientsRequest request = AutomailAddRecipientsRequest(
        supplierId: supplierId ?? '1',
        recipientType: _recipientTypeSelected == _dealer
            ? _merchant
            : _recipientTypeSelected,
        receipts: _emails);

    repository.addRecipient(request: request).then((value) {
      addRecipientResponse.value = value;
      Get.back();
      Get.back();
      showSuccessDialog(
        title: ContentConstant.automailRecipientSaved,
      );
      clearAllForm();
    }).catchError((onError) {
      Get.back();
      Get.back();
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() {
      isLoadingInDialog.value = false;
      clearAllForm();
      fetchAllRecipients(page: initPage, limit: initLimit);
    });
  }

  Future updateRecipient() async {
    isLoadingInDialog.value = true;
    List<RecipientRequest> _emails = [];
    RecipientRequest _recipient1;
    RecipientRequest _recipient2;
    RecipientRequest _recipient3;
    _emails.clear();
    //mandatory must have first email
    _recipient1 = RecipientRequest(email: email1TextController.text);
    _emails.add(_recipient1);
    _recipient2 = RecipientRequest(email: email2TextController.text);
    if (_recipient2.email.isNotEmpty) {
      _emails.add(_recipient2);
    }
    _recipient3 = RecipientRequest(email: email3TextController.text);
    if (_recipient3.email.isNotEmpty) {
      _emails.add(_recipient3);
    }

    AutomailUpdateRecipientsRequest request = AutomailUpdateRecipientsRequest(
        id: _selectedID,
        supplierId: supplierId ?? '1',
        recipientType: _recipientTypeSelected == _dealer
            ? _merchant
            : _recipientTypeSelected,
        receipts: _emails);
    repository.updateRecipient(request: request).then((value) {
      Get.back();
      Get.back();
      showSuccessDialog(
        title: ContentConstant.automailRecipientSaved,
      );
      clearAllForm();
    }).catchError((onError) {
      Get.back();
      Get.back();
      clearAllForm();
      DeasySnackBarUtil.showFlushBarError(Get.context!, onError.toString());
    }).whenComplete(() {
      isLoadingInDialog.value = false;
      clearAllForm();
      fetchAllRecipients(page: initPage, limit: initLimit);
    });
  }

  onCancelInput() {
    Get.back();
    clearAllForm();
    showDealerField.value = false;
  }

  clearAllForm() {
    email1TextController.clear();
    email2TextController.clear();
    email3TextController.clear();
    textEditingSearchMerchantController.clear();
    recipientTypeTextCont.clear();
    _recipientTypeSelected = '';
    dealerName.clear();
    showDealerField.value = false;
  }

  void switchEnableAutoReceiveMail() {
    isEnable.toggle();
  }

  Future showDialogAddRecipient() async {
    await fetchAllRecipientType();
    return dialogWrapper.dialog(OptimusAddRecipientDialogWidget(
      canEdit: true,
      hasData: false,
      isNewData: true,
    ));
  }

  Future showDialogDetailRecipient(
      {required bool isDealer, required bool canEdit}) async {
    return dialogWrapper.dialog(OptimusAddRecipientDialogWidget(
      hasData: true,
      isDealer: isDealer,
      canEdit: canEdit,
      isNewData: false,
    ));
  }

  showDetailRecipient({
    required int id,
    String? supplierName,
  }) {
    fetchDetailRecipients(id: id, supplierName: supplierName)
        .then((value) => showDialogDetailRecipient(
            isDealer:
                _recipientTypeSelected == _dealer,
            canEdit: false));
  }

  showDialogEditRecipient({
    required int id,
    String? supplierName,
  }) {
    fetchDetailRecipients(id: id, supplierName: supplierName)
        .then((value) => showDialogDetailRecipient(
            isDealer:
                _recipientTypeSelected == _dealer,
            canEdit: true));
  }

  Future showDialogMerchants() {
    onTapMerchantFormField();
    return dialogWrapper.dialog(OptimusSearchMerchantDropdownWidget());
  }

  bool checkingTextFieldIsEnable() {
    return true;
  }

  onChangeType(RecipentType result) {
    recipientChanger(text: result.text, id: result.id);
    if (result.id == _dealer || result.id == _merchant) {
      showDealerField.value = true;
    } else {
      showDealerField.value = false;
    }
  }

  recipientChanger({required String text, required String id}) {
    recipientTypeTextCont.text = text;
    _recipientTypeSelected = id;
  }

  onSearchTextChanged() {
    searchMerchantPagingController.refresh();
  }

  onTapSelectMerchant(String? merchantId, String merchantName) {
    supplierId = merchantId;
    dealerName.text = merchantName;
    Get.back();
    textEditingSearchMerchantController.clear();
  }

  onTapMerchantFormField() {
    searchMerchantPagingController.addPageRequestListener((pageKey) {
      fetchApiDashboardsMerchantsByName(
          pageKey, textEditingSearchMerchantController.text);
    });
  }

  void showSuccessDialog({required String title}) {
    return DeasyBaseDialogs.getInstance().optimusIconSingleDialogDialog(
      context: Get.context!,
      title: title,
      subTitle: '',
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      subTitleTextAlign: TextAlign.center,
      buttonOkText: ButtonConstant.ok,
      onPressButtonOk: () {
        closeSuccessDialog();
      },
      onPressButtonCancel: () {
        onCancelInput();
      },
      buttonCancelText: ButtonConstant.cancel,
      icon: SvgPicture.asset(
        AssetConstant.success_generate,
        height: 64.0,
        width: 64.0,
      ),
    );
  }

  closeSuccessDialog() {
    Get.back();
  }
}
