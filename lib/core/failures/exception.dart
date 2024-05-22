class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server Exception'});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'NetworkException'});

  @override
  String toString() => message;
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({this.message = 'UnauthorizedException'});

  @override
  String toString() => message;
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException({this.message = 'BadRequestException'});

  @override
  String toString() => message;
}

class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({this.message = 'ForbiddenException'});

  @override
  String toString() => message;
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException({this.message = 'ForbiddenException'});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'CacheException'});

  @override
  String toString() => message;
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException({this.message = 'DatabaseException'});

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  UnknownException({this.message = 'UnknownException'});

  @override
  String toString() => message;
}
