// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class NewWgAdditionalDocumentsRoutes {
  NewWgAdditionalDocumentsRoutes._();

  static const NEWWG_ADD_DOCS = _Paths.NEWWG_ADD_DOCS;
  static const NEWWG_ADD_DOCS_PHOTO_PREV = _Paths.NEWWG_ADD_DOCS_PHOTO_PREV;
  static const NEWWG_ADD_DOCS_TAKE_PHOTO = _Paths.NEWWG_ADD_DOCS_TAKE_PHOTO;
}

abstract class _Paths {
  static const NEWWG_ADD_DOCS = "/newwg-additional-documents";
  static const NEWWG_ADD_DOCS_PHOTO_PREV = "/newwg-additional-documents-photo-preview";
  static const NEWWG_ADD_DOCS_TAKE_PHOTO = "/newwg-additional-documents-take-photo";
}