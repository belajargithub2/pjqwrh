// ignore_for_file: constant_identifier_names

import 'package:additional_documents/additional_documents.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class NewWgAdditionalDocsAppPages {
  NewWgAdditionalDocsAppPages._();

  static const INITIAL = NewWgAdditionalDocumentsRoutes.NEWWG_ADD_DOCS;

  static final routes = [
    GetPage(
      name: _Paths.NEWWG_ADD_DOCS,
      page: () => const AdditionalDocumentsScreen(),
      binding: AdditionalDocumentsBinding(),
    ),
    GetPage(
      name: _Paths.NEWWG_ADD_DOCS_TAKE_PHOTO,
      page: () => const TakePhotoMobileScreen(),
      binding: AdditionalDocumentsBinding(),
    ),
    GetPage(
      name: _Paths.NEWWG_ADD_DOCS_PHOTO_PREV,
      page: () => const PhotoPreviewMobileScreen(),
      binding: AdditionalDocumentsBinding(),
    ),
  ];
}