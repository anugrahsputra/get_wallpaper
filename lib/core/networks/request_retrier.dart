import 'dart:async';

import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RequestRetrier {
  final Dio dio;
  final InternetConnectionChecker internetConnectionChecker;

  RequestRetrier({required this.dio, required this.internetConnectionChecker});

  Future<Response> retryRequest(RequestOptions requestOptions) {
    late StreamSubscription subscription;
    final completer = Completer<Response>();

    subscription = internetConnectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        subscription.cancel();

        completer.complete(
          dio.request(
            requestOptions.path,
            cancelToken: requestOptions.cancelToken,
            data: requestOptions.data,
            onReceiveProgress: requestOptions.onReceiveProgress,
            onSendProgress: requestOptions.onSendProgress,
            queryParameters: requestOptions.queryParameters,
            options: Options(
              persistentConnection: requestOptions.persistentConnection,
              contentType: requestOptions.contentType,
              extra: requestOptions.extra,
              followRedirects: requestOptions.followRedirects,
              headers: requestOptions.headers,
              listFormat: requestOptions.listFormat,
              maxRedirects: requestOptions.maxRedirects,
              method: requestOptions.method,
              receiveDataWhenStatusError:
                  requestOptions.receiveDataWhenStatusError,
              receiveTimeout: requestOptions.receiveTimeout,
              requestEncoder: requestOptions.requestEncoder,
              responseDecoder: requestOptions.responseDecoder,
              responseType: requestOptions.responseType,
              sendTimeout: requestOptions.sendTimeout,
              validateStatus: requestOptions.validateStatus,
            ),
          ),
        );
      }
    });

    return completer.future;
  }
}
