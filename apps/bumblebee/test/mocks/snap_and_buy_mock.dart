import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_permission_location_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_snb_base_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_asset_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_media_image_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

class SnapNBuyRepositoryMock extends Mock implements BumblebeeSnapNBuyRepository {}

class AssetRepositoryMock extends Mock implements BumblebeeAssetRepository {}

class MediaImageRepositoryMock extends Mock implements BumblebeeMediaImageRepository {}

class SnapAndBuyControllerMock extends GetxController
    with Mock
    implements BumblebeeSnapAndBuyBaseController {}

class PermissionLocationControllerMock extends GetxController
    with Mock
    implements BumblebeePermissionLocationController {}

class SubmissionSectionControllerMock extends GetxController
    with Mock
    implements BumblebeeSubmissionSectionController {}

class PromoMarketingControllerMock extends GetxController
    with Mock
    implements BumblebeePromoMarketingController {}
