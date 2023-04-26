# deasy_size_config

Deasy internal package to support snackbar

## Features

- Show snackbar
- Show flushbar error
- Show flushbar delete

## Getting started
Add this import to use this package :
```
import 'package:deasy_snackbar/deasy_snackbar.dart';
```

## Usage

Show snackbar
```
SnackBarUtil.showSnackBar(context, snackbarMessage);
```

Show flushbar error
```
SnackBarUtil.showFlushBarError(context, snackbarMessage);
```

Show flushbar delete
```
SnackBarUtil.showFlushBarDelete(context, Fucntion onUndo);
```