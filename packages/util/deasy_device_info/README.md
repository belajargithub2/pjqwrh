
## Table OF Contents

* [Introduction](#introduction)
* [Installation](#installation)
* [Usage](#usage)

## Introduction
Deasy Device Info is a Flutter Package for getting device information.

## Installation
```dart
import 'package:deasy_device_info/deasy_device_info.dart';
```

## Usage
```dart
DeasyDeviceInfo deasyDeviceInfo = DeasyDeviceInfo();

void getDeviceInfo() async {
  String deviceId = await deasyDeviceInfo.getDeviceId();
  String deviceModel = await deasyDeviceInfo.getDeviceModel();
  String deviceOs = await deasyDeviceInfo.getDeviceOs();
  String browserType = await deasyDeviceInfo.getBrowserType();
  String browserVersion = await deasyDeviceInfo.getBrowserVersion();
}
```
