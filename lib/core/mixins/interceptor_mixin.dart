import 'dart:io';

import 'package:dio/dio.dart';

mixin InterceptorMixin on Interceptor {
  bool isBadRequest(DioException err) {
    return err.response?.statusCode == 400;
  }

  bool isUnauthorized(DioException err) {
    return err.response?.statusCode == 401;
  }

  bool isForbidden(DioException err) {
    return err.response?.statusCode == 403;
  }

  bool isNotFound(DioException err) {
    return err.response?.statusCode == 404;
  }

  bool isConnectionError(DioException err) {
    return (err.type == DioExceptionType.unknown &&
            err.error != null &&
            err.error is SocketException) ||
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout);
  }

  bool isUnknownError(DioException err) {
    return (err.type == DioExceptionType.unknown && err.error == null);
  }
}
