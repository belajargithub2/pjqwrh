import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';

import 'no_internet_checker_controller.dart';

class NoInternetCheckerWidget extends GetWidget<NoInternetCheckerController> {
  final void Function() onRefresh;

  NoInternetCheckerWidget({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DeasyColor.neutral50,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 25.0, vertical: Get.width / 2),
        child: Center(
          child: Column(
            children: [
              Image.asset('resources/images/no_internet_1.png'),
              SizedBox(height: 15),
              Text(
                'Laman yang kamu cari gagal dimuat. Mohon muat ulang dan pastikan internetmu lancar',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onRefresh,
                child: Text(
                  'Muat Ulang',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: DeasyColor.kpYellow500,
                  elevation: 1,
                  minimumSize: Size(Get.width, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
