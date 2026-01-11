class AppExceptions implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message, String? prefix])
    : super(message, "Error during communication");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message, String? prefix])
    : super(message, "Invalid request");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message, String? prefix])
    : super(message, "Unauthorized request ");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message, String? prefix])
    : super(message, "Invalid Input");
}
