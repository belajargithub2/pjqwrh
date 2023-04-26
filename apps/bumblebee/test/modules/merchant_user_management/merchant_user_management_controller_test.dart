import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/bindings/account_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/content_constant.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart' as m;

import '../../mocks/config/firebase_core_config_mock.dart';
import 'merchant_user_management_controller_test.mocks.dart';


@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<DeepLinkRepository>(),
  MockSpec<DynamicLinkConfig>(),
  MockSpec<RoleManagementRepository>(),
  MockSpec<UserRepository>(),
])
void main() {
  setFlavor(DevFlavorConfig());
  setupFirebaseMocks();

  late BumblebeeMerchantUserManagementController controller;
  
  final authRepositoryMock = MockAuthRepository();
  final deepLinkRepositoryMock = MockDeepLinkRepository();
  final dynamicLinkConfigMock = MockDynamicLinkConfig();
  final roleManagementRepositoryMock = MockRoleManagementRepository();
  final userRepositoryMock = MockUserRepository();

  final binding = BindingsBuilder(() {
    AccountBinding().dependencies();
    Get.lazyReplace<AuthRepository>(() => authRepositoryMock);
    Get.lazyReplace<DeepLinkRepository>(() => deepLinkRepositoryMock);
    Get.lazyReplace<DynamicLinkConfig>(() => dynamicLinkConfigMock);
    Get.lazyReplace<RoleManagementRepository>(() => roleManagementRepositoryMock);
    Get.lazyReplace<UserRepository>(() => userRepositoryMock);
  });

  setUpAll(() async {
    await Firebase.initializeApp();
    when(roleManagementRepositoryMock.getRoles(any))
      .thenAnswer(((_) async => Future.value(
        RoleManagementResponse(
          code: 200,
          message: "test",
          data: [
            RoleManagementData(
              id: "testRoleId",
              createdAt: DateTime(2023, 1, 10, 10),
              updatedAt: DateTime(2023, 1, 10, 10),
              deletedAt: DateTime(2023, 1, 10, 10),
              name: ContentConstant.ROLE_MERCHANT_EMPLOYEE,
              isRoot: true,
              status: true,
              permissions: [["testPermission"]]
            )
          ],
          pageInfo: RoleManagementPageInfo(
            totalRecord: 1,
            totalPage: 1,
            offset: 1,
            limit: 10,
            prevPage: 0,
            nextPage: 2
          )
        )
      )
    ));
    binding.builder();
    controller = Get.find<BumblebeeMerchantUserManagementController>();
  });

  tearDownAll(() {
    Get.delete<BumblebeeMerchantUserManagementController>();
  });

  group('Test Bumblebee Merchant User Controller', () {
    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeMerchantUserManagementController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));

      expect(Get.isRegistered<BumblebeeMerchantUserManagementController>(), true);
    });

    test('fetch api role list on error', (() async {
      //arrange
      when(roleManagementRepositoryMock.getRoles(any))
        .thenAnswer(((_) async => throw Exception("error")));

      //act
      await controller.fetchRoles();

      //assert
      expect(controller.isLoading.value, false);
    }));

    test('fetch api role list on success', (() async {
      //arrange
      when(roleManagementRepositoryMock.getRoles(any))
        .thenAnswer(((_) async => Future.value(
          RoleManagementResponse(
            code: 200,
            message: "test",
            data: [
              RoleManagementData(
                id: "testRoleId1",
                createdAt: DateTime(2023, 1, 10, 10),
                updatedAt: DateTime(2023, 1, 10, 10),
                deletedAt: DateTime(2023, 1, 10, 10),
                name: ContentConstant.ROLE_MERCHANT_EMPLOYEE,
                isRoot: true,
                status: true,
                permissions: [["testPermission1"]]
              )
            ],
            pageInfo: RoleManagementPageInfo(
              totalRecord: 1,
              totalPage: 1,
              offset: 1,
              limit: 10,
              prevPage: 0,
              nextPage: 2
            )
          )
        )
      ));

      //act
      await controller.fetchRoles();

      //assert
      expect(controller.merchantEmployeeRoleId, "testRoleId1");
      expect(controller.isLoading.value, false);
    }));

    test('fetch api user list on error', (() async {
      //arrange
      controller.merchantEmployeeRoleId = "testMerchantEmployeeRoleId";
      when(userRepositoryMock.fetchApiAllUsers(any, {"roles": [controller.merchantEmployeeRoleId]}))
        .thenAnswer(((_) async => throw Exception("error")));

      //act
      await controller.fetchUserList();

      //assert
      expect(controller.userList.isEmpty, true);
      expect(controller.isLoading.value, false);
    }));

    test('fetch api user list on success', (() async {
      //arrange
      controller.merchantEmployeeRoleId = "testMerchantEmployeeRoleId";
      when(userRepositoryMock.fetchApiAllUsers(any, {"roles": [controller.merchantEmployeeRoleId]})).thenAnswer(
        (_) async => Future.value(UserResponse(
          code: 200,
          message: "test",
          data: <UserItemResponse>[
            UserItemResponse(
              id: "testId1",
              supplier: Supplier(
                supplierId: "testSupplierId1",
                name: "testSupplierName1"
              ),
              name: "testName1",
              email: "testEmail1",
              phoneNumber: "testPhoneNumber1",
              role: Role(
                id: "testRoleId1",
                name: "testRoleName1"
              ),
              fcmToken: "testFcmToken1",
              verifiedAt: DateTime(2023, 1, 10, 10),
              createdAt: DateTime(2023, 1, 10, 8),
              updatedAt: DateTime(2023, 1, 10, 8),
              groupName: "testGroupName1",
              branchId: "testBranchId1",
              branchName: "testBranchName1",
              regionId: "testRegionId1",
              regionName: "testRegionName1",
              isVerified: true,
              emailVerifiedExpiredAt: null,
              emailVerifiedAfterRetry: null,
              emailVerifiedCount: 1,
              emailVerifiedMaxAttempt: 3,
            ),
            UserItemResponse(
              id: "testId2",
              supplier: Supplier(
                supplierId: "testSupplierId2",
                name: "testSupplierName2"
              ),
              name: "testName2",
              email: "testEmail2",
              phoneNumber: "testPhoneNumber2",
              role: Role(
                id: "testRoleId2",
                name: "testRoleName2"
              ),
              fcmToken: "testFcmToken2",
              verifiedAt: DateTime(2023, 1, 10, 10),
              createdAt: DateTime(2023, 1, 10, 8),
              updatedAt: DateTime(2023, 1, 10, 8),
              groupName: "testGroupName2",
              branchId: "testBranchId2",
              branchName: "testBranchName2",
              regionId: "testRegionId2",
              regionName: "testRegionName2",
              isVerified: true,
              emailVerifiedExpiredAt: null,
              emailVerifiedAfterRetry: null,
              emailVerifiedCount: 1,
              emailVerifiedMaxAttempt: 3,
            ),
          ],
          pageInfo: UserPageInfo(
            totalRecord: 1,
            totalPage: 1,
            offset: 1,
            limit: 10,
            prevPage: 0,
            nextPage: 2
          )
        ))
      );

      //act
      await controller.fetchUserList();

      //assert
      expect(controller.userList.isNotEmpty, true);
      expect(controller.isLoading.value, false);
    }));

    test('create json request parameter', (() {
      //arrange
      //act
      var result = controller.createJsonRequestParameter();

      //assert
      expect(result, {"roles": [controller.merchantEmployeeRoleId]});
    }));

    test('get timer duration with retry at difference more than 0 minutes', (() {
      //arrange
      initializeDateFormatting();

      var retryAt = DateTime.now().add(Duration(minutes: 5));

      //act
      var result = controller.getTimerDuration(retryAt: retryAt);

      //assert
      expect(result.inMinutes <= 5, true);
    }));

    test('get timer duration with retry at finished', (() {
      //arrange
      var retryAt = DateTime.now().subtract(Duration(minutes: 1));

      //act
      var result = controller.getTimerDuration(retryAt: retryAt);

      //assert
      expect(result, null);
    }));

    test('get timer duration with created at difference less than 5 minutes', (() {
      //arrange
      var createdAt = DateTime.now().subtract(Duration(minutes: 2));

      //act
      var result = controller.getTimerDuration(createdAt: createdAt);

      //assert
      expect(result.inMinutes <= 3, true);
    }));

    test('get timer duration with created at difference more than 5 minutes', (() {
      //arrange
      var createdAtLess = DateTime.now().subtract(Duration(minutes: 6));

      //act
      var result = controller.getTimerDuration(createdAt: createdAtLess);

      //assert
      expect(result, null);
    }));

    test('convert to iso date format', (() {
      //arrange
      //act
      var dateTime = DateTime.parse("2023-02-26T16:21:26.349215+07:00");
      var result = controller.convertToISODateFormat(dateTime, true);

      //assert
      expect(result, DateTime.parse("2023-02-26 16:21:26.349"));
    }));

    test('reload user list', (() async {
      //arrange
      //act
      await controller.reloadUserList();

      //assert
      expect(controller.userList.isNotEmpty, true);
      expect(controller.isLoading.value, false);
    }));
    
    test('get token', (() async {
      //arrange
      when(authRepositoryMock.getTokenEmail(any, any)).thenAnswer(((_) async => Future.value(
        GetTokenResponse(
          data: GetTokenData(
            token: "testToken"
          )
        )
      )));

      //act
      var result = await controller.getToken();

      //assert
      expect(result, "testToken");
    }));

    test('create dynamic link function', () async {
      //arrange
      controller.token = "fk9cm52Nr3EQMseY7";
      var email = "test@email.com";

      when(dynamicLinkConfigMock.createDynamicLink(
        controller.token, deepLinkRepositoryMock, email, "create", "new-password"
      )).thenAnswer(((_) async => Future.value("https://deasy.page.link/fk9cm52Nr3EQMseY7")));
      
      String url = await controller.createDynamicLink(controller.token, email);

      expect(url, "https://deasy.page.link/fk9cm52Nr3EQMseY7");
    });

    test('set token url', (() async {
      //arrange
      var email = "test@email.com";

      when(authRepositoryMock.getTokenEmail(any, any)).thenAnswer(((_) async => Future.value(
        GetTokenResponse(
          data: GetTokenData(
            token: "testToken"
          )
        )
      )));

      //act
      await controller.setTokenAndUrl(email);

      //assert
      expect(controller.token, "testToken");
    }));

    test('resend email', (() async {
      //arrange
      var email = "test@email.com";
      when(authRepositoryMock.getTokenEmail(any, any)).thenAnswer(((_) async => Future.value(
        GetTokenResponse(
          data: GetTokenData(
            token: "testToken"
          )
        )
      )));

      //act
      await controller.resendEmail(email);

      //assert
      expect(controller.isLoading.value, true);
    }));

    test('create request password email', () {
      //arrange
      var email = "test@email.com";
      var token = "fk9cm52Nr3EQMseY7";
      var url = "https://deasy.page.link/";
      var uri = Uri.parse("https://deasy.page.link/");

      //act
      var result = controller.createRequestPasswordMail(email, uri, token);

      expect(result, {
        "email": email,
        "token": token,
        "url": url,
        "type": "create_password"
      });
    });

    test('send email failed', (() async {
      //arrange
      var email = "test@email.com";
      var token = "fk9cm52Nr3EQMseY7";
      var url = "https://deasy.page.link/";
      var uri = Uri.parse("https://deasy.page.link/");
      
      when(authRepositoryMock.postPasswordEmail(any, any, any)).thenAnswer(((_) async => throw Exception("error")));

      //act
      await controller.sendEmail(email, uri, token);

      //assert
      expect(controller.isShowSuccessResendDialog, false);
    }));

    test('send email success', (() async {
      //arrange
      var email = "test@email.com";
      var token = "fk9cm52Nr3EQMseY7";
      var uri = Uri.parse("https://deasy.page.link/");

      when(authRepositoryMock.postPasswordEmail(any, any, any)).thenAnswer(((_) async => Future.value(
        PasswordMailResponse()
      )));

      //act
      await controller.sendEmail(email, uri, token);

      //assert
      expect(controller.isShowSuccessResendDialog, true);
    }));

    test('delete user success', (() async {
      //arrange
      var userId = "testUserId";

      when(userRepositoryMock.deleteAccount(any, any, any)).thenAnswer(((_) async => Future.value(
        DeleteAccountResponse(
          code: 200,
          data: DeleteAccountResponseData(
            isPending: false,
            message: "testDataMessage"
          ),
          message: "testMessage"
        )
      )));

      //act
      await controller.deleteUser(userId);

      //assert
      expect(controller.isShowSuccessDeleteDialog, true);
    }));

    test('delete user failed', (() async {
      //arrange
      var userId = "testUserId";
      
      when(userRepositoryMock.deleteAccount(any, any, any)).thenAnswer(((_) async => throw Exception("error")));

      //act
      await controller.deleteUser(userId);

      //assert
      expect(controller.isShowSuccessDeleteDialog, false);
    }));

    test('navigate to add user', () async {
      //arrange
      //act
      await controller.navigateToAddUser();

      //assert
      expect(controller.userList.isNotEmpty, true);
    });
  });
}
