// Mocks generated by Mockito 5.3.2 from annotations
// in kreditplus_deasy_mobile/test/modules/agent_fee/repository/agent_fee_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i8;

import 'package:flutter/material.dart' as _i4;
import 'package:image_picker/image_picker.dart' as _i7;
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart' as _i6;
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart' as _i5;
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [DioClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockDioClient extends _i1.Mock implements _i2.DioClient {
  @override
  _i3.Future<dynamic> post(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? requestBody, {
    bool? isRegister = false,
    bool? isRefreshToken = false,
    bool? isReturnError = false,
    _i6.VersionApi? versionApi = _i6.VersionApi.V1,
    bool? showSnackbar = false,
    bool? getNewErrorMessage = false,
    bool? isReturnJson = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            context,
            scope,
            url,
            requestBody,
          ],
          {
            #isRegister: isRegister,
            #isRefreshToken: isRefreshToken,
            #isReturnError: isReturnError,
            #versionApi: versionApi,
            #showSnackbar: showSnackbar,
            #getNewErrorMessage: getNewErrorMessage,
            #isReturnJson: isReturnJson,
          },
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> multipartPost(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? requestBody, {
    bool? isRegister = false,
    bool? isRefreshToken = false,
    _i7.PickedFile? file,
    List<int>? fileBytes,
    String? flag,
    bool? isReturnError = false,
    String? fileName = r'',
    String? filePath = r'',
    dynamic method = _i2.Method.POST,
    bool? showSnackbar = false,
    bool? getErrorMessage = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #multipartPost,
          [
            context,
            scope,
            url,
            requestBody,
          ],
          {
            #isRegister: isRegister,
            #isRefreshToken: isRefreshToken,
            #file: file,
            #fileBytes: fileBytes,
            #flag: flag,
            #isReturnError: isReturnError,
            #fileName: fileName,
            #filePath: filePath,
            #method: method,
            #showSnackbar: showSnackbar,
            #getErrorMessage: getErrorMessage,
          },
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> delete(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? query, {
    bool? getNewErrorMessage = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [
            context,
            scope,
            url,
            query,
          ],
          {#getNewErrorMessage: getNewErrorMessage},
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> deleteWithoutQuery(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? requestBody,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteWithoutQuery,
          [
            context,
            scope,
            url,
            requestBody,
          ],
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> get(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? query, {
    _i6.VersionApi? versionApi = _i6.VersionApi.V1,
    bool? showSnackbar = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [
            context,
            scope,
            url,
            query,
          ],
          {
            #versionApi: versionApi,
            #showSnackbar: showSnackbar,
          },
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> getWithoutJsonResponse(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? query,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWithoutJsonResponse,
          [
            context,
            scope,
            url,
            query,
          ],
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<_i8.Uint8List?> getImage(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getImage,
          [
            context,
            scope,
            url,
          ],
        ),
        returnValue: _i3.Future<_i8.Uint8List?>.value(),
        returnValueForMissingStub: _i3.Future<_i8.Uint8List?>.value(),
      ) as _i3.Future<_i8.Uint8List?>);
  @override
  _i3.Future<dynamic> patch(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? requestBody, {
    bool? showSnackbar = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [
            context,
            scope,
            url,
            requestBody,
          ],
          {#showSnackbar: showSnackbar},
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> put(
    _i4.BuildContext? context,
    _i5.Scope? scope,
    String? url,
    Map<String, dynamic>? requestBody,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [
            context,
            scope,
            url,
            requestBody,
          ],
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
  @override
  _i3.Future<dynamic> request({
    required String? url,
    required _i2.Method? method,
    _i4.BuildContext? context,
    _i5.Scope? scope,
    bool? isRegister = false,
    bool? isReturnError = false,
    Map<String, dynamic>? requestBody,
    _i7.PickedFile? file,
    List<int>? fileBytes,
    String? flag = r'',
    bool? isReturnJson = true,
    _i6.VersionApi? versionApp,
    bool? showSnackbar = false,
    bool? getErrorMessage = false,
    String? fileName = r'',
    String? filePath = r'',
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #request,
          [],
          {
            #url: url,
            #method: method,
            #context: context,
            #scope: scope,
            #isRegister: isRegister,
            #isReturnError: isReturnError,
            #requestBody: requestBody,
            #file: file,
            #fileBytes: fileBytes,
            #flag: flag,
            #isReturnJson: isReturnJson,
            #versionApp: versionApp,
            #showSnackbar: showSnackbar,
            #getErrorMessage: getErrorMessage,
            #fileName: fileName,
            #filePath: filePath,
          },
        ),
        returnValue: _i3.Future<dynamic>.value(),
        returnValueForMissingStub: _i3.Future<dynamic>.value(),
      ) as _i3.Future<dynamic>);
}