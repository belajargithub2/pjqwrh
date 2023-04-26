import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_permission_location_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_snb_base_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_asset_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_media_image_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/repositories/optimus_snap_n_buy_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:get/get.dart';

class SnapNBuyRepositoryMock extends Mock implements OptimusSnapNBuyRepository {}

class AssetRepositoryMock extends Mock implements OptimusAssetRepository {}

class MediaImageRepositoryMock extends Mock implements OptimusMediaImageRepository {}

class SnapAndBuyControllerMock extends GetxController
    with Mock
    implements OptimusSnapAndBuyBaseController {}

class PermissionLocationControllerMock extends GetxController
    with Mock
    implements OptimusPermissionLocationController {}

class SubmissionSectionControllerMock extends GetxController
    with Mock
    implements OptimusSubmissionSectionController {}

class DrawerCustomControllerMock extends GetxController
    with Mock
    implements OptimusDrawerCustomController {}

class PromoMarketingControllerMock extends GetxController
    with Mock
    implements OptimusPromoMarketingController {}
