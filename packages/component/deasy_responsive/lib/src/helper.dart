part of deasy_responsive;

enum DeasyDeviceType { android, ios, fuchsia, web, windows, mac, linux }

enum DeasyScreenType { mobile, tablet, desktop }

class Device {
  static late BoxConstraints boxConstraints;

  static late Orientation orientation;

  static late DeasyDeviceType deviceType;

  static late DeasyScreenType screenType;

  static late double blockHorizontal;

  static late double blockVertical;

  static late double height;

  static late double width;

  static late double aspectRatio;

  static late double pixelRatio;

  static void setScreenSize(
    BuildContext context,
    BoxConstraints constraints,
    Orientation currentOrientation,
  ) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    aspectRatio = constraints.constrainDimensions(width, height).aspectRatio;
    pixelRatio = _ambiguate(WidgetsBinding.instance)!.window.devicePixelRatio;

    blockHorizontal = boxConstraints.maxWidth / 100;
    blockVertical = boxConstraints.maxHeight / 100;

    if (kIsWeb) {
      deviceType = DeasyDeviceType.web;
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          deviceType = DeasyDeviceType.android;
          break;
        case TargetPlatform.iOS:
          deviceType = DeasyDeviceType.ios;
          break;
        case TargetPlatform.windows:
          deviceType = DeasyDeviceType.windows;
          break;
        case TargetPlatform.macOS:
          deviceType = DeasyDeviceType.mac;
          break;
        case TargetPlatform.linux:
          deviceType = DeasyDeviceType.linux;
          break;
        case TargetPlatform.fuchsia:
          deviceType = DeasyDeviceType.fuchsia;
          break;
      }
    }

    if (width >= 1300) {
      screenType = DeasyScreenType.desktop;
    } else if (width < 1300 && width >= 650) {
      screenType = DeasyScreenType.tablet;
    } else {
      screenType = DeasyScreenType.mobile;
    }
  }

  static T? _ambiguate<T>(T? value) => value;
}
