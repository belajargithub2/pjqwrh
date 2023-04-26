import 'dart:io';

import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/widgets/kmob_submission_dashed_rect_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class KMOBSubmissionUploadImageWidget extends GetView {
  final UploadImageModel item;
  final Function? takeFromCamera;
  final Function? takeFromGallery;
  final bool checkValidation;

  KMOBSubmissionUploadImageWidget(
      {required this.item,
      this.takeFromCamera,
      this.checkValidation = false,
      this.takeFromGallery});

  static const addImage = "Tambahkan Foto";
  static const editImage = "Ubah Foto";
  static const imageCantNull = "tidak boleh kosong";
  static const takeImageFromCamera = "Ambil Foto";
  static const fromGallery = "Dari Galeri";
  static const fromCamera = "Ambil Foto";
  static const cancel = "Batal";

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return InkWell(
      onTap: () {
        showDialogChooseImage();
      },
      child: item.draftImage != null && item.imagePath.isEmpty
          ? _imageDraftAvailableWidget()
          : item.imagePath.isNotEmpty
              ? _imageAvailableWidget()
              : _imageNullWidget(),
    );
  }

  Widget _imageDraftAvailableWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: _loadImageFromDraft(),
                            ),
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 93,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(
                                      color: DeasyColor.neutral000, width: 1.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      IconConstant.RESOURCES_ICON_EDIT_IMAGE,
                                    ),
                                    DeasyTextView(
                                      text: "Ubah",
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              1.7,
                                      fontColor: DeasyColor.neutral000,
                                      fontFamily: FontFamily.medium,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                          ],
                        )),
                    Expanded(
                      child: Center(
                        child: DeasyTextView(
                          text: item.name,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                          fontColor: DeasyColor.neutral900.withOpacity(0.7),
                          fontFamily: FontFamily.medium,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Visibility(
            visible: checkValidation,
            child: Expanded(flex: 1, child: SizedBox()),
          )
        ],
      ),
    );
  }

  Widget _imageAvailableWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: item.isFromCamera
                                  ? _loadImageFromCamera()
                                  : _loadImageFromGallery(),
                            ),
                            Positioned.fill(
                                child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 93,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  border: Border.all(
                                      color: DeasyColor.neutral000, width: 1.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      IconConstant.RESOURCES_ICON_EDIT_IMAGE,
                                    ),
                                    DeasyTextView(
                                      text: "Ubah",
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              1.7,
                                      fontColor: DeasyColor.neutral000,
                                      fontFamily: FontFamily.medium,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                          ],
                        )),
                    Expanded(
                      child: Center(
                        child: DeasyTextView(
                          text: item.name,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                          fontColor: DeasyColor.neutral900.withOpacity(0.7),
                          fontFamily: FontFamily.medium,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Visibility(
            visible: checkValidation,
            child: Expanded(flex: 1, child: SizedBox()),
          )
        ],
      ),
    );
  }

  Widget _loadImageFromCamera() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
      child: Transform.scale(
        scale: 1.1,
        child: Image.file(
          File(item.imagePath),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget _loadImageFromGallery() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
      child: Image.file(
        File(item.imagePath),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _imageNullWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
                width: double.maxFinite,
                decoration: DottedDecoration(
                  shape: Shape.box,
                  color: checkValidation
                      ? DeasyColor.dmsF46363
                      : DeasyColor.neutral300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconConstant.RESOURCES_ICON_UPLOAD_IMAGE,
                      width: DeasySizeConfigUtils.screenWidth! / 6,
                      height: DeasySizeConfigUtils.screenHeight! / 10,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DeasyTextView(
                      text: item.name,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                      fontColor: DeasyColor.neutral900.withOpacity(0.7),
                      fontFamily: FontFamily.medium,
                    )
                  ],
                )),
          ),
          Visibility(
            visible: checkValidation,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DeasyTextView(
                text: "${item.name} $imageCantNull",
                fontSize: DeasySizeConfigUtils.blockVertical * 1.4,
                fontColor: DeasyColor.dmsF46363,
                textAlign: TextAlign.start,
                maxLines: 2,
                fontFamily: FontFamily.medium,
              ),
            ),
          )
        ],
      ),
    );
  }

  showDialogChooseImage() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: DeasyColor.neutral000,
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: DeasyTextView(
                  text: item.imagePath.isEmpty ? addImage : editImage,
                  fontSize: 18,
                  fontFamily: FontFamily.medium,
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Divider(),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  takeFromCamera!();
                },
                child: Container(
                  width: double.maxFinite,
                  height: 30,
                  padding: EdgeInsets.only(top: 6),
                  alignment: Alignment.centerLeft,
                  child: DeasyTextView(
                    text: '   $takeImageFromCamera',
                    fontFamily: FontFamily.light,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  takeFromGallery!();
                },
                child: Container(
                  width: double.maxFinite,
                  height: 30,
                  padding: EdgeInsets.only(top: 6),
                  alignment: Alignment.centerLeft,
                  child: DeasyTextView(
                    text: '   $fromGallery',
                    fontFamily: FontFamily.light,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.maxFinite,
                  height: 30,
                  padding: EdgeInsets.only(top: 8),
                  alignment: Alignment.centerLeft,
                  child: DeasyTextView(
                    text: "   $cancel",
                    fontFamily: FontFamily.medium,
                    fontSize: 16,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _loadImageFromDraft() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0), topLeft: Radius.circular(10.0)),
      child: Image.memory(
        item.draftImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
