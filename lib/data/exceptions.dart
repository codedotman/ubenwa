import 'package:ubenwa_cart/utils/constants.dart';

class CustomException implements Exception {
  String? message;
  String? prefix;
  int? responseCode;

  CustomException([this.message, this.prefix, this.responseCode]);

  @override
  String toString() => !isEmpty(message) ? message! : "Something went wrong";
  String toDetailedString() => '$prefix: $message: $responseCode';
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message, responseCode])
      : super(message, "Unauthorised", responseCode);
}

class NotFoundException extends CustomException {
  NotFoundException([message, responseCode])
      : super(message, "Not found", responseCode);
}

class BadRequestException extends CustomException {
  BadRequestException([message, responseCode])
      : super(message, "Bad request", responseCode);
}

class BadFormatException extends CustomException {
  BadFormatException({message, responseCode})
      : super(message ?? "Format Exception", "Format Exception", responseCode);
}
