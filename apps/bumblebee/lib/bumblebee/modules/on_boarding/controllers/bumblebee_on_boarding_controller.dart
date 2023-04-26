import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/models/bumblebee_on_boarding_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeeOnBoardingController extends GetxController {

  final currentPage = 0.obs;
  final onBoardingArrayList = <BumblebeeOnBoardingModel>[].obs;
  final pageController = PageController(initialPage: 0);
  
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    addItemBoarding();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  onPageChanged(int index) {
    currentPage.value = index;
    update();
  }

  void addItemBoarding() {
    onBoardingArrayList.add(BumblebeeOnBoardingModel(
        sliderImageUrl: 'resources/images/on_boarding_1.png',
        sliderHeading: "Kemudahan dalam kelola pesanan",
        sliderSubHeading:
            "Berfungsi sebagai aplikasi terpusat untuk semua saluran masuk Kreditplus, di mana pengguna dapat melihat semua pesanan dan detailnya."));

    onBoardingArrayList.add(BumblebeeOnBoardingModel(
        sliderImageUrl: 'resources/images/on_boarding_2.png',
        sliderHeading: "Dapatkan semuanya dalam genggaman",
        sliderSubHeading:
            "Dapatkan semua laporan hanya dengan download E-PO (Purchase Order) dan E-Invoice, juga upload File BAST (Berita Acara Serah Terima)"));

    onBoardingArrayList.add(BumblebeeOnBoardingModel(
        sliderImageUrl: 'resources/images/on_boarding_3.png',
        sliderHeading: "Jelajahi lebih yang ada di Deasy",
        sliderSubHeading:
            "Sebagai admin super, buat pengguna baru, juga tetapkan peran dan fitur untuk masing-masing pengguna berdasarkan kebutuhannya."));
    update();
  }

  void nextPage() {
    if (currentPage.value > 1) {
      updateFirstLaunch();
    } else {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void skip() {
    pageController.jumpToPage(2);
    currentPage.value = 2;
    update();
  }

  updateFirstLaunch() async {
    final SharedPreferences sharedPreferences = await _prefs;
    await sharedPreferences.setBool("is_first_launch", false);
    Get.offAndToNamed(BumblebeeRoutes.LOGIN);
  }
}
