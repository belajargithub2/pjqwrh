# Deasy Color
Deasy Color is a color package for the [Deasy]

## TABLE OF CONTENTS
- [Getting Started](#getting-started)
- [Features](#features)
- [Usage](#usage)
- [Colors](#colors)
    - [ KP BLUE ](#kp-blue)
    - [ KP YELLOW ](#kp-yellow)
    - [ DMS ](#dms)
    - [ PLATFORM ](#platform)
    - [ SALLY ](#sally)
    - [ FPS ](#fps)
    - [ NEUTRAL ](#neutral)
    - [ SEMANTIC ](#semantic)
        - [ DANGER ](#danger)
        - [ WARNING ](#warning)
        - [ SUCCESS ](#success)
        - [ INFO ](#info)

<a name="getting-started"></a>
## Getting Started
```dart
import 'package:deasy_color/deasy_color.dart';
```

<a name="features"></a>
## Features
- [x] Color Grouping from UI/UX playground
- [x] Combine colors

<a name="usage"></a>
## Usage
```dart
DeasyColor.dms800 // dms800 is colorName

Color color1 = DeasyHexColor("b74093");
Color color2 = DeasyHexColor("#b74093");
Color color3 = DeasyHexColor("#88b74093"); // If you wish to use ARGB format
```

Combine colors
```dart
DeasyColor.combine([DeasyColor.dms800, DeasyColor.dms900]) 
```

## Colors
<a name="kp-blue"></a>
### KP BLUE
- ![#005C94](https://placehold.co/15x15/005C94/005C94.png)  ``` #005C94 ```  DeasyColor.kpBlue900
- ![#087CB5](https://placehold.co/15x15/087CB5/087CB5.png)  ``` #087CB5 ```  DeasyColor.kpBlue800
- ![#098DC9](https://placehold.co/15x15/098DC9/098DC9.png)  ``` #098DC9 ```  DeasyColor.kpBlue700
- ![#14A1DC](https://placehold.co/15x15/14A1DC/14A1DC.png)  ``` #14A1DC ```  DeasyColor.kpBlue600
- ![#1BAEEA](https://placehold.co/15x15/1BAEEA/1BAEEA.png)  ``` #1BAEEA ```  DeasyColor.kpBlue500
- ![#37BAED](https://placehold.co/15x15/37BAED/37BAED.png)  ``` #37BAED ```  DeasyColor.kpBlue400
- ![#57C6EE](https://placehold.co/15x15/57C6EE/57C6EE.png)  ``` #57C6EE ```  DeasyColor.kpBlue300
- ![#84D7F3](https://placehold.co/15x15/84D7F3/84D7F3.png)  ``` #84D7F3 ```  DeasyColor.kpBlue200
- ![#B4E7F8](https://placehold.co/15x15/B4E7F8/B4E7F8.png)  ``` #B4E7F8 ```  DeasyColor.kpBlue100
- ![#EDFBFF](https://placehold.co/15x15/EDFBFF/EDFBFF.png)  ``` #EDFBFF ```  DeasyColor.kpBlue50
- ![#F9FEFF](https://placehold.co/15x15/F9FEFF/F9FEFF.png)  ``` #F9FEFF ```  DeasyColor.kpBlue25

<a name="kp-yellow"></a>
### KP YELLOW
- ![#FE6806](https://placehold.co/15x15/FE6806/FE6806.png)  ``` #FE6806 ```  DeasyColor.kpYellow900
- ![#FE8903](https://placehold.co/15x15/FE8903/FE8903.png)  ``` #FE8903 ```  DeasyColor.kpYellow800
- ![#FF9A00](https://placehold.co/15x15/FF9A00/FF9A00.png)  ``` #FF9A00 ```  DeasyColor.kpYellow700
- ![#FFAD00](https://placehold.co/15x15/FFAD00/FFAD00.png)  ``` #FFAD00 ```  DeasyColor.kpYellow600
- ![#FFBC00](https://placehold.co/15x15/FFBC00/FFBC00.png)  ``` #FFBC00 ```  DeasyColor.kpYellow500
- ![#FFC525](https://placehold.co/15x15/FFC525/FFC525.png)  ``` #FFC525 ```  DeasyColor.kpYellow400
- ![#FFD04C](https://placehold.co/15x15/FFD04C/FFD04C.png)  ``` #FFD04C ```  DeasyColor.kpYellow300
- ![#FFDD80](https://placehold.co/15x15/FFDD80/FFDD80.png)  ``` #FFDD80 ```  DeasyColor.kpYellow200
- ![#FFEAB2](https://placehold.co/15x15/FFEAB2/FFEAB2.png)  ``` #FFEAB2 ```  DeasyColor.kpYellow100
- ![#FFF7E0](https://placehold.co/15x15/FFF7E0/FFF7E0.png)  ``` #FFF7E0 ```  DeasyColor.kpYellow50
- ![#FFFBF0](https://placehold.co/15x15/FFFBF0/FFFBF0.png)  ``` #FFFBF0 ```  DeasyColor.kpYellow25

<a name="dms"></a>
### DMS
- ![#3B3674](https://placehold.co/15x15/3B3674/3B3674.png)  ``` #3B3674 ```  DeasyColor.dms900
- ![#4F4A82](https://placehold.co/15x15/4F4A82/4F4A82.png)  ``` #4F4A82 ```  DeasyColor.dms800
- ![#625E90](https://placehold.co/15x15/625E90/625E90.png)  ``` #625E90 ```  DeasyColor.dms700
- ![#76729E](https://placehold.co/15x15/76729E/76729E.png)  ``` #76729E ```  DeasyColor.dms600
- ![#8986AC](https://placehold.co/15x15/8986AC/8986AC.png)  ``` #8986AC ```  DeasyColor.dms500
- ![#9D9BB9](https://placehold.co/15x15/9D9BB9/9D9BB9.png)  ``` #9D9BB9 ```  DeasyColor.dms400
- ![#B0AFC7](https://placehold.co/15x15/B0AFC7/B0AFC7.png)  ``` #B0AFC7 ```  DeasyColor.dms300
- ![#C4C3D5](https://placehold.co/15x15/C4C3D5/C4C3D5.png)  ``` #C4C3D5 ```  DeasyColor.dms200
- ![#D7D7E3](https://placehold.co/15x15/D7D7E3/D7D7E3.png)  ``` #D7D7E3 ```  DeasyColor.dms100
- ![#F2F2F6](https://placehold.co/15x15/F2F2F6/F2F2F6.png)  ``` #F2F2F6 ```  DeasyColor.dms50

<a name="platform"></a>
### PLATFORM
- ![#1C314A](https://placehold.co/15x15/1C314A/1C314A.png)  ``` #1C314A ```  DeasyColor.platform900
- ![#2F4562](https://placehold.co/15x15/2F4562/2F4562.png)  ``` #2F4562 ```  DeasyColor.platform800
- ![#3E5879](https://placehold.co/15x15/3E5879/3E5879.png)  ``` #3E5879 ```  DeasyColor.platform700
- ![#4F6B90](https://placehold.co/15x15/4F6B90/4F6B90.png)  ``` #4F6B90 ```  DeasyColor.platform600
- ![#5D7AA2](https://placehold.co/15x15/5D7AA2/5D7AA2.png)  ``` #5D7AA2 ```  DeasyColor.platform500
- ![#748DB3](https://placehold.co/15x15/748DB3/748DB3.png)  ``` #748DB3 ```  DeasyColor.platform400
- ![#8BA2C5](https://placehold.co/15x15/8BA2C5/8BA2C5.png)  ``` #8BA2C5 ```  DeasyColor.platform300
- ![#A9BDDC](https://placehold.co/15x15/A9BDDC/A9BDDC.png)  ``` #A9BDDC ```  DeasyColor.platform200
- ![#C4D8F3](https://placehold.co/15x15/C4D8F3/C4D8F3.png)  ``` #C4D8F3 ```  DeasyColor.platform100
- ![#E5EEFF](https://placehold.co/15x15/E5EEFF/E5EEFF.png)  ``` #E5EEFF ```  DeasyColor.platform50

<a name="sally"></a>
### SALLY
- ![#413CB4](https://placehold.co/15x15/413CB4/413CB4.png)  ``` #413CB4 ```  DeasyColor.sally900
- ![#445ED4](https://placehold.co/15x15/445ED4/445ED4.png)  ``` #445ED4 ```  DeasyColor.sally800
- ![#4670E7](https://placehold.co/15x15/4670E7/4670E7.png)  ``` #4670E7 ```  DeasyColor.sally700
- ![#4782FC](https://placehold.co/15x15/4782FC/4782FC.png)  ``` #4782FC ```  DeasyColor.sally600
- ![#4592FF](https://placehold.co/15x15/4592FF/4592FF.png)  ``` #4592FF ```  DeasyColor.sally500
- ![#53A3FF](https://placehold.co/15x15/53A3FF/53A3FF.png)  ``` #53A3FF ```  DeasyColor.sally400
- ![#96C9FF](https://placehold.co/15x15/96C9FF/96C9FF.png)  ``` #96C9FF ```  DeasyColor.sally300
- ![#96C9FF](https://placehold.co/15x15/96C9FF/96C9FF.png)  ``` #96C9FF ```  DeasyColor.sally200
- ![#BFDDFF](https://placehold.co/15x15/BFDDFF/BFDDFF.png)  ``` #BFDDFF ```  DeasyColor.sally100
- ![#ECF6FF](https://placehold.co/15x15/ECF6FF/ECF6FF.png)  ``` #ECF6FF ```  DeasyColor.sally50

<a name="fps"></a>
### FPS
- ![#583B94](https://placehold.co/15x15/583B94/583B94.png) ``` #583B94 ``` DeasyColor.fps900
- ![#6544A9](https://placehold.co/15x15/6544A9/6544A9.png) ``` #6544A9 ``` DeasyColor.fps800
- ![#714DBE](https://placehold.co/15x15/714DBE/714DBE.png) ``` #714DBE ``` DeasyColor.fps700
- ![#7E55D3](https://placehold.co/15x15/7E55D3/7E55D3.png) ``` #7E55D3 ``` DeasyColor.fps600
- ![#8B66D7](https://placehold.co/15x15/8B66D7/8B66D7.png) ``` #8B66D7 ``` DeasyColor.fps500
- ![#9877DC](https://placehold.co/15x15/9877DC/9877DC.png) ``` #9877DC ``` DeasyColor.fps400
- ![#A588E0](https://placehold.co/15x15/A588E0/A588E0.png) ``` #A588E0 ``` DeasyColor.fps300
- ![#BFAAE9](https://placehold.co/15x15/BFAAE9/BFAAE9.png) ``` #BFAAE9 ``` DeasyColor.fps200
- ![#D8CCF2](https://placehold.co/15x15/D8CCF2/D8CCF2.png) ``` #D8CCF2 ``` DeasyColor.fps100
- ![#F1F1FF](https://placehold.co/15x15/F1F1FF/F1F1FF.png) ``` #F1F1FF ``` DeasyColor.fps50

<a name="neutral"></a>
### NEUTRAL
- ![#131313](https://placehold.co/15x15/131313/131313.png) ``` #131313 ``` DeasyColor.neutral900
- ![#333333](https://placehold.co/15x15/333333/333333.png) ``` #333333 ``` DeasyColor.neutral800
- ![#515151](https://placehold.co/15x15/515151/515151.png) ``` #515151 ``` DeasyColor.neutral700
- ![#646464](https://placehold.co/15x15/646464/646464.png) ``` #646464 ``` DeasyColor.neutral600
- ![#8B8B8B](https://placehold.co/15x15/8B8B8B/8B8B8B.png) ``` #8B8B8B ``` DeasyColor.neutral500
- ![#ACACAC](https://placehold.co/15x15/ACACAC/ACACAC.png) ``` #ACACAC ``` DeasyColor.neutral400
- ![#D1D1D1](https://placehold.co/15x15/D1D1D1/D1D1D1.png) ``` #D1D1D1 ``` DeasyColor.neutral300
- ![#E3E3E3](https://placehold.co/15x15/E3E3E3/E3E3E3.png) ``` #E3E3E3 ``` DeasyColor.neutral200
- ![#EEEEEE](https://placehold.co/15x15/EEEEEE/EEEEEE.png) ``` #EEEEEE ``` DeasyColor.neutral100
- ![#F7F7F7](https://placehold.co/15x15/F7F7F7/F7F7F7.png) ``` #F7F7F7 ``` DeasyColor.neutral50
- ![#FFFFFF](https://placehold.co/15x15/FFFFFF/FFFFFF.png) ``` #FFFFFF ``` DeasyColor.neutral000

## SEMANTIC
<a name="danger"></a>
### DANGER
- ![#FCF2F1](https://placehold.co/15x15/FCF2F1/FCF2F1.png) ``` #FCF2F1 ``` DeasyColor.semanticDanger100
- ![#E59C98](https://placehold.co/15x15/E59C98/E59C98.png) ``` #E59C98 ``` DeasyColor.semanticDanger200
- ![#CB3A31](https://placehold.co/15x15/CB3A31/CB3A31.png) ``` #CB3A31 ``` DeasyColor.semanticDanger300
- ![#A93029](https://placehold.co/15x15/A93029/A93029.png) ``` #A93029 ``` DeasyColor.semanticDanger400
- ![#872721](https://placehold.co/15x15/872721/872721.png) ``` #872721 ``` DeasyColor.semanticDanger500

- <a name="warning"></a>
### WARNING
- ![#FFF8EE](https://placehold.co/15x15/FFF8EE/FFF8EE.png) ``` #FFF8EE ``` DeasyColor.semanticWarning100
- ![#FFC880](https://placehold.co/15x15/FFC880/FFC880.png) ``` #FFC880 ``` DeasyColor.semanticWarning200
- ![#FF9100](https://placehold.co/15x15/FF9100/FF9100.png) ``` #FF9100 ``` DeasyColor.semanticWarning300
- ![#D57900](https://placehold.co/15x15/D57900/D57900.png) ``` #D57900 ``` DeasyColor.semanticWarning400
- ![#AA6100](https://placehold.co/15x15/AA6100/AA6100.png) ``` #AA6100 ``` DeasyColor.semanticWarning500

<a name="success"></a>
### SUCCESS
- ![#F2F8F5](https://placehold.co/15x15/F2F8F5/F2F8F5.png) ``` #F2F8F5 ``` DeasyColor.semanticSuccess100
- ![#A1C9B6](https://placehold.co/15x15/A1C9B6/A1C9B6.png) ``` #A1C9B6 ``` DeasyColor.semanticSuccess200
- ![#43936C](https://placehold.co/15x15/43936C/43936C.png) ``` #43936C ``` DeasyColor.semanticSuccess300
- ![#387B5A](https://placehold.co/15x15/387B5A/387B5A.png) ``` #387B5A ``` DeasyColor.semanticSuccess400
- ![#2D6248](https://placehold.co/15x15/2D6248/2D6248.png) ``` #2D6248 ``` DeasyColor.semanticSuccess500

<a name="info"></a>
### INFO
- ![#EEF8FE](https://placehold.co/15x15/EEF8FE/EEF8FE.png) ``` #EEF8FE ``` DeasyColor.semanticInfo100
- ![#80C8F4](https://placehold.co/15x15/80C8F4/80C8F4.png) ``` #80C8F4 ``` DeasyColor.semanticInfo200
- ![#0091EA](https://placehold.co/15x15/0091EA/0091EA.png) ``` #0091EA ``` DeasyColor.semanticInfo300
- ![#0079C3](https://placehold.co/15x15/0079C3/0079C3.png) ``` #0079C3 ``` DeasyColor.semanticInfo400
- ![#00619C](https://placehold.co/15x15/00619C/00619C.png) ``` #00619C ``` DeasyColor.semanticInfo500
