// ignore_for_file: missing_required_param

import 'dart:typed_data';

import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/core/model/agent_orders_response.dart';
import 'package:kreditplus_deasy_website/core/model/dashboard_response.dart';
import 'package:kreditplus_deasy_website/core/model/document_response.dart';
import 'package:kreditplus_deasy_website/core/model/orders/payment_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/orders/tracking_order_response_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/transaction_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_transaction_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/merchant_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/core/model/transaction_response.dart'
    as transaction;
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_website/core/utils/url_dart_html_wrapper.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:kreditplus_deasy_website/core/model/merchant/merchant_list_response.dart'
    as merchant;
import 'package:kreditplus_deasy_website/core/model/orders/payment_detail_response.dart'
    as payment;
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/dashboard_search_merchant_response.dart'
    as search;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setFlavor(DevFlavorConfig());
  DashboardMainController? controller;
  late SharedPreferences pref;

  final transactionRepositoryMock = TransactionRepositoryMock();
  final dtControllerMock = DashboardTransactionControllerMock();
  final merchantControllerMock = MerchantControllerMock();
  final dashboardRepositoryMock = DashboardRepositoryMock();
  final urlMock = UrlMock();
  final dialogMock = DialogMock();

  setUp(() async {
    setupTest(
      dtControllerMock,
      merchantControllerMock,
      transactionRepositoryMock,
      urlMock,
      dialogMock,
      dashboardRepositoryMock,
    );

    pref = await SharedPreferences.getInstance();

    controller = Get.find<DashboardMainController>();
    controller!.supplierId = "id";
  });

  tearDown(() {
    Get.delete<DashboardTransactionController>();
    Get.delete<MerchantController>();
    Get.delete<DashboardMainController>();
  });

  group("Controller Life Cycle", () {
    test("onInit Controller", () async {
      expect(controller, isInstanceOf<DashboardMainController>());

      // check if onInit was called
      expect(controller!.initialized, isTrue);

      // await time request
      await Future.delayed(Duration(milliseconds: 100));

      //check controller isRegistered
      bool test = Get.isRegistered<DashboardMainController>();
      expect(test, true);
    });

    test("onClose Controller", () {
      Get.delete<DashboardMainController>();

      //check controller isRegistered
      bool test = Get.isRegistered<DashboardMainController>();
      expect(test, false);
    });
  });

  group("Functions for initializing", () {
    test("initUserData", () async {
      //arrange
      final isVerifiedMatcher = true;
      final isMerchantMatcher = false;

      pref.setBool("isVerified", isVerifiedMatcher);
      pref.setBool("isMerchantOnline", isMerchantMatcher);

      //act
      await controller!.initUserData();

      //assert
      expect(controller!.isVerified.value, isVerifiedMatcher);
      expect(controller!.isMerchantOnline.value, isMerchantMatcher);
    });

    group("fetchRoleDetail", () {
      test("all access true", () async {
        //arrange
        pref.setString(
          KEY_PREFERENCES.roleDashboardPermission,
          """{
            "offline": true,
            "snb": true,
            "online": true,
            "po": true,
            "invoice": true,
            "view_bast": true,
            "upload_bast": true,
            "view_bukti_terima": true,
            "upload_bukti_terima": true
          }""",
        );

        pref.setString(
          KEY_PREFERENCES.roleDetail,
          """{"is_root":true}""",
        );

        //act
        await controller!.fetchRoleDetail();

        //assert
        expect(controller!.hasAdmin.value, true);
        expect(controller!.hasSelectMerchantAccess.value, true);
        expect(controller!.hasPOAccess.value, true);
        expect(controller!.hasInvoiceAccess.value, true);
        expect(controller!.hasViewBuktiTerimaAccess.value, true);
        expect(controller!.hasUploadBuktiTerimaAccess.value, true);
        expect(controller!.hasViewBASTAccess.value, true);
        expect(controller!.hasUploadBASTAccess.value, true);
      });

      test("all access false", () async {
        //arrange
        pref.setString(
          KEY_PREFERENCES.roleDashboardPermission,
          """{
            "offline": false,
            "snb": false,
            "online": false,
            "po": false,
            "invoice": false,
            "view_bast": false,
            "upload_bast": false,
            "view_bukti_terima": false,
            "upload_bukti_terima": false
          }""",
        );

        pref.setString(
          KEY_PREFERENCES.roleDetail,
          """{"is_root":false}""",
        );

        //act
        await controller!.fetchRoleDetail();

        //assert
        expect(controller!.hasAdmin.value, false);
        expect(controller!.hasAdmin.value, false);
        expect(controller!.hasSelectMerchantAccess.value, false);
        expect(controller!.hasPOAccess.value, false);
        expect(controller!.hasInvoiceAccess.value, false);
        expect(controller!.hasViewBuktiTerimaAccess.value, false);
        expect(controller!.hasUploadBuktiTerimaAccess.value, false);
        expect(controller!.hasViewBASTAccess.value, false);
        expect(controller!.hasUploadBASTAccess.value, false);
      });
    });

    group("onTapButtonFilterSummary", () {
      test("onTap Hari", () async {
        //arrange
        final incomingValueMatcher = 100;
        final incomingQtyMatcher = 20;

        when(dtControllerMock.fetchApiDashboardsDays(
          supplierId: anyNamed("supplierId"),
        )).thenAnswer(
          (_) async => true,
        );
        when(dtControllerMock.incomingValue).thenReturn(incomingValueMatcher.toDouble());
        when(dtControllerMock.incomingQty).thenReturn(incomingQtyMatcher);

        //act
        await controller!.onTapButtonFilterSummary(0);

        //assert
        expect(controller!.textIncomeByTime.value, "Hari");
        expect(controller!.incomingValue.value, incomingValueMatcher);
        expect(controller!.totalAplikasi.value, incomingQtyMatcher);
      });

      test("onTap Bulan", () async {
        //arrange
        final incomingValueMatcher = 2000;
        final incomingQtyMatcher = 300;

        when(dtControllerMock.fetchApiDashboardsMonths(
          supplierId: anyNamed("supplierId"),
        )).thenAnswer(
          ((_) async => null) as Future<List<DashboardResponse>> Function(
              Invocation),
        );
        when(dtControllerMock.incomingValue).thenReturn(incomingValueMatcher.toDouble());
        when(dtControllerMock.incomingQty).thenReturn(incomingQtyMatcher);

        //act
        await controller!.onTapButtonFilterSummary(1);

        //assert
        expect(controller!.textIncomeByTime.value, "Bulan");
        expect(controller!.incomingValue.value, incomingValueMatcher);
        expect(controller!.totalAplikasi.value, incomingQtyMatcher);
      });

      test("onTap Tahun", () async {
        //arrange
        final incomingValueMatcher = 4000;
        final incomingQtyMatcher = 500;

        when(dtControllerMock.fetchApiDashboardsYears(
          supplierId: anyNamed("supplierId"),
        )).thenAnswer(
          (_) async => true,
        );
        when(dtControllerMock.incomingValue).thenReturn(incomingValueMatcher.toDouble());
        when(dtControllerMock.incomingQty).thenReturn(incomingQtyMatcher);

        //act
        await controller!.onTapButtonFilterSummary(2);

        //assert
        expect(controller!.textIncomeByTime.value, "Tahun");
        expect(controller!.incomingValue.value, incomingValueMatcher);
        expect(controller!.totalAplikasi.value, incomingQtyMatcher);
      });

      test("onTap default", () async {
        //arrange

        //act
        final result = await controller!.onTapButtonFilterSummary(4);

        //assert
        expect(result, 0);
      });
    });

    group("fetchApiDashboardMerchants", () {
      test("Search Text is not empty", () async {
        //arange
        final merchantMatcher = merchant.MerchantListResponse(
          merchantData: [
            merchant.MerchantData(supplierId: "id1", name: "name1"),
            merchant.MerchantData(supplierId: "id2", name: "name2"),
          ],
          pageInfo: merchant.PageInfo(page: 1, nextPage: 2, totalPage: 3),
        );
        controller!.searchText = "not empty";
        when(merchantControllerMock.fetchApiDashboardsMerchants(
          context: anyNamed("context"),
          limit: anyNamed("limit"),
          page: anyNamed("page"),
        )).thenAnswer((_) async => merchantMatcher);

        //act
        await controller!.fetchApiDashboardsMerchants();

        //assert
        expect(
          controller!.merchantSearchResultCurrentPage.value,
          merchantMatcher.pageInfo!.page,
        );
        expect(
          controller!.nextPage.value,
          merchantMatcher.pageInfo!.nextPage,
        );
        expect(
          controller!.totalPage.value,
          merchantMatcher.pageInfo!.totalPage,
        );
        expect(controller!.searchResult.length, 2);
      });

      test("Search Text is empty", () async {
        //arange
        final merchantMatcher = merchant.MerchantListResponse(
          merchantData: [
            merchant.MerchantData(supplierId: "id1", name: "name1"),
            merchant.MerchantData(supplierId: "id2", name: "name2"),
            merchant.MerchantData(supplierId: "id3", name: "name3"),
          ],
          pageInfo: merchant.PageInfo(page: 1, nextPage: 2, totalPage: 3),
        );
        when(merchantControllerMock.fetchApiDashboardsMerchants(
          context: anyNamed("context"),
          limit: anyNamed("limit"),
          page: anyNamed("page"),
        )).thenAnswer((_) async => merchantMatcher);

        //act
        await controller!.fetchApiDashboardsMerchants();

        //assert
        expect(
          controller!.merchantSearchResultCurrentPage.value,
          merchantMatcher.pageInfo!.page,
        );
        expect(
          controller!.nextPage.value,
          merchantMatcher.pageInfo!.nextPage,
        );
        expect(
          controller!.totalPage.value,
          merchantMatcher.pageInfo!.totalPage,
        );
        expect(controller!.merchantDropdownList.length, 3);
      });
    });

    group("fetchApiAllOrderByPage", () {
      test("Status filter is not empty", () async {
        //arrange
        final transactionMatcher = transaction.TransactionResponse(
          data: [transaction.TransactionResponseData(supplierName: "name1")],
        );
        final statusFilterMatcher = ["item1", "item2"];

        when(transactionRepositoryMock.fetchApiAllOrders(
          any,
          any,
        )).thenAnswer((_) async => transactionMatcher);

        controller!.statusFilterList.addAll(statusFilterMatcher);
        controller!.filters = Map<String, dynamic>();

        //act
        await controller!.fetchApiAllOrdersByPage();

        //assert
        expect(controller!.statusFilterList.length, statusFilterMatcher.length);
        expect(
          controller!.transactionList.first.supplierName,
          transactionMatcher.data!.first.supplierName,
        );
      });

      test("Status filter is empty", () async {
        //arrange
        final transactionMatcher = transaction.TransactionResponse(
          data: [transaction.TransactionResponseData(supplierName: "name2")],
        );

        when(transactionRepositoryMock.fetchApiAllOrders(
          any,
          any,
        )).thenAnswer((_) async => transactionMatcher);

        controller!.filters = Map<String, dynamic>();

        //act
        await controller!.fetchApiAllOrdersByPage();

        //assert
        expect(
          controller!.transactionList.first.supplierName,
          transactionMatcher.data!.first.supplierName,
        );
        expect(controller!.statusFilterList.length, 0);
      });
    });
  });

  group("FindTransaction", () {
    test("Query is not blank", () async {
      //act
      controller!.findTransaction("query");

      //assert
      expect(controller!.transactionList.length, 0);
      expect(controller!.index.value, 1);
    });

    test("Query is blank", () async {
      //act
      controller!.findTransaction("");

      //assert
      expect(controller!.transactionList.length, 0);
      expect(controller!.index.value, 1);
    });
  });

  group("ExpandedRow", () {
    test("ExpandedIndex equal to RowIndex", () {
      //arrange
      controller!.expandedIndex.value = 1;

      //act
      controller!.expandRow(1);

      //assert
      expect(controller!.expandedIndex.value, 0);
    });

    test("ExpandedIndex not equal to RowIndex", () {
      //arrange
      final matcher = 3;
      controller!.expandedIndex.value = 2;

      //act
      controller!.expandRow(matcher);

      //assert
      expect(controller!.expandedIndex.value, matcher);
    });
  });

  group("OnPreview", () {
    test("Document Access PO", () async {
      //arrange
      final documentMatcher = DocumentResponse(data: [
        DocumentData(name: "epo 1", url: "item1"),
      ]);

      final urlMacther = "url";

      when(transactionRepositoryMock.fetchApiDocumentById(
        any,
        any,
        any,
      )).thenAnswer((_) async => documentMatcher);

      when(transactionRepositoryMock.fetchDocument(
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => Uint8List(1));

      when(urlMock.createObjectUrlFromBlob(any)).thenAnswer((_) => urlMacther);

      //act
      controller!
          .onPreview(ContentConstant.PO, transaction.TransactionResponseData());
      await Future.delayed(Duration(seconds: 1));

      //assert
      expect(controller!.pdfUrl, urlMacther);
    });

    test("Document Access INVOICE", () async {
      //arrange
      final documentMatcher = DocumentResponse(data: [
        DocumentData(name: "invoice 1", url: "item1"),
      ]);

      final urlMacther = "url invoice";

      when(transactionRepositoryMock.fetchApiDocumentById(
        any,
        any,
        any,
      )).thenAnswer((_) async => documentMatcher);

      when(transactionRepositoryMock.fetchDocument(
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => Uint8List(1));

      when(urlMock.createObjectUrlFromBlob(any)).thenAnswer((_) => urlMacther);

      //act
      controller!
          .onPreview(ContentConstant.INVOICE, transaction.TransactionResponseData());
      await Future.delayed(Duration(seconds: 1));

      //assert
      expect(controller!.pdfUrl, urlMacther);
    });

    test("Document Access Bukti Terima", () async {
      //arrange
      when(transactionRepositoryMock.fetchDocument(
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => Uint8List(1));

      when(dialogMock.dialog(any, any)).thenAnswer((_) async => true);

      //act
      controller!.onPreview(
        ContentConstant.BUKTI_TERIMA,
        transaction.TransactionResponseData(),
      );
      await Future.delayed(Duration(seconds: 1));

      //assert
      expect(controller!.isImageLoaded.value, false);
      expect(controller!.isLoadCustReceipt.value, false);
    });

    test("Document Access BAST", () async {
      //arrange
      when(transactionRepositoryMock.fetchDocument(
        any,
        any,
        any,
        any,
      )).thenAnswer((_) async => Uint8List(1));

      when(dialogMock.dialog(any, any)).thenAnswer((_) async => true);

      //act
      controller!.onPreview(
        ContentConstant.BAST,
        transaction.TransactionResponseData(),
      );
      await Future.delayed(Duration(seconds: 1));

      //assert
      expect(controller!.isImageLoaded.value, false);
      expect(controller!.isLoadBast.value, false);
    });
  });
  test("OnUpload", () {
    //arrange
    controller!.isUploading(true);

    //act
    controller!.onUpload(
      ContentConstant.BAST,
      transaction.TransactionResponseData(),
    );

    //assert
    expect(controller!.isUploading.value, false);
  });

  group("Action", () {
    group('Document Access PO', () {
      test("Flag view", () {
        //arrange
        final transactionData = transaction.TransactionResponseData(
          epoDate: DateTime.now(),
          orderStatus: EnumOrderTransaction.approved,
        );

        //act
        final result = controller!.action(ContentConstant.PO, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Flag none", () {
        //act
        final result = controller!.action(
          ContentConstant.PO,
          transaction.TransactionResponseData(),
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });
    });

    group("Document Access INVOICE", () {
      test("Flag view", () {
        //arrange
        final transactionData = transaction.TransactionResponseData(
          invoiceDate: DateTime.now(),
          orderStatus: EnumOrderTransaction.purchaseConfirmed,
        );

        //act
        final result = controller!.action(ContentConstant.INVOICE, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Flag none", () {
        //act
        final result = controller!.action(
          ContentConstant.INVOICE,
          transaction.TransactionResponseData(),
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });
    });

    group("Document Access BUKTI TERIMA", () {
      test("Has upload & view access return flag none", () {
        //arrange
        controller!.hasViewBuktiTerimaAccess(true);
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          orderStatus: EnumOrderTransaction.rejected,
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has upload & view access return flag view", () {
        //arrange
        controller!.hasViewBuktiTerimaAccess(true);
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          orderStatus: EnumOrderTransaction.approved,
          customerReceiptPhotoUrl: "url",
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Has upload & view access return flag upload", () {
        //arrange
        controller!.hasViewBuktiTerimaAccess(true);
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          customerReceiptPhotoUrl: "",
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD);
      });

      test("Has view access return flag none", () {
        //arrange
        controller!.hasViewBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          customerReceiptPhotoUrl: "",
          orderStatus: EnumOrderTransaction.rejected,
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has view access return flag view", () {
        //arrange
        controller!.hasViewBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          customerReceiptPhotoUrl: "url",
          orderStatus: EnumOrderTransaction.approved,
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Has upload access status reject return flag none", () {
        //arrange
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          orderStatus: EnumOrderTransaction.rejected,
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has upload access status approve return flag none", () {
        //arrange
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          customerReceiptPhotoUrl: "url",
          orderStatus: EnumOrderTransaction.approved,
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has upload access return flag upload", () {
        //arrange
        controller!.hasUploadBuktiTerimaAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BUKTI_TERIMA,
            ),
          ],
          customerReceiptPhotoUrl: "",
        );

        //act
        final result = controller!.action(
          ContentConstant.BUKTI_TERIMA,
          transactionData,
        );

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD);
      });
    });

    group("Document Acesse BAST", () {
      test("Has upload & view access return flag view", () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        controller!.hasViewBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.disbursed,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Has upload & view access return flag upload", () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        controller!.hasViewBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.approved,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD);
      });

      test("Has upload & view access sourceAplication SNB return flag none",
          () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        controller!.hasViewBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.approved,
          sourceApplication: ContentConstant.SNB,
          customerReceiptPhotoUrl: "",
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has view access return flag view", () {
        //arrange
        controller!.hasViewBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.disbursed,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW);
      });

      test("Has view access return flag none", () {
        //arrange
        controller!.hasViewBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.rejected,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has upload access return flag upload", () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.approved,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD);
      });

      test("Has upload access sourceAplication SNB return flag none", () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.approved,
          customerReceiptPhotoUrl: "",
          sourceApplication: ContentConstant.SNB,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });

      test("Has upload access return flag none", () {
        //arrange
        controller!.hasUploadBASTAccess(true);
        final transactionData = transaction.TransactionResponseData(
          confirmationMethods: [
            transaction.ConfirmationMethodElement(
              confirmationMethod: ContentConstant.BAST,
            ),
          ],
          orderStatus: EnumOrderTransaction.rejected,
        );

        //act
        final result = controller!.action(ContentConstant.BAST, transactionData);

        //assert
        expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
      });
    });
  });

  group("IsHasRequestCancelAccess", () {
    test("isAwb return true", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          )
        ],
        orderStatus: EnumOrderTransaction.approved,
      );

      //act
      final result = controller!.isHasRequestCancelAccess(transactionData);

      //assert
      expect(result, true);
    });

    test("isAwb return false", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          )
        ],
        orderStatus: EnumOrderTransaction.rejected,
      );

      //act
      final result = controller!.isHasRequestCancelAccess(transactionData);

      //assert
      expect(result, false);
    });

    test("is not Awb return false", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          )
        ],
        orderStatus: EnumOrderTransaction.rejected,
      );

      //act
      final result = controller!.isHasRequestCancelAccess(transactionData);

      //assert
      expect(result, false);
    });

    test("is not Awb status onprogress return true", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          )
        ],
        orderStatus: EnumOrderTransaction.onProgress,
      );

      //act
      final result = controller!.isHasRequestCancelAccess(transactionData);

      //assert
      expect(result, true);
    });

    test("is not Awb status onprogress return false", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          )
        ],
        orderStatus: EnumOrderTransaction.onProgress,
        sourceApplication: ContentConstant.eformSourceApp.toUpperCase(),
      );

      //act
      final result = controller!.isHasRequestCancelAccess(transactionData);

      //assert
      expect(result, false);
    });
  });

  group("HasInfoAccess", () {
    test("return true", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          ),
        ],
        orderStatus: EnumOrderTransaction.disbursed,
      );

      //act
      final result = controller!.hasInfoAccess(transactionData);

      //assert
      expect(result, true);
    });

    test("return false", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          ),
        ],
        orderStatus: EnumOrderTransaction.rejected,
      );

      //act
      final result = controller!.hasInfoAccess(transactionData);

      //assert
      expect(result, false);
    });
  });

  group("GetInfoAccess", () {
    test("isAwb trackingExists true status approve", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.approved,
        trackingExists: true,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.trackingFlag);
    });

    test("isAwb trackingExists false status approve", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.approved,
        trackingExists: false,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.trackingFlag);
    });

    test("isAwb status purchase confirmed", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.purchaseConfirmed,
        trackingExists: true,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.trackingFlag);
    });

    test("isAwb status disbursed", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.disbursed,
        trackingExists: true,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.paidFlag);
    });

    test("is not Awb status disbursed", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          ),
        ],
        orderStatus: EnumOrderTransaction.disbursed,
        trackingExists: true,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.paidFlag);
    });

    test("is not Awb return flag none", () {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.BAST,
          ),
        ],
        orderStatus: EnumOrderTransaction.rejected,
        trackingExists: true,
      );

      //act
      final result = controller!.getInfoAccess(transactionData);

      //assert
      expect(result, ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE);
    });
  });

  group("FetchApiDashboardsMerchantsByName", () {
    test("is last page", () async {
      //arrange
      final dashboardData = search.DashboardSearchMerchantResponse(
        code: 1,
        message: "message",
        data: [
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId1",
            name: "testName1",
            groupName: "testGroupName1",
            branchId: "testBranchId1"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId2",
            name: "testName2",
            groupName: "testGroupName2",
            branchId: "testBranchId2"
          ),
        ],
        pageInfo: search.PageInfo(
          totalRecord: 2,
          totalPage: 1,
          offset: 0,
          limit: 10,
          page: 1
        ),
      );

      when(dashboardRepositoryMock.fetchApiDashboardSearchMerchants(
        any,
        searchKey: anyNamed("searchKey"),
        page: anyNamed("page"),
        limit: anyNamed("limit"),
      )).thenAnswer((_) async => dashboardData);

      //act
      final result = await controller!.fetchApiDashboardsMerchantsByName(
        1,
        "searchKey",
      );

      //assert
      expect(result, true);
    });

    test("is not last page", () async {
      //arrange
      final dashboardData = search.DashboardSearchMerchantResponse(
        code: 1,
        message: "message",
        data: [
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId1",
            name: "testName1",
            groupName: "testGroupName1",
            branchId: "testBranchId1"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId2",
            name: "testName2",
            groupName: "testGroupName2",
            branchId: "testBranchId2"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId3",
            name: "testName3",
            groupName: "testGroupName3",
            branchId: "testBranchId3"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId4",
            name: "testName4",
            groupName: "testGroupName4",
            branchId: "testBranchId4"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId5",
            name: "testName5",
            groupName: "testGroupName5",
            branchId: "testBranchId5"
          ),
          search.DashboardSearchMerchantData(
            supplierId: "testSupplierId6",
            name: "testName6",
            groupName: "testGroupName6",
            branchId: "testBranchId6"
          ),
        ],
        pageInfo: search.PageInfo(
          totalRecord: 2,
          totalPage: 1,
          offset: 0,
          limit: 10,
          page: 1
        ),
      );

      when(dashboardRepositoryMock.fetchApiDashboardSearchMerchants(
        any,
        searchKey: anyNamed("searchKey"),
        page: anyNamed("page"),
        limit: anyNamed("limit"),
      )).thenAnswer((_) async => dashboardData);

      //act
      final result = await controller!.fetchApiDashboardsMerchantsByName(
        1,
        "searchKey",
      );

      //assert
      expect(result, false);
    });
  });

  group("Sorting & filter", () {
    test("OntapMerchantSearch", () {
      //arrange
      expect(controller!.isMerchantSearchBoxTapped.value, false);

      //act
      controller!.onTapShowMerchantSearch();

      //assert
      expect(controller!.isMerchantSearchBoxTapped.value, true);
    });

    test("OntapSelectMerchant", () async {
      //arrange
      final idMatcher = "id";
      final nameMatcher = "name";
      controller!.textEditingSearchMerchantController = TextEditingController();

      //arrange fetchApiDashboard
      final incomingValueMatcher = 100;
      final incomingQtyMatcher = 20;
      when(dtControllerMock.fetchApiDashboardsDays(
        supplierId: anyNamed("supplierId"),
      )).thenAnswer(
        (_) async => true,
      );
      when(dtControllerMock.incomingValue).thenReturn(incomingValueMatcher.toDouble());
      when(dtControllerMock.incomingQty).thenReturn(incomingQtyMatcher);

      //arrange fetchApiAllOrders
      final transactionMatcher = transaction.TransactionResponse(
        data: [transaction.TransactionResponseData(supplierName: "name2")],
      );
      when(transactionRepositoryMock.fetchApiAllOrders(
        any,
        any,
      )).thenAnswer((_) async => transactionMatcher);
      controller!.filters = Map<String, dynamic>();

      //act
      await controller!.onTapSelectMerchant(idMatcher, nameMatcher);

      //assert
      expect(controller!.supplierId, idMatcher);
      expect(controller!.selectedMerchantName.value, nameMatcher);

      //assert fectApiDashboard
      expect(controller!.textIncomeByTime.value, "Hari");
      expect(controller!.incomingValue.value, incomingValueMatcher);
      expect(controller!.totalAplikasi.value, incomingQtyMatcher);

      //assert fetchApiAllOrders
      expect(
        controller!.transactionList.first.supplierName,
        transactionMatcher.data!.first.supplierName,
      );
      expect(controller!.statusFilterList.length, 0);
    });

    test("OnSearchTextChange", () {
      //arrange
      controller!.searchMerchantPagingController.appendPage(
        [search.DashboardSearchMerchantData(
          supplierId: "testSupplierId1",
            name: "testName1",
            groupName: "testGroupName1",
            branchId: "testBranchId1"
        )],
        2,
      );
      expect(controller!.searchMerchantPagingController.itemList!.length, 1);

      //act
      controller!.onSearchTextChanged();

      //assert
      expect(controller!.searchMerchantPagingController.itemList == null, true);
    });

    test("OnClickStatusFilter", () {
      //arrange
      controller!.isOpenStatusFilter(false);
      controller!.isOpenDateFilter(true);

      //act
      controller!.onClickStatusFilter();

      //assert
      expect(controller!.isOpenStatusFilter.value, true);
      expect(controller!.isOpenDateFilter.value, false);
    });

    test("OnClickDateFilter", () {
      //arrange
      controller!.isOpenStatusFilter(true);
      controller!.isOpenDateFilter(false);

      //act
      controller!.onClickDateFilter();

      //assert
      expect(controller!.isOpenStatusFilter.value, false);
      expect(controller!.isOpenDateFilter.value, true);
    });

    test("ClearStatusFilter", () {
      //arrange
      controller!.statusMap.assign("tes", true);
      expect(controller!.statusMap['tes'], true);

      controller!.filters = Map<String, dynamic>();

      //act
      controller!.clearStatusFilter();

      //assert
      expect(controller!.statusMap['tes'], false);
      expect(controller!.isOpenStatusFilter.value, false);
    });

    group("OnApplyStatusFilter", () {
      test("key value true & key paid", () {
        //arrange
        controller!.statusMap.assign("Paid", true);
        expect(controller!.statusMap['Paid'], true);

        controller!.filters = Map<String, dynamic>();

        //act
        controller!.onApplyStatusFilter();

        //assert
        expect(controller!.statusFilterList.first, "Disbursed");
        expect(controller!.isOpenStatusFilter.value, false);
      });

      test("key value true & key not paid", () {
        //arrange
        controller!.statusMap.assign("not Paid", true);
        expect(controller!.statusMap['not Paid'], true);

        controller!.filters = Map<String, dynamic>();

        //act
        controller!.onApplyStatusFilter();

        //assert
        expect(controller!.statusFilterList.first, "not Paid");
        expect(controller!.isOpenStatusFilter.value, false);
      });

      test("key value false", () {
        //arrange
        controller!.statusMap.assign("tes", false);
        expect(controller!.statusMap['tes'], false);

        controller!.filters = Map<String, dynamic>();

        //act
        controller!.onApplyStatusFilter();

        //assert
        expect(controller!.statusFilterList.isEmpty, true);
        expect(controller!.isOpenStatusFilter.value, false);
      });
    });

    test("OnSelectDateChange", () {
      //arrange
      final args = DateRangePickerSelectionChangedArgs(PickerDateRange(
        DateTime.now(),
        DateTime.now(),
      ));

      //act
      controller!.onSelectedDateChanged(args);

      //assert
      // expect(controller.maxDate.minute, DateTime.now().minute);
    });

    test("OnDateFilterConfirm", () {
      //arrange
      controller!.filters = Map<String, dynamic>();

      final startDateMatcher = DateTime.now();
      final endDateMatcher = DateTime.now();

      //act
      controller!.onDateFilterConfirmed(startDateMatcher, endDateMatcher);

      //assert
      expect(controller!.activeStartDate, startDateMatcher);
      expect(controller!.activeEndDate, endDateMatcher);
    });

    test("SortingProspecId", () {
      //arrange
      controller!.isProspectIdDesc(true);
      controller!.filters = Map<String, dynamic>();

      //act
      controller!.sortingProspectId();

      //assert
      expect(controller!.orderList.first['column_name'], "prospect_id");
      expect(controller!.orderList.first['dir'], "desc");
    });

    test("SortingMerchantName", () {
      //arrange
      controller!.isMerchantNameDesc(false);
      controller!.filters = Map<String, dynamic>();

      //act
      controller!.sortingMerchantName();

      //assert
      expect(controller!.orderList.first['column_name'], "supplier_name");
      expect(controller!.orderList.first['dir'], "asc");
    });

    test("SortingOtr", () {
      //arrange
      controller!.isOtrDesc(true);
      controller!.filters = Map<String, dynamic>();

      //act
      controller!.sortingOtr();

      //assert
      expect(controller!.orderList.first['column_name'], "otr");
      expect(controller!.orderList.first['dir'], "desc");
    });

    test("SortingOrderDate", () {
      //arrange
      controller!.isOrderDateDesc(true);
      controller!.filters = Map<String, dynamic>();

      //act
      controller!.sortingOrderDate();

      //assert
      expect(controller!.orderList.first['column_name'], "order_date");
      expect(controller!.orderList.first['dir'], "desc");
    });

    test("SortingOrderStatus", () {
      //arrange
      controller!.isOrderStatusDesc(true);
      controller!.filters = Map<String, dynamic>();

      //act
      controller!.sortingOrderStatus();

      //assert
      expect(controller!.orderList.first['column_name'], "order_status");
      expect(controller!.orderList.first['dir'], "desc");
    });
  });

  group("GenerateExcel", () {
    test("infromation is null", () async {
      //arrange
      final transactionMatcher = transaction.TransactionResponseData(
        prospectId: "id",
        otr: 2000000,
        orderDate: DateTime.now(),
      );

      controller!.transactionList.add(transactionMatcher);

      //act
      final result = await controller!.generateExcel();

      //assert
      expect(
        result?.getRangeByName(controller!.getIndex("A", 0)).displayText,
        transactionMatcher.prospectId,
      );

      expect(
        result?.getRangeByName(controller!.getIndex("D", 0)).displayText,
        "-",
      );

      expect(
        result?.getRangeByName(controller!.getIndex("E", 0)).displayText,
        "-",
      );

      expect(
        result?.getRangeByName(controller!.getIndex("F", 0)).displayText,
        "-",
      );

      expect(
        result?.getRangeByName(controller!.getIndex("G", 0)).displayText,
        "-",
      );

      expect(
        result?.getRangeByName(controller!.getIndex("H", 0)).displayText,
        "-",
      );
    });

    test("Information is not null", () async {
      //arrange
      final String _dateFormat = "yyyy-MM-dd";
      final transactionMatcher = transaction.TransactionResponseData(
        prospectId: "id",
        otr: 2000000,
        orderDate: DateTime.now(),
        orderStatus: EnumOrderTransaction.approved,
        invoiceDate: DateTime.now(),
        goLiveDate: DateTime.now(),
        payToDealerAmount: 200000,
        payToDealerDate: DateTime.now(),
      );

      controller!.transactionList.add(transactionMatcher);

      //act
      final result = await controller!.generateExcel();

      //assert
      expect(
        result?.getRangeByName(controller!.getIndex("A", 0)).displayText,
        transactionMatcher.prospectId,
      );

      expect(
        result?.getRangeByName(controller!.getIndex("D", 0)).displayText,
        transactionMatcher.orderStatus.name,
      );

      expect(
        result?.getRangeByName(controller!.getIndex("E", 0)).displayText,
        transactionMatcher.invoiceDate
            .toString()
            .toFormattedDate(format: _dateFormat),
      );

      expect(
        result?.getRangeByName(controller!.getIndex("F", 0)).displayText,
        transactionMatcher.goLiveDate
            .toString()
            .toFormattedDate(format: _dateFormat),
      );

      expect(
        result?.getRangeByName(controller!.getIndex("G", 0)).displayText,
        transactionMatcher.payToDealerAmount.toString().toCurrency(),
      );

      expect(
        result?.getRangeByName(controller!.getIndex("H", 0)).displayText,
        transactionMatcher.payToDealerDate
            .toString()
            .toFormattedDate(format: _dateFormat),
      );
    });
  });

  test("GetIndex", () {
    //arrange
    final keyMatcher = "key";
    final indexMatcher = 1;

    //act
    final result = controller!.getIndex(keyMatcher, indexMatcher);

    //assert
    expect(result, "$keyMatcher${indexMatcher + 2}");
  });

  test("DownloadDocument", () async {
    //arrange
    final urlMacther = "url";

    when(transactionRepositoryMock.fetchDocument(
      any,
      any,
      any,
      any,
    )).thenAnswer((_) async => Uint8List(1));

    when(urlMock.createObjectUrlFromBlob(any)).thenAnswer((_) => urlMacther);

    //act
    await controller!.downloadDocument("name", "name", "name");

    //assert
    expect(controller!.pdfUrl, urlMacther);
  });

  //Test not working
  //problem mocking Dropzoneviewcontroller
  test("OnDropFile", () {
    //arrange

    //act
    // final result = controller.onDropFile("ev", () {}, true);

    //assert
  });

  //Test not working
  //problem mocking PickedFile
  //at line 1057 var list = await bastFile.readAsBytes();
  test("ChooseFileIp", () {
    //arrange

    //act
    // final result = controller.chooseFileIP(true, (fn) {});

    //assert
  });

  test("CreateBodyRequest", () {
    //arrange
    final idMatcher = "tesid";

    //act
    final result = controller!.createBodyRequest(idMatcher);

    //assert
    expect(result['prospect_id'], idMatcher);
  });

  //Test not working
  //problem mocking PickedFile
  //at line 1095 bastFile.readAsBytes().then((value) {
  test("UploadSelectedFile", () {
    //arrange

    //act
    // final result = controller.uploadSelectedFile("prospectId", true, (fn) {});

    //assert
  });

  group("OnInfo", () {
    test("Tracking order", () async {
      //arrange
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.approved,
        trackingExists: true,
      );

      final trackingMatcher = TrackingOrderResponseModel(
        code: 200,
        message: "message",
        data: TrackingOrderData(
          id: "testId",
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          deletedAt: null,
          packedTime: DateTime.now(),
          destinationTime: DateTime.now(),
          logisticName: "log name",
          awbNumber: "awbnumber",
          deliveryTime: DateTime.now(),
          status: "status",
          prospectId: "id",
          receiverName: "receivename",
          shippingAddress: "address",
          mobilePhone: "mobilephone",
        ),
      );

      when(dashboardRepositoryMock.fetchApiDashboardOrderStatus(
        any,
        any,
      )).thenAnswer((_) async => trackingMatcher);

      when(dialogMock.dialog(any, any)).thenAnswer((_) async => true);

      //act
      final result = controller!.onInfo(transactionData);

      //assert
      expect(result, "tracking order");
    });

    test("Payment Detail", () {
      //arrange
      initializeDateFormatting('en');
      final transactionData = transaction.TransactionResponseData(
        confirmationMethods: [
          transaction.ConfirmationMethodElement(
            confirmationMethod: ContentConstant.AWB,
          ),
        ],
        orderStatus: EnumOrderTransaction.disbursed,
        trackingExists: true,
      );

      when(dialogMock.dialog(any, any)).thenAnswer((_) async => true);

      final paymentData = PaymentDetailResponse(
        data: payment.Data(
          payToDealerDate: DateTime.now(),
          prospectId: "id",
          agreementNo: "agrement",
          payToDealerAmount: 2,
          trackingStatus: "tracking status",
        ),
      );

      when(transactionRepositoryMock.fetchApiPaymentDetail(
        any,
        any,
      )).thenAnswer((_) async => paymentData);

      //act
      final result = controller!.onInfo(transactionData);

      //assert
      expect(result, "payment detail");
    });
  });
}

void setupTest(
  DashboardTransactionController dtcMock,
  MerchantController mcMock,
  TransactionRepository trMock,
  UrlDartHtmlWrapper urlMock,
  DeasyDialogWrapper dialogMock,
  DashboardRepository dashboardRepositoryMock,
) {
  SharedPreferences.setMockInitialValues({
    "role": DeasyEncryptorUtil.encryptString("role"),
    "name": DeasyEncryptorUtil.encryptString("name"),
    KEY_PREFERENCES.roleId: "",
    KEY_PREFERENCES.roleDashboardPermission: """{
        "offline": true,
        "snb": false,
        "online": false,
        "po": true,
        "invoice": true,
        "view_bast": true,
        "upload_bast": true,
        "view_bukti_terima": true,
        "upload_bukti_terima": true
      }"""
  });

  when(dtcMock.fetchApiDashboardsDays(
    supplierId: '',
  )).thenAnswer(
    (_) async => true,
  );

  when(mcMock.fetchApiDashboardsMerchants(
    context: anyNamed("context"),
    limit: anyNamed("limit"),
    page: anyNamed("page"),
  )).thenAnswer(
    (_) async => merchant.MerchantListResponse(
      merchantData: [merchant.MerchantData()],
      pageInfo: merchant.PageInfo(
        page: 1,
        nextPage: 2,
        totalPage: 2,
      ),
    ),
  );

  when(trMock.fetchApiAllOrders(
    any,
    any,
  )).thenAnswer(
    (_) async => transaction.TransactionResponse(
      data: [],
    ),
  );

  final binding = BindingsBuilder(() {
    Get.lazyPut<DeasyDialogWrapper>(() => dialogMock);
    Get.lazyPut<UrlDartHtmlWrapper>(() => urlMock);
    Get.lazyPut<MerchantController>(() => mcMock);
    Get.lazyPut<DashboardTransactionController>(() => dtcMock);
    Get.lazyPut<OptimusDrawerCustomController>(
        () => DrawerCustomControllerMock());
    Get.lazyPut<DashboardMainController>(
      () => DashboardMainController(
        dashboardRepository: dashboardRepositoryMock,
        transactionRepository: trMock,
      ),
    );
  });
  binding.builder();
}

class DialogMock extends Mock implements DeasyDialogWrapper {}

class UrlMock extends Mock implements UrlDartHtmlWrapper {}

class DashboardRepositoryMock extends Mock implements DashboardRepository {}

class TransactionRepositoryMock extends Mock implements TransactionRepository {}

class MerchantControllerMock extends GetxController
    with Mock
    implements MerchantController {}

class DashboardTransactionControllerMock extends GetxController
    with Mock
    implements DashboardTransactionController {}

class DrawerCustomControllerMock extends GetxController
    with Mock
    implements OptimusDrawerCustomController {}
