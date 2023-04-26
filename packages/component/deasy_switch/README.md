# deasy_switch

Deasy internal package to show switch widget

## Features

- Show switch widget

## Getting started
Add this import to use this package :
```
import 'package:deasy_switch/deasy_switch.dart';
```

## Usage

Show switch widget
```
DeasySwitch(
    transitionType: TextTransitionTypes.FADE,
    rounded: true,
    isEnable: isEnable,
    duration: Duration(milliseconds: 500),
    forceWidth: true,
    value: isActive,
    onChanged: (v) {
        changeStatus(v);
    },
    onText: "",
    offText: "",
    offBkColor: DeasyColor.neutral400,
    onBkColor: DeasyColor.kpYellow400,
    offThumbColor: DeasyColor.neutral000,
    onThumbColor: DeasyColor.neutral000,
    thumbSize: 20.0,
)
```