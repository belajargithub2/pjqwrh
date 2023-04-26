import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_logout/deasy_logout.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/fcm_config.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/dialogs/dialog_content_one_button_widget.dart';

class DeleteAccountController extends GetxController
    with StateMixin<WordsResponseModel> {
  SettingsRepository _settingsRepository;
  UserRepository _userRepository;
  DynamicLinkConfig _dynamicLinkConfig;
  DeepLinkRepository _deepLinkRepository;
  AuthRepository _authRepository;

  RxBool isAgree = false.obs;
  RxBool isLoading = false.obs;
  String? userId;
  String? token;

  final String _routeDeeplink = 'login';

  DeleteAccountController(
      {required UserRepository userRepository,
      required SettingsRepository settingsRepository,
      required DynamicLinkConfig dynamicLinkConfig,
      required DeepLinkRepository deepLinkRepository,
      required AuthRepository authRepository})
      : _settingsRepository = settingsRepository,
        _userRepository = userRepository,
        _dynamicLinkConfig = dynamicLinkConfig,
        _deepLinkRepository = deepLinkRepository,
        _authRepository = authRepository;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await getTermNConditionText();

    await DeasyPocket().getUserId().then((value) {
      userId = value;
    });

    super.onReady();
  }

  void isCheckToggle(bool v) {
    isAgree.value = v;
  }

  Future<void> getTermNConditionText() async {
    change(null, status: RxStatus.loading());
    try {
      WordsResponseModel tncWords = await _settingsRepository.getWords(
          Get.context, ContentConstant.keyGetWordsDeleteAccount);
      change(tncWords, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<String> createDynamicLink(String? token) async {
    final url = await _dynamicLinkConfig.createDynamicLink(
        token,
        _deepLinkRepository,
        userId,
        ContentConstant.flagAccountDeleted,
        _routeDeeplink);
    return url;
  }

  Map<String, dynamic> createRequestPasswordMail(Uri url, String? referenceId) {
    var request = Map<String, String?>();
    request["reference_id"] = referenceId;
    request["url"] = "$url";
    return request;
  }

  Future<String?> getToken() async {
    GetTokenResponse tokenResponse =
        await _authRepository.getTokenEmail(Get.context, null);
    return tokenResponse.data!.token;
  }

  Future requestSendEmailConfirmation() async {
    Get.back();
    isLoading.toggle();
    token = await getToken();
    String _urlDynamicLink = await createDynamicLink(token);
    Uri _url = Uri.parse(_urlDynamicLink);
    await sendEmailDeleteAccount(_url, userId);
  }

  Future sendEmailDeleteAccount(Uri url, String? referenceId) async {
    Map<String, dynamic> requestBody =
        createRequestPasswordMail(url, referenceId);
    try {
      _userRepository
          .sendEmailDeleteAccount(Get.context, requestBody)
          .then((value) {
        _showDialogEmailAnnouncement();
        DeasyPocket().setDeleteAccountOnProcess(true);
      }).catchError((onError) {
        isLoading.toggle();
        _showDialogReminderToConfirmByEmail(onError.toString());
      });
    } catch (e) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, e.toString());
    }
  }

  void _showDialogEmailAnnouncement() {
    Get.defaultDialog(
      onWillPop: () async => false,
      title: ContentConstant.noString,
      backgroundColor: DeasyColor.neutral000,
      content: DialogContentOneButtonWidget(
        icon: IconConstant.RESOURCES_ICON_WARNING_PATH,
        contentTitle: DialogConstant.dialogEmailAnnouncementTitle,
        contentSubTitle: DialogConstant.dialogEmailAnnouncementSubTitle,
        buttonText: DialogConstant.dialogBtnOke,
        btnPress: () => DeasyLogout().logout(
            isExpired: true,
            unsubscribeFromTopic: () {
              DeasyPocket _deasyPocket = DeasyPocket();
              _deasyPocket
                  .getSupplierId()
                  .then((supplierId) => fcmUnSubscribe(supplierId));
            }),
      ),
    );
  }

  Future<void> deleteMyAccount() async {
    await DeasyPocket().getUserId().then((value) {
      userId = value;
    });
    _userRepository
        .deleteAccount(Get.context, null, userId)
        .then((value) => null)
        .catchError((onError) {
      if (onError.toString().isContainIgnoreCase('forbidden')) {
        DeasySnackBarUtil.showFlushBarError(
            Get.context!, "maaf akun ini tidak dapat dihapus");
      } else {
        DeasySnackBarUtil.showFlushBarError(Get.context!, "$onError");
      }
    });
  }

  void _showDialogReminderToConfirmByEmail(String contentSubtitle) {
    Get.defaultDialog(
      title: ContentConstant.noString,
      backgroundColor: DeasyColor.neutral000,
      content: DialogContentOneButtonWidget(
          icon: IconConstant.RESOURCES_ICON_WARNING_PATH,
          contentTitle: DialogConstant.dialogReminderToConfirmByEmailTitle,
          contentSubTitle:
              DialogConstant.dialogReminderToConfirmByEmailSubTitle,
          buttonText: DialogConstant.dialogBtnOke,
          btnPress: () {
            Get.back();
          }),
    );
  }
}
