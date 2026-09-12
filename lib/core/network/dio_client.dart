import 'package:court_click_task/utils/constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      queryParameters: {'api_key': AppConstants.apiKey},
      headers: {
        'Accept': 'application/json',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.queryParameters['api_key'] ??= AppConstants.apiKey;
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    int maxRetries = 2,
  }) async {
    int attempts = 0;
    while (attempts <= maxRetries) {
      try {
        final response = await _dio.get(
          uri,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response.data;
      } on DioException catch (e) {
        attempts++;
        final isConnectionReset = e.type == DioExceptionType.connectionError ||
            (e.message?.contains('reset by peer') ?? false) ||
            (e.error?.toString().contains('reset by peer') ?? false) ||
            (e.error?.toString().contains('104') ?? false);

        if (attempts <= maxRetries && isConnectionReset) {
          await Future.delayed(Duration(milliseconds: 300 * attempts));
        } else {
          rethrow;
        }
      }
    }
  }
}
