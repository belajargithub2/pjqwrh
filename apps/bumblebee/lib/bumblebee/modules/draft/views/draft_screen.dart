import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/controller/draft_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/views/widgets/draft_loading_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/views/widgets/empty_draft_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/views/widgets/item_draft_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_container_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_text/deasy_text.dart';

class DraftScreen extends GetView<DraftController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DraftController>(
      init: DraftController(
        draftRepository: Get.find<BumblebeeDraftRepository>(),
        homeContainerController: Get.find<BumblebeeHomeContainerController>()
      ),
      builder: (c) => _body(c),
    );
  }

  _body(DraftController c) {
    return Scaffold(
      backgroundColor: DeasyColor.neutral50,
      appBar: _appBar() as PreferredSizeWidget?,
      body: Obx(() => c.isLoading.value
          ? DraftLoadingWidget()
          : c.isEmptyList.value
              ? EmptyDraftWidget()
              : _bodyDraft(c)),
    );
  }

  Widget _bodyDraft(DraftController c) {
    return ListView.builder(
      itemCount: c.listDraft.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ItemDraftWidget(
          dataDraft: c.listDraft[index],
          onTap: () {
            c.onTapItemDraft(
                AgentSubmission.DRAFT, c.listDraft[index].prospectId);
          },
        );
      },
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      title: DeasyTextView(
        text: "Draft",
        fontSize: 20,
        fontColor: DeasyColor.neutral900,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
