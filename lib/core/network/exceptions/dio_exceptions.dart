import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late final String message;

  DioExceptions._internal(this.message);

  factory DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return DioExceptions._internal("Request to API server was cancelled");

      case DioExceptionType.connectionTimeout:
        return DioExceptions._internal("Connection timeout with API server");

      case DioExceptionType.sendTimeout:
        return DioExceptions._internal("Send timeout in connection with API server");

      case DioExceptionType.receiveTimeout:
        return DioExceptions._internal("Receive timeout in connection with API server");

      case DioExceptionType.unknown:
        return DioExceptions._internal(
            "Connection to API server failed due to internet connection");

      case DioExceptionType.badResponse:
        return DioExceptions._internal(
          _handleError(
            dioError.response?.statusCode,
            dioError.response?.data,
          ),
        );

      default:
        return DioExceptions._internal("Unexpected error occurred");
    }
  }

  static String _handleError(int? statusCode, dynamic error) {
    String? backendMessage;

    if (error is Map) {
      if (error.containsKey('message')) {
        backendMessage = error['message'];
      } else if (error.containsKey('error')) {
        backendMessage = error['error'];
      } else if (error['errors'] is List && error['errors'].isNotEmpty) {
        backendMessage = error['errors'][0]['message'] ?? error['errors'][0].toString();
      }
    }

    return backendMessage ?? _defaultMessage(statusCode);
  }

  static String _defaultMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 405:
        return 'Method not allowed';
      case 408:
        return 'Request timeout';
      case 409:
        return 'Conflict';
      case 410:
        return 'Gone';
      case 415:
        return 'Unsupported media type';
      case 422:
        return 'Unprocessable entity';
      case 429:
        return 'Too many requests';
      case 500:
        return 'Internal server error';
      case 501:
        return 'Not implemented';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      case 504:
        return 'Gateway timeout';
      case 505:
        return 'HTTP version not supported';
      default:
        return 'Oops! Something went wrong';
    }
  }

  @override
  String toString() => message;

  static DioExceptions handle(DioException error) =>
      DioExceptions.fromDioError(error);
}
