import 'package:dio/dio.dart';

import '../core.dart';

const String contentType = 'application/json';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  init() {
    _dio.options = BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: contentType,
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool requireToken = false,
  }) async {
    try {
      String token = '';
      if (requireToken) {
        token = Env.apiKey;
      }

      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': token,
          },
        ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
