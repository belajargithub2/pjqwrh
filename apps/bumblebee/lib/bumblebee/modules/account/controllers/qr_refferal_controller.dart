import 'dart:typed_data';

import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/views/qr_refferal/qr_bottom_sheet.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class QrRefferalController extends GetxController {
  final timeHasEnded = false.obs;
  final isLoading = false.obs;
  final showQr = true.obs;
  final qrCodeTimer = 0.obs;

  final identifierTransaksiRepo = Get.find<IdentifierTransaksiRepository>();
  final sharedPref = DeasyPocket();

  Rxn<Uint8List> listImage = Rxn<Uint8List>();
  DateTime? expiredDate;
  String? qrCodePath;

  void onShowBottomSheet() {
    if (listImage.value == null) {
      createMerchantQrCode();
    } else {
      final isExpired = expiredDate!.isBefore(DateTime.now());
      if (isExpired) {
        timeHasEnded(true);
        createMerchantQrCode();
      } else {
        qrCodeTimer(
          expiredDate!.difference(DateTime.now()).inSeconds,
        );
        QrBottomSheet().showBottomSheet();
      }
    }
  }

  void onEnd() {
    timeHasEnded(true);
  }

  Future<void> createMerchantQrCode() async {
    await fetchMerchantQrCode();
    if (showQr.value) {
      QrBottomSheet().showBottomSheet();
    }
  }

  Future<void> fetchMerchantQrCode() async {
    timeHasEnded(false);
    isLoading(true);
    showQr(true);
    listImage(null);

    final supplierId = await sharedPref.getSupplierId();

    await identifierTransaksiRepo.postCreateMerchantQrCode(
      Get.context,
      {"supplier_id": supplierId},
    ).then((value) async {
      expiredDate = value.data!.expiredDate;
      qrCodePath = value.data!.qrCodePath;

      await identifierTransaksiRepo
          .getImagesUint8List(Get.context, qrCodePath)
          .then((value) => listImage(value))
          .catchError((error) {
        timeHasEnded(true);
      });
    }).catchError((error) {
      showQr(false);
      timeHasEnded(true);
    });

    if (expiredDate != null) {
      qrCodeTimer(
        expiredDate!.difference(DateTime.now()).inSeconds,
      );
    }

    isLoading(false);
  }
}
