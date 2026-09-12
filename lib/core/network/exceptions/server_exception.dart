import 'dio_exceptions.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});

  factory ServerException.fromDioException(DioException e) {
    return ServerException(message: DioExceptions.fromDioError(e).toString());
  }

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => message;
}
