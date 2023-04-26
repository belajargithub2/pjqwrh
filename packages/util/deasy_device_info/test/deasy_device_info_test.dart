import 'package:flutter_test/flutter_test.dart';

import '../lib/deasy_device_info.dart';
import 'mock/deasy_device_info.dart';

void main() {
  late DeasyDeviceInfo deasyDeviceInfo;

  setUp(() {
    deasyDeviceInfo = DeasyDeviceInfoMock();
  });

  // test get device info
  test('get device info', () async {
    final result = await deasyDeviceInfo.getDeviceId();
    expect(result, 'tesid');
  });

  // test get device model
  test('get device model', () async {
    final result = await deasyDeviceInfo.getDeviceModel();
    expect(result, 'tesDeviceModel');
  });

  // test get device os
  test('get device os', () async {
    final result = await deasyDeviceInfo.getDeviceOs();
    expect(result, 'tesDeviceOs');
  });

  // test get browser type
  test('get browser type', () async {
    final result = await deasyDeviceInfo.getBrowserType();
    expect(result, 'tesBrowserType');
  });

  // test get browser version
  test('get browser version', () async {
    final result = await deasyDeviceInfo.getBrowserVersion();
    expect(result, 'tesBrowserVersion');
  });

}