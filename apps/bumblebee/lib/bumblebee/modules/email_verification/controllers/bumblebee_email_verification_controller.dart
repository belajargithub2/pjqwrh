import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/email_verification/views/widgets/bumblebee_email_verification_dialogs.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeEmailVerificationController extends GetxController {
  BumblebeeEmailVerificationController({
    required this.authRepository,
    required this.deepLinkRepository,
    required this.dynamicLinkConfig,
  });

  AuthRepository authRepository;
  DeepLinkRepository deepLinkRepository;
  DynamicLinkConfig dynamicLinkConfig;
  
  final isLoading = false.obs;
  final isFinished = false.obs;

  late String email;
  late String createPasswordUrl;
  late String token;

  Rxn<Duration> duration = Rxn<Duration>();
  int? resendEmailCount;
  String? resendEmailRetryAt;

  @override
  void onInit() async {
    email = Get.arguments['email'];
    
    await getResendEmailCount();
    await getResendEmailRetryAt();
    await setInitialDuration();

    super.onInit();
  }

  getResendEmailCount() async {
    resendEmailCount = await DeasyPocket().getResendEmailCount() ?? 0;
  }

  getResendEmailRetryAt() async {
    resendEmailRetryAt = await DeasyPocket().getResendEmailRetryAt();
  }

  setInitialDuration() async {
    if (resendEmailRetryAt != null) {
      var formattedRetryAtTime = convertToISODateFormat(resendEmailRetryAt!);
      duration.value = formattedRetryAtTime.difference(DateTime.now());
    } else {
      duration.value = Duration(minutes: 5);
    }
  }

  DateTime convertToISODateFormat(String dateTimeStr) {
    return DateTime.parse(dateTimeStr.toFormattedDate(
        format: DateConstant.dateFormatISO8601));
  }

  clearRetryCountAndTime() async {
    await DeasyPocket().removeResendEmailCount();
    await DeasyPocket().removeResendEmailRetryAt();
  }

  setNewDuration() async {
    var newDuration = 5;

    resendEmailCount = resendEmailCount! + 1;
    await DeasyPocket().setResendEmailCount(resendEmailCount!);

    if (resendEmailCount! > 3) {
      newDuration = 15;
    }

    await DeasyPocket().setResendEmailRetryAt(
      (DateTime.now().add(Duration(minutes: newDuration)).toString()));

    duration.value = Duration(minutes: newDuration);
    isFinished(false);
  }

  Future<void> resendEmail() async {
    isLoading(true);
    await setTokenAndUrl(email);
    await sendEmail(email, Uri.parse(createPasswordUrl), token);
  }

  setTokenAndUrl(String email) async {
    token = (await getToken())!;
    createPasswordUrl = await createDynamicLink(token, email);
  }

  Future<String> createDynamicLink(String token, String email) async {
    return await dynamicLinkConfig.createDynamicLink(
        token, deepLinkRepository, email, "create", "new-password");
  }

  Future<String?> getToken() async {
    GetTokenResponse _tokenResponse =
        await authRepository.getTokenEmail(Get.context, null);
    return _tokenResponse.data!.token;
  }

  sendEmail(String email, Uri url, String? token) async {
    await authRepository
      .postPasswordEmail(
          Get.context,
          createRequestPasswordMail(email, url, token),
          "Add_Merchant_Verify_Email")
      .then((value) async {
        await setNewDuration();
        isLoading(false);
        successResendVerificationEmailDialog(email, () {
          Get.back();
        });
      }).catchError((_) {
        isLoading(false);
      });
  }

  Map<String, dynamic> createRequestPasswordMail(
      String email, Uri url, String? token) {
    var request = Map<String, String>();
    request["email"] = email;
    request["type"] = "create_password";
    request["url"] = "$url";
    request["token"] = "$token";
    return request;
  }
}