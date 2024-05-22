enum ErrorMessage {
  authFailure,
  serverFailure,
  badRequestFailure,
  cacheFailure,
  networkFailure,
  forbiddenFailure,
  requestFailure,
  databaseFailure,
  unknownFailure,
}

extension ErrorMessageX on ErrorMessage {
  String get errorMessage {
    switch (this) {
      case ErrorMessage.authFailure:
        return 'Auth Failure';
      case ErrorMessage.serverFailure:
        return 'Server Failure';
      case ErrorMessage.badRequestFailure:
        return 'Bad Request Failure';
      case ErrorMessage.cacheFailure:
        return 'Cache Failure';
      case ErrorMessage.networkFailure:
        return 'Network Failure';
      case ErrorMessage.forbiddenFailure:
        return 'Forbidden Failure';
      case ErrorMessage.requestFailure:
        return 'Request Failure';
      case ErrorMessage.databaseFailure:
        return 'Database Failure';
      case ErrorMessage.unknownFailure:
        return 'Unknown Failure';
    }
  }
}
