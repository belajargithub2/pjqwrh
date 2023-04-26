# deasy_size_config

Deasy internal package to support screen size configuration of a divice

## Features

- Set screen size to specific constraint
- Get screen properties of a device

## Getting started
Add this import to use this package :
```
import 'package:deasy_size_config/deasy_size_config.dart';
```

## Usage

Initialize size config:

```
DeasySizeConfigUtils().init();
```

Set screen size:
```
Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return LayoutBuilder(
      builder: (context, constraints) {
        DeasySizeConfigUtils.setScreenSize(constraints);
        if (DeasySizeConfigUtils.isDesktopOrWeb) {
          return websiteOrDesktop;
        }
        else if (DeasySizeConfigUtils.isTab) {
          return tablet;
        }
        else {
          return mobile;
        }
      },
    );
  }
```

Get screen properties:
```
final height = DeasySizeConfigUtils.screenHeight;
final isMobile = DeasySizeConfigUtils.isMobile;
```