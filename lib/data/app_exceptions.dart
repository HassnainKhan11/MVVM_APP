class AppException implements Exception {
  final _prefix;
  final _message;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message, 'Érror During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(String? message) : super(message, 'Invalid Request');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException(String? message)
      : super(message, 'Unauthorized Request');
}

class InvalidInputException extends AppException {
  InvalidInputException(String? message)
      : super(message, 'Unauthorized Request');
}
