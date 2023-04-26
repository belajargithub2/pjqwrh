## Features
- deasy dialog ui with button

## Getting started

- add `deasy_dialog: ^1.0.0` in `pubspec.yaml`
- run `flutter pub get`

## Usage
- One Button Dialog

![Alt text](https://github.com/KB-FMF/deasy/blob/DESY-2992-flutter-td-create-deasy-dialogs-package/packages/deasy_dialog/ss/onebtn.png)

```dart
import 'package:deasy_dialog/deasy_dialog.dart';
Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Get.defaultDialog(
        backgroundColor: white,
        content: DeasyDialogOneButton(
            buttonText: 'button text',
            contentTitle: 'Title',
            contetBody: const Text('Body'),
            btnPress: () {}
        ),
      );
    },
  );
}
```

- Two Button Vertical Dialog

![Alt text](https://github.com/KB-FMF/deasy/blob/DESY-2992-flutter-td-create-deasy-dialogs-package/packages/deasy_dialog/ss/twobtnver.png)

```dart
import 'package:deasy_dialog/deasy_dialog.dart';
Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Get.defaultDialog(
        backgroundColor: white,
        content: DeasyDialogTwoButtonVertical(
          icon: Icon(Icons.verified, color: Colors.blue, size: 50,),
          topButtonText: 'NO',
          bottomButtonText: 'YES',
          contentTitle: 'Dokumen gagal diunduh',
          contentBody: const Text('Body'),
          topBtnOnPress: () {
            Get.back();
          },
          bottomBtnOnPress: () {},
        ),
      );
    },
  );
}
```
- Two Button Horizontal Dialog

![Alt text](https://github.com/KB-FMF/deasy/blob/DESY-2992-flutter-td-create-deasy-dialogs-package/packages/deasy_dialog/ss/twobtn.png)

```dart
import 'package:deasy_dialog/deasy_dialog.dart';
Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return Get.defaultDialog(
        backgroundColor: white,
        content: DeasyDialogTwoButtonHorizontal(
          icon: Icon(Icons.verified, color: Colors.blue, size: 50,),
          leftButtonText: 'NO',
          rightButtonText: 'YES',
          contentTitle: 'Dokumen gagal diunduh',
          contentBody: const Text('Body'),
          topBtnOnPress: () {
            Get.back();
          },
          bottomBtnOnPress: () {},
        ),
      );
    },
  );
}
```

## Simple Dialog
<img src="https://user-images.githubusercontent.com/91040581/213652486-d9c35b6e-4112-41ac-89f7-9af2bbea6e1d.jpeg" width="190" height="400">
simple dialog with two button

### Usage
```dart
DeasyBaseDialogs.getInstance().simpleDialog(
  context: context,
  title: "title",
  subTitle: "subTitle",
  onPressButtonCancel: () {},
);
```

<img src="https://user-images.githubusercontent.com/91040581/213652502-4da3f984-fd98-4b34-b4b0-9d70eb8abf97.jpeg" width="190" height="400">
simple dialog with one button

### Usage
```dart
DeasyBaseDialogs.getInstance().simpleDialog(
  context: context,
  title: "title",
  subTitle: "subTitle",
);
```

<img src="https://user-images.githubusercontent.com/91040581/213652510-942c1b1e-2a29-4e3c-9ef0-28e2bc782fde.jpeg" width="190" height="400">
icon dialog with one button

### Usage
```dart
DeasyBaseDialogs.getInstance().iconDialog(
  context: context,
  title: "title",
  subTitle: "subTitle",
  icon: SvgPicture.asset(Path));
```

<img src="https://user-images.githubusercontent.com/91040581/213652518-3ac050d6-33b4-4f76-8a51-861bc45e1737.jpeg" width="190" height="400">
simple dialog with two button

### Usage
```dart
DeasyBaseDialogs.getInstance().iconDialog(
  context: context,
  title: "title",
  subTitle: "subTitle",
  onPressButtonCancel: () {
    Get.back();
  },  
  icon: SvgPicture.asset(Path));
```



## License Summary

Copyright 2023 by [KreditPlus](https://kreditplus.com/)

Contributing
------------

Please refer to each project's style and contribution guidelines for submitting patches and additions. In general, we follow the "fork-and-pull" Git workflow.

1. **Fork** the repo on GitHub
2. **Clone** the project to your own machine
3. **Commit** changes to your own branch
4. **Push** your work back up to your fork
5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!
