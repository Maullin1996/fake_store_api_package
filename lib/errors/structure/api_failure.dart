import 'package:fake_store_api_package/errors/index_errors.dart';

/// A class that represents an API failure.
/// Extends the [Failure] class to include additional information about the error.
class ApiFailure extends Failure {
  /// Creates an [ApiFailure] instance with the given [message] and [error].
  const ApiFailure({
    required String message,
    required FetchFakeStoreError error,
  }) : super(message, error);

  /// Creates an [ApiFailure] instance from a [FetchFakeStoreException].
  factory ApiFailure.fromException(FetchFakeStoreException exception) {
    return ApiFailure(message: exception.message, error: exception.error);
  }
}
