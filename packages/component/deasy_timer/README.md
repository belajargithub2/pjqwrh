# deasy_timer

Deasy internal package to show countdown timer

## Features

- Show minutes timer widget

## Getting started
Add this import to use this package :
```
import 'package:deasy_timer/deasy_timer.dart';
```

## Usage

Show minutes timer widget
```
DeasyMinutesTimerWidget(
    duration: Duration(minutes: 5),
    fontColor: DeasyColor.neutral400,
    fontFamily: FontFamily.medium,
    fontSize: 12.0,
    onEnd: () {
        //..
    },
    visible: true,
)
```

### Parameters
- duration: the duration of the timer
- fontColor: countdown timer font color
- fontFamily: countdown timer font family (light, medium, bold)
- fontSize: countdown timer font size
- onEnd: method to be executed after the timer finished (00:00)
- visible: flag to show or hide the countdown timer