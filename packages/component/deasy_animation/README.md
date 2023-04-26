# deasy_animation

Deasy internal package for animation

## Features

- Fade in animation
- Side in animation
- Bounce animation

## Getting started
Add this import to use this package :
```
import 'package:deasy_animation/deasy_animation.dart';
```

## Usage

Fade in animation:

```
FadeInAnimation(
    delay: 1,
    child: Text(
        'Apakah anda yakin ingin melakukan  cancel order',
        style: TextStyle(
            fontSize: 12
            ),
        )
    ),
```

Side animation:
```
SideInAnimation(
    delay: 1,
    child: Text(
        'Apakah anda yakin ingin melakukan  cancel order',
        style: TextStyle(
            fontSize: 12
            ),
        )
    ),
```

Bounce animation:
```
BounceAnimation(
    duration: Duration(milliseconds: 100),
    scaleFactor: 1.5,
    onPressed: btnPress,
    child: Container(),
    )
```