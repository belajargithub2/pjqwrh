# deasy_circular_checkbox

Deasy internal package to provide circular checkbox

## Features

- Show Circular Checkbox

## Getting started
Add this import to use this package :
```
import 'package:deasy_circular_checkbox/deasy_circular_checkbox.dart';
```

## Usage

Show circular checkbox widget

![Alt text](https://github.com/KB-FMF/deasy/blob/DESYM-359/packages/component/deasy_circular_checkbox/ss/circular_check_box.png)

```
DeasyCircularCheckBox(
    checkedColor: DeasyColor.dms2ED477,
    animationDuration: Duration(milliseconds: 150),
    size: 20,
    isEnable: controller.isEnable.value,
    isChecked: controller.isChecked.value,
    onTap: (value) {
        //..
    },
)
```

### Parameters
- checkedColor: The color that fills the checkbox when this checkbox is checked
- uncheckedColor: The color that fills the checkbox when this checkbox is unchecked
- animationDuration: The animation duration when this checkbox is checked/unchecked
- size: The size of this checkbox
- isEnable: True if this checkbox is enable to be checked/unchecked
- isChecked: Whether this checkbox is checked
- onTap: Called when the checkbox is tapped (checked/unchecked)
- checkedWidget: Custom widget to be shown when this checkbox is checked
- uncheckedWidget: Custom widget to be shown when this checkbox is unchecked
- border: Custom border for this checkbox
- borderColor: Custom border color for this checkbox