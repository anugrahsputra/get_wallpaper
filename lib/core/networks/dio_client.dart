import 'package:dio/dio.dart';

const String contentType = 'application/json';

class DioClient {
  final Dio _dio;
  DioClient(this._dio);
  // DioClient(this._dio) {
  //   _dio.options = BaseOptions(
  //     baseUrl: Env.baseUrl,
  //     connectTimeout: const Duration(seconds: 15),
  //     receiveTimeout: const Duration(seconds: 15),
  //     sendTimeout: const Duration(seconds: 15),
  //     contentType: contentType,
  //   );

  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //       if (Env.apiKey.isNotEmpty) {
  //         options.headers['Authorization'] = Env.apiKey;
  //       }
  //       return handler.next(options);
  //     },
  //     onResponse: (response, handler) async {
  //       if (response.statusCode != 200) {
  //         throw ServerException();
  //       }
  //       return handler.next(response);
  //     },
  //     onError: (e, handler) async {
  //       log(e.message.toString());
  //       return handler.next(e);
  //     },
  //   ));
  // }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: FormData.fromMap(data),
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
