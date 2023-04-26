class CustomException implements Exception {
  final _message;

  CustomException([this._message]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message);
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message);
}

class NotFoundException extends CustomException {
  NotFoundException([message]) : super(message);
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message);
}

class NotAllowedException extends CustomException {
  NotAllowedException([String? message])
      : super(message);
}

class ToManyRequestException extends CustomException {
  ToManyRequestException([String? message])
      : super(message);
}

class ForbiddenException extends CustomException {
  ForbiddenException([String? message])
      : super(message);
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException([String? message])
      : super(message);
}
