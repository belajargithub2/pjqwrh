## Features
- check is web

## Getting started

- add `deasy_service: ^1.0.0` deasy_service in `pubspec.yaml`
- run `flutter pub get`

## Usage
```dart
import 'package:deasy_service/deasy_service.dart';

DeasyService service = DeasyService();
bool isWeb = service.getkIsWeb();
if(isWeb) {
  print('Yes, is web!');
}
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