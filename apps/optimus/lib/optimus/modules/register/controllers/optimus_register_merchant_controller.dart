import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/models/optimus_register_merchant_exist_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/repositories/optimus_register_repository.dart';

import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_dialog.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusRegisterMerchantController extends GetxController {
  final locationRepository = Get.find<LocationRepository>();
  final userRepository = Get.find<UserRepository>();
  final authRepository = Get.find<AuthRepository>();
  final deepLinkRepository = Get.find<DeepLinkRepository>();
  final merchantRepository = Get.find<OptimusRegisterRepository>();
  final registerDialog = Get.find<OptimusRegisterDialog>();

  FocusNode focusSupplierId = FocusNode();

  final supplierIdController = TextEditingController();
  final supplierTypeController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final districtController = TextEditingController();
  final villageController = TextEditingController();
  final zipCodeController = TextEditingController();
  final rtController = TextEditingController();
  final rwController = TextEditingController();

  final RxList<ProvinceDatum> listProvince = <ProvinceDatum>[].obs;
  final RxList<CityDatum> listCity = <CityDatum>[].obs;
  final RxList<DistrictDatum> listDistrict = <DistrictDatum>[].obs;
  final RxList<VillageDatum> listVillage = <VillageDatum>[].obs;
  final RxList<MerchantTypeData> listMerchantType = <MerchantTypeData>[].obs;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  final dynamicLinkConfig = Get.find<DynamicLinkConfig>();
  final loadingController = Get.find<LoadingController>();

  @override
  void onInit() {
    focusSupplierId.addListener(onFocusChange);
    getProvince();
    getMerchantTypes();
    super.onInit();
  }

  void onFocusChange() {
    if (focusSupplierId.hasFocus.toString().isContainIgnoreCase("false")) {
      if (supplierIdController.text.isNotEmpty) {
        getMerchantById();
      }
    }
  }

  @override
  void onClose() {
    supplierIdController.dispose();
    super.onClose();
  }

  String? supplierIdValidator(String text) {
    if (text.isBlank!) {
      return ContentConstant.supplierIdCantBeNull;
    }
    return null;
  }

  String? phoneValidator(String value) {
    if (value.isNotEmpty && !value.isIdPhoneNumber()) {
      return ValidationConstant.phoneValidation;
    } else {
      return null;
    }
  }

  String? rtValidator(String value) {
    if (value.isEmpty) {
      return ValidationConstant.rtCantBeEmpty;
    } else if (value.length < 2) {
      return ValidationConstant.rtCantless2;
    } else if (value.length > 3) {
      return ValidationConstant.rtCantExceed3;
    }
    return null;
  }

  String? rwValidator(String value) {
    if (value.isEmpty) {
      return ValidationConstant.rwCantBeEmpty;
    } else if (value.length < 2) {
      return ValidationConstant.rwCantless2;
    } else if (value.length > 3) {
      return ValidationConstant.rwCantExceed3;
    }
    return null;
  }

  Future<OptimusRegisterMerchantExistResponse> getMerchantById() async {
    OptimusRegisterMerchantExistResponse isExistMerchant =
        new OptimusRegisterMerchantExistResponse();
    await merchantRepository
        .isMerchantExistById(
            Get.context, supplierIdController.text.toString().trim())
        .then((value) {
      isExistMerchant = value;
    });
    return isExistMerchant;
  }

  Future<ResponseProvince> getProvince() async {
    ResponseProvince responseProvince = ResponseProvince();
    cityController.text = "";
    districtController.text = "";
    villageController.text = "";
    await locationRepository.getProvince(Get.context).then((value) {
      listProvince.value = value.data!;
      responseProvince = value;
    });
    return responseProvince;
  }

  getCity(int? provinceId) async {
    cityController.text = "";
    districtController.text = "";
    villageController.text = "";
    await locationRepository
        .getCity(Get.context, provinceCode: provinceId)
        .then((value) {
      listCity.value = value.data!;
    });
  }

  Future<ResponseDistrict> getDistrict(int? cityCode) async {
    ResponseDistrict responseDistrict = ResponseDistrict();
    districtController.text = "";
    villageController.text = "";
    await locationRepository
        .getDistrict(Get.context, cityCode: cityCode)
        .then((value) {
      listDistrict.value = value.data!;
      responseDistrict = value;
    });
    return responseDistrict;
  }

  getVillage(int? districtCode) async {
    villageController.text = "";
    await locationRepository
        .getVillages(Get.context, districtCode: districtCode)
        .then((value) {
      listVillage.value = value.data!;
    });
  }

  Future<List<ProvinceDatum>> filterListProvince(String filter) async {
    List<ProvinceDatum> list = [];
    for (var item in listProvince) {
      if (item.name!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  Future<List<CityDatum>> filterListCity(String filter) async {
    List<CityDatum> list = [];
    for (var item in listCity) {
      if (item.name!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  Future<List<DistrictDatum>> filterListDistrict(String filter) async {
    List<DistrictDatum> list = [];
    for (var item in listDistrict) {
      if (item.name!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  Future<List<VillageDatum>> filterListVillage(String filter) async {
    List<VillageDatum> list = [];
    for (var item in listVillage) {
      if (item.name!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  late MerchantTypeData selectedMerchantType;

  selectMerchantType(String type) {
    supplierTypeController.text = type;
    selectedMerchantType = listMerchantType
        .singleWhere((element) => element.text == supplierTypeController.text);
  }

  UserRegisterRequest registerRequestBody(url, String? token) {
    return UserRegisterRequest(
        city: cityController.text,
        createPasswordUrl: "$url",
        district: districtController.text,
        email: emailController.text,
        name: usernameController.text,
        phoneNumber: phoneNumberController.text,
        province: provinceController.text,
        rt: rtController.text,
        rw: rwController.text,
        token: token,
        supplierId: supplierIdController.text,
        village: villageController.text,
        zipCode: zipCodeController.text,
        merchantType: selectedMerchantType.id,
        isAgent: false);
  }

  Future<void> submit() async {
    loadingController.isLoading = true;
    var tokenResponse = await authRepository.getTokenEmail(Get.context, null);
    var url = await createDynamicLink(tokenResponse.data!.token);
    await register(url, tokenResponse.data!.token);
  }

  void getMerchantTypes() {
    authRepository.getMerchantTypes(Get.context, null).then((merchantTypes) {
      listMerchantType.addAll(merchantTypes.data!);
    });
  }

  Future<String> createDynamicLink(String? token) async {
    var url = await dynamicLinkConfig.createDynamicLink(token,
        deepLinkRepository, emailController.text, "create", 'new-password');
    return url;
  }

  setInitialRetryAtAndCount() async {
    await DeasyPocket().setInitialRetryAtAndCount();
  }

  Future<void> register(url, String? token) async {
    userRepository
        .userRegister(Get.context, registerRequestBody(url, token).toJson(),
            "Register_Merchant")
        .then((value) async {
      if (value.code == 200) {
        AnalyticConfig().sendEventSuccess("Register_Merchant");
        //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
        if (flavorConfiguration!.flavorName == "dev" ||
            flavorConfiguration!.flavorName == "testing") {
          Get.offAllNamed(
            OptimusRoutes.EMAIL_VERIFICATION_PAGE,
            parameters: {
              "email": emailController.text,
            }
          );
        } else {
          registerDialog.webDialog(emailController.text);
        }
        loadingController.isLoading = false;
        await setInitialRetryAtAndCount();
      }
    }).catchError((onError) {
      AnalyticConfig().sendEventFailed("Register_Merchant");
      if (onError == null) {
        DeasySnackBarUtil.showFlushBarError(
            Get.context!, 'Silahkan periksa data kembali');
      }
      loadingController.isLoading = false;
    });
  }
}

enum UserType { merchant, agent }
