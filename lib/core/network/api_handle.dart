import 'package:dio/dio.dart';
import 'api_response.dart';
import 'exceptions/dio_exceptions.dart';
import 'exceptions/server_exception.dart';

mixin ApiHandler {
  Future<ApiResponse<T>> handleApi<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return ApiResponse.success(response);
    } on ServerException catch (e) {
      return ApiResponse.error(e.message);
    } on NetworkException catch (e) {
      return ApiResponse.networkError(e.message);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        return ApiResponse.networkError("No Internet Connection");
      }
      if (e.type == DioExceptionType.unknown) {
        final custom = e.error?.toString();
        if (custom != null &&
            custom.isNotEmpty &&
            custom != 'null' &&
            !custom.contains('SocketException')) {
          return ApiResponse.error(custom);
        }
        return ApiResponse.networkError("No Internet Connection");
      }
      return ApiResponse.error(DioExceptions.fromDioError(e).toString());
    } catch (e) {
      return ApiResponse.error("Unexpected error occurred: ${e.toString()}");
    }
  }
}
