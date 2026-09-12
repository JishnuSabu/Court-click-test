import 'api_status.dart';

class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String? message;

  const ApiResponse({required this.status, this.data, this.message});

  factory ApiResponse.initial() => const ApiResponse(status: ApiStatus.initial);
  factory ApiResponse.loading() => const ApiResponse(status: ApiStatus.loading);
  factory ApiResponse.success(T data) =>
      ApiResponse(status: ApiStatus.success, data: data);
  factory ApiResponse.error(String message) =>
      ApiResponse(status: ApiStatus.error, message: message);
  factory ApiResponse.networkError(String message) =>
      ApiResponse(status: ApiStatus.networkError, message: message);
}
