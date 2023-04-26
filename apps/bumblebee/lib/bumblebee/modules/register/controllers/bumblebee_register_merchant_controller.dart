import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/widgets/register_dialog.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/loading/loading_controller.dart';

class BumblebeeRegisterMerchantController extends GetxController {
  final locationRepository = Get.find<LocationRepository>();
  final userRepository = Get.find<UserRepository>();
  final authRepository = Get.find<AuthRepository>();
  final deepLinkRepository = Get.find<DeepLinkRepository>();
  final merchantRepository = Get.find<MerchantRepository>();
  final registerDialog = Get.find<RegisterDialog>();
  FocusNode focusSupplierId = FocusNode();

  final supplierIdController = TextEditingController();
  final supplierTypeController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
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
  final RxList<MerchantTypeData> listMerchantType =
      <MerchantTypeData>[].obs;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  final RxString onSelectedButton = ''.obs;

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
      return ContentConstant.phoneValidation;
    } else {
      return null;
    }
  }

  String? rtValidator(String value) {
    if (value.isEmpty) {
      return ContentConstant.rtCantBeEmpty;
    } else if (value.length < 2) {
      return ContentConstant.rtCantless2;
    } else if (value.length > 3) {
      return ContentConstant.rtCantExceed3;
    }
    return null;
  }

  String? rwValidator(String value) {
    if (value.isEmpty) {
      return ContentConstant.rwCantBeEmpty;
    } else if (value.length < 2) {
      return ContentConstant.rwCantless2;
    } else if (value.length > 3) {
      return ContentConstant.rwCantExceed3;
    }
    return null;
  }

  Future<RegisterMerchantExistResponse> getMerchantById() async {
    RegisterMerchantExistResponse isExistMerchant =
        new RegisterMerchantExistResponse();
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

  Future<void> register(url, String? token) async {
    userRepository
        .userRegister(Get.context, registerRequestBody(url, token).toJson(),
            "Register_Merchant")
        .then((value) {
      if (value.code == 200) {
        AnalyticConfig().sendEventSuccess("Register_Merchant");
        //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
        if (flavorConfiguration!.flavorName == "dev" ||
            flavorConfiguration!.flavorName == "testing") {
          Get.offAllNamed(
            BumblebeeRoutes.EMAIL_VERIFICATION_PAGE,
            arguments: {
              "email": emailController.text,
            }
          );
        } else {
          registerDialog.mobileDefaultDialog(email: emailController.text);
        }
        loadingController.isLoading = false;
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

  void onPressedButtonRegisterType(String userType) {
    onSelectedButton.value = userType;
  }

  String? onRouteToRegisterAsTypeUser(String typeUser) {
    switch (typeUser) {
      case 'merchant':
        Get.toNamed(BumblebeeRoutes.REGISTER_MERCHANT_PAGE);
        return typeUser;
      case 'agent':
        Get.toNamed(BumblebeeRoutes.REGISTER_AGENT_PAGE);
        return typeUser;
      default:
        return null;
    }
  }
}

enum UserType { merchant, agent }
