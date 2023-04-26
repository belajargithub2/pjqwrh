import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_get_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_container_controller.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class DraftController extends GetxController {
  DraftController({
    required BumblebeeDraftRepository draftRepository,
    required BumblebeeHomeContainerController homeContainerController
  }) : _draftRepository = draftRepository,
       _homeContainerController = homeContainerController;

  final BumblebeeDraftRepository _draftRepository;
  final BumblebeeHomeContainerController _homeContainerController;
  final listDraft = <DataDraft>[].obs;
  final isLoading = false.obs;
  final isEmptyList = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getDrafts();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getDrafts() async {
    isLoading(true);
    isEmptyList(false);
    try {
      ResponseGetDrafts responseGetDrafts = await _draftRepository.getDrafts(Get.context);
      listDraft.assignAll(responseGetDrafts.data!);
    } catch (e) {
      isEmptyList(true);
    }
    isLoading(false);
  }

  void onTapItemDraft(AgentSubmission draft, String? prospectId) {
    Get.toNamed(Routes.KMOB_SUBMISSION, arguments: {
      "source": draft,
      "prospectId": prospectId
    })!.then((isBackToHome) {
      if (isBackToHome) {
        _homeContainerController
            .selectedFab(BumblebeeHomeContainerController.DASHBOARD_SCREEN);
      } else {
        _homeContainerController
            .selectedFab(BumblebeeHomeContainerController.DRAFT_SCREEN);
      }
    });
  }
}
