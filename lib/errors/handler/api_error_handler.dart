import 'dart:io';

import 'package:fake_store_api_package/errors/index_errors.dart';

/// This class is responsible for handling API-related errors and mapping them
/// to a standardized `ApiFailure` object. It ensures consistent error handling
/// throughout the application.
class ApiErrorHandler {
  /// Handles the given error and maps it to an `ApiFailure` object.
  ///
  /// The method checks the type of the error and returns an appropriate
  /// `ApiFailure` instance with a descriptive message and error type.
  ///
  /// - If the error is a `FetchFakeStoreException`, it maps it to a `notFound` error.
  /// - If the error is a `HandshakeException`, it maps it to a `networkError` with a certificate issue message.
  /// - If the error is a `SocketException`, it maps it to a `networkError` with a connection issue message.
  /// - If the error is an `HttpException`, it maps it to a `networkError` with an HTTP error message.
  /// - For any other error, it maps it to an `unKnown` error with a generic message.
  ///
  /// This ensures that all errors are handled in a predictable and consistent manner.
  ApiFailure handle(dynamic error) {
    if (error is FetchFakeStoreException) {
      return ApiFailure(
        message: error.message,
        error: FetchFakeStoreError.notFound,
      );
    } else if (error is HandshakeException) {
      return ApiFailure(
        message: 'Network security error: Unable to verify certificate',
        error: FetchFakeStoreError.networkError,
      );
    } else if (error is SocketException) {
      return ApiFailure(
        message: 'Network connection error: ${error.message}',
        error: FetchFakeStoreError.networkError,
      );
    } else if (error is HttpException) {
      return ApiFailure(
        message: 'HTTP error: ${error.message}',
        error: FetchFakeStoreError.networkError,
      );
    } else {
      return ApiFailure(
        message: 'Unexpected error occurred: ${error.toString()}',
        error: FetchFakeStoreError.unKnown,
      );
    }
  }
}
