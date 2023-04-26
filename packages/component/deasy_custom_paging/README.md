# deasy_custom_paging

Deasy internal package to provide custom paging

## Features

- Show Custom Paging Widget

## Getting started
Add this import to use this package :
```
import 'package:deasy_custom_paging/deasy_custom_paging.dart';
```

## Usage

Show custom paging widget

![Alt text](https://github.com/KB-FMF/deasy/blob/DESYM-361/packages/component/deasy_custom_paging/ss/custom_paging.png)

```
DeasyCustomPaging(
    whenEmptyLoad: false,
    delegate: DefaultLoadMoreDelegate(),
    isFinish: controller.isLoadMore.isFalse,
    textBuilder: DefaultLoadMoreTextBuilder.english,
    onLoadMore: () {
        //..
    },
    child: ListView.builder(
        primary: false,
        itemBuilder: (BuildContext context, int index) {
            return Text(dataList[index].name);
        },
        itemCount: dataList.length,
    ),
)
```

### Parameters
- whenEmptyLoad: True if data list will be loaded when it is empty
- delegate: Widget builder to displays the appropiate widget for every load state
- isFinish: True if there is no more data to be shown in the data list or reaching the end of data list
- textBuilder: The text builder to displays the appropiate text for every load state
- onLoadMore: Called when reaching the end of data list and need to load more data
- child: The scrollable widget (usally ListView) to be displayed and implement pagination
