# deasy_buttons

Deasy internal package to provide button widgets

## Features

- Custom Action Button
- Custom Button
- Custom Elevated Button
- Primary Button
- Primary Stroked Button
- Rounded Selection Button

## Getting started
Add this import to use this package :
```
import 'package:deasy_buttons/deasy_buttons.dart';
```

## Usage

Show Custom Action Button
```
DeasyCustomActionButton(
    width: 100,
    height: 40,
    bgColor: DeasyColor.kpYellow500,
    bordedWidth: 1,
    borderColor: DeasyColor.kpYellow500,
    borderRadius: 8,
    onPressed: () {
        print('ON PRESS');
    },
    text: 'THIS',
    textColor: DeasyColor.neutral000,
    borderColor: DeasyColor.kpYellow500,
    padding: 0,
    fontSize: 16,
)
```

Show Custom Button
```
DeasyCustomButton(
    text: 'THIS',
    color: DeasyColor.kpYellow500,
    colorText: DeasyColor.neutral000,
    borderSideColor: DeasyColor.kpYellow500,
    onPressed: () {
        print('ON PRESS');
    },
    textStyle: TextStyle(fontWeight: FontWeight.w500),
    radius: 8.0,
    enable: true
)
```

Show Custom Elevated Button
```
DeasyCustomElevatedButton(
    primary: DeasyColor.kpYellow500,
    borderColor: DeasyColor.kpYellow500,
    onPress: () {
        print('ON PRESS');
    },
    paddingButton: 12,
    fontSize: 16.0,
    radius: 8.0,
    text: 'THIS',
    myKey: Key('key'),
    enable: true,
    textColor: DeasyColor,neutral000,
    icon: Icon(
        Icons.close,
        color: black,
    )
)
```

Show Primary Button
```
DeasyPrimaryButton(
    text: 'THIS',
    color: DeasyColor.kpYellow500,
    onPressed: () {
        print('ON PRESS');
    },
    textStyle: TextStyle(fontWeight: FontWeight.w500),
    radius: 8,
    width: 100,
    padding: EdgeInsets.all(4.0),
    leadIcon: Icon(
        Icons.close,
        color: black,
    ),
    suffixIcon: Icon(
        Icons.visibility,
        color: black,
    )
)
```

Show Primary Stroked Button
```
DeasyPrimaryStrokedButton(
    text: 'THIS',
    color: DeasyColor.kpYellow500,
    backGroundColor: DeasyColor.neutral000,
    onPressed: () {
        print('ON PRESS');
    },
    textStyle: TextStyle(fontWeight: FontWeight.w500),
    radius: 8,
    width: 100,
    padding: EdgeInsets.all(4.0),
)
```

Show Primary Rounded Selection Button
```
DeasyRoundedSelectionButton(
    btnImage: 'resources/images/btn_image.png',
    btnTitle: 'THIS',
    onPressed: () {
        print('ON PRESS');
    },
    sideColor: DeasyColor.neutral000,
)
```