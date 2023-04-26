# Deasy Responsive
Deasy Responsive helps implement a responsive layout by providing helper widgets and extensions 

## TABLE OF CONTENTS
- [Getting Started](#getting-started)
- [Features](#features)
- [Example](#example)
- [Usage](#usage)
- [Note](#note)

## FEATURES
- [x] Responsive Layout
- [x] Platform Detection
- [x] Screen Detection
- [x] Extensions support

## Example
https://user-images.githubusercontent.com/91040581/212291388-3fa773d3-d599-4f49-b80b-115bfd02e46d.mov


## GETTING STARTED
Add the following import to your file:
```dart
import 'package:deasy_responsive/deasy_responsive.dart';
```

## USAGE
```dart
DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return Scaffold(
            body: Center(
              child: Text('Desktop', style: TextStyle(fontSize: 20.sp)),
            ),
          );
        }

        if (screenType == DeasyScreenType.tablet) {
          return Scaffold(
            body: Center(
              child: Text('Tablet', style: TextStyle(fontSize: 20.sp)),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: Text('Mobile', style: TextStyle(fontSize: 20.sp)),
          ),
        );
      },
    );
```

## NOTE
This package is a combination of size_config.dart and extensions.dart
