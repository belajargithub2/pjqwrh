import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/repositories/optimus_identifier_transaksi_repository.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class OptimusWebQrRefferalController extends GetxController {
  final timeHasEnded = false.obs;
  final qrCodeTimer = 0.obs;
  final isLoading = false.obs;

  final identifierTransaksiRepo = Get.find<OptimusIdentifierTransaksiRepository>();
  final sharedPref = DeasyPocket();

  Rxn<Uint8List> listImage = Rxn<Uint8List>();
  DateTime? expiredDate;
  String? qrCodePath;

  void onShowQrRefferalTab() {
    if (listImage.value == null) {
      createMerchantQrCode();
      timeHasEnded(false);
    } else {
      final isExpired = expiredDate!.isBefore(DateTime.now());
      if (isExpired) {
        timeHasEnded(true);
        createMerchantQrCode();
        timeHasEnded(false);
      } else {
        qrCodeTimer(
          expiredDate!.difference(DateTime.now()).inSeconds,
        );
      }
    }
  }

  void onEnd() {
    timeHasEnded(true);
  }

  void refreshQr() {
    createMerchantQrCode();
    timeHasEnded(false);
  }

  Future<void> createMerchantQrCode() async {
    isLoading(true);
    listImage(null);

    final supplierId = await sharedPref.getSupplierId();

    await identifierTransaksiRepo.postCreateMerchantQrCode(
      Get.context,
      {"supplier_id": supplierId},
    ).then((value) {
      expiredDate = value.data!.expiredDate;
      qrCodePath = value.data!.qrCodePath;
    }).catchError((error) {
      isLoading(false);
      timeHasEnded(true);
    });

    await identifierTransaksiRepo
        .getImagesUint8List(Get.context, qrCodePath)
        .then((value) => listImage(value))
        .catchError((error) {
      isLoading(false);
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
