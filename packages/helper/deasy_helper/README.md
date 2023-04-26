# deasy_helper

Deasy internal package to provide helper and utility.

## Features

- Date Extension
- String Extension
- String Helper

## Getting started

Add this import to use this package :
```
import 'package:deasy_helper/deasy_helper.dart';
```

## Usage

Get next 1 month from the sample DateTime (Date Extension):

```
DateTime resultDateTime = sampleDateTime.nextMonth(months: 1);
```

Check if sample text is a valid email address (String Extension):

```
bool resultBool = sampleText.isEmailAddress();
```

Generate random string of specific length (String Helper):

```
String resultString = DeasyStringHelper.getRandomString(length: 32);
```